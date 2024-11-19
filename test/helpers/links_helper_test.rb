require "test_helper"

class LinksHelperTest < ActionView::TestCase
  context "#link_name" do
    should "should shorten itch links" do
      link = links(:eat_prey_kill_itch)

      assert_equal "itch.io", link_name(link)
    end

    should "should return DriveThruRPG for drivethrurpg.com links" do
      link = Link.new(address: "https://drivethrurpg.com/content/")

      assert_equal "DriveThruRPG", link_name(link)
    end

    should "should return Dropbox for dropbox.com links" do
      link = Link.new(address: "https://dropbox.com/content/")

      assert_equal "Dropbox", link_name(link)
    end

    should "should return Facebook for facebook.com links" do
      link = Link.new(address: "https://facebook.com/content/")

      assert_equal "Facebook", link_name(link)
    end

    should "should return Google for google.com links" do
      link = Link.new(address: "https://google.com/content/")

      assert_equal "Google", link_name(link)
    end

    should "should return Mörk Borg for morkborg.com links" do
      link = Link.new(address: "https://morkborg.com/content/")

      assert_equal "Mörk Borg", link_name(link)
    end

    should "should return domain for other links" do
      link = Link.new(address: "https://liberludorum.com/content/")

      assert_equal "liberludorum.com", link_name(link)
    end
  end

  context "#link_icon" do
    should "should return :itch for itch links" do
      link = links(:eat_prey_kill_itch)

      assert_equal :itch, link_icon(link)
    end

    should "should return :dtrpg for drivethrurpg.com links" do
      link = Link.new(address: "https://drivethrurpg.com/content/")

      assert_equal :dtrpg, link_icon(link)
    end

    should "should return :dropbox for dropbox.com links" do
      link = Link.new(address: "https://dropbox.com/content/")

      assert_equal :dropbox, link_icon(link)
    end

    should "should return :facebook for facebook.com links" do
      link = Link.new(address: "https://facebook.com/content/")

      assert_equal :facebook, link_icon(link)
    end

    should "should return :google for google.com links" do
      link = Link.new(address: "https://google.com/content/")

      assert_equal :google, link_icon(link)
    end

    should "should return :morkborg for morkborg.com links" do
      link = Link.new(address: "https://morkborg.com/content/")

      assert_equal :morkborg, link_icon(link)
    end

    should "should return :link for other links" do
      link = Link.new(address: "https://liberludorum.com/content/")

      assert_equal :link, link_icon(link)
    end
  end
end
