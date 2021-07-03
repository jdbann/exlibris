class Entry < ApplicationRecord
  DEFAULT_DESCRIPTION = <<~HTML
    <div>
      <strong>Concept:</strong> <br>
      <strong>Content:</strong> <br>
      <strong>Writing:</strong> <br>
      <strong>Art/design:</strong> <br>
      <strong>Usability:</strong>&nbsp;
    </div>
  HTML

  has_and_belongs_to_many :tags
  has_many :links, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validate :description_not_default

  has_one_attached :cover
  has_rich_text :description

  accepts_nested_attributes_for :links, allow_destroy: true, reject_if: :all_blank

  scope :containing, ->(query) { content_containing(query).or(name_containing(query)) }
  scope :content_containing, ->(query) { joins(:rich_text_description).merge(ActionText::RichText.with_body_containing(query)) }
  scope :name_containing, ->(query) { where("to_tsvector('en', entries.name) @@ websearch_to_tsquery(unaccent(:query))", query: query) }
  scope :with_includes, -> { includes(:cover_blob, :links, rich_text_description: {embeds_attachments: :blob}, tags: :rich_text_description, cover_attachment: :blob) }

  def category_tags
    tags.where(tag_category: TagCategory.find_by(name: "Categories"))
  end

  private

  def description_not_default
    return if description.nil?
    return if description.body.to_plain_text.squish !=
      ActionText::Content.new(DEFAULT_DESCRIPTION).to_plain_text.squish

    errors.add(:description, :default)
  end
end
