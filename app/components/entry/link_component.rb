class Entry::LinkComponent < ViewComponent::Base
  LINK_EXPRESSIONS = [
    {name: :match, icon: :itch, regex: /^(?:https?:\/\/)?(?<name>[\w\d\-]+.itch\.io)/},
    {name: "DriveThruRPG", icon: :dtrpg, regex: /^(?:https?:\/\/)?(?:www\.)?drivethrurpg.com\/?/},
    {name: "Dropbox", icon: :dropbox, regex: /^(?:https?:\/\/)?(?:www\.)?dropbox.com\/?/},
    {name: "Facebook", icon: :facebook, regex: /^(?:https?:\/\/)?(?:www\.)?facebook.com\/?/},
    {name: "Google", icon: :google, regex: /^(?:https?:\/\/)?(?:www\.)?google.com\/?/},
    {name: "Mörk Borg", icon: :morkborg, regex: /^(?:https?:\/\/)?(?:www\.)?morkborg.com\/?/},
    {name: :match, icon: :link, regex: /^(?:https?:\/\/)?(?:www\.)?(?<name>[\w\d\-.]+)\/?/}
  ]

  with_collection_parameter :url

  delegate :highlight_link_to, to: :helpers

  attr_reader :url

  def initialize(url:)
    @url = url
  end

  def title
    expression = link_expression

    if expression[:name] == :match
      return expression[:regex].match(url)["name"]
    end

    expression[:name]
  end

  def icon_component
    IconComponent.new(type: link_expression[:icon])
  end

  private

  def link_expression
    LINK_EXPRESSIONS.detect do |expression|
      url =~ expression[:regex]
    end
  end
end
