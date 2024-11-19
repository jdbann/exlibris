module LinksHelper
  LINK_EXPRESSIONS = [
    {name: :match, icon: :itch, regex: /(?<name>itch\.io)/},
    {name: "DriveThruRPG", icon: :dtrpg, regex: /^(?:https?:\/\/)?(?:www\.)?drivethrurpg.com\/?/},
    {name: "Dropbox", icon: :dropbox, regex: /^(?:https?:\/\/)?(?:www\.)?dropbox.com\/?/},
    {name: "Facebook", icon: :facebook, regex: /^(?:https?:\/\/)?(?:www\.)?facebook.com\/?/},
    {name: "Google", icon: :google, regex: /^(?:https?:\/\/)?(?:www\.)?google.com\/?/},
    {name: "Mörk Borg", icon: :morkborg, regex: /^(?:https?:\/\/)?(?:www\.)?morkborg.com\/?/},
    {name: :match, icon: :link, regex: /^(?:https?:\/\/)?(?:www\.)?(?<name>[\w\d\-.]+)\/?/}
  ]

  def link_name(link)
    expression = link_expression(link)

    if expression[:name] == :match
      return expression[:regex].match(link.address)["name"]
    end

    expression[:name]
  end

  def link_icon(link)
    link_expression(link)[:icon]
  end

  private

  def link_expression(link)
    LINK_EXPRESSIONS.detect do |expression|
      link.address =~ expression[:regex]
    end
  end
end
