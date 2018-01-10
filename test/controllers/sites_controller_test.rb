require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    #@site = Site.create!({:url => 'http://example.com/'})
  end

  teardown do
    #@site.destroy
  end

  test "should get new" do
    get new_site_url
    assert_response :success
  end

  test "should create site" do
    assert_difference('Site.count') do
      post sites_url, params: { site: { url: 'http://example.com' } }
    end
    assert_response :success
  end

  test "should create site with domain" do
    assert_difference('Site.count') do
      post sites_url, params: { site: { url: 'example.com' } }
    end
    assert_response :success
  end
end
