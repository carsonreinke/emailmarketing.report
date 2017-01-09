require 'test_helper'

class EmailControllerTest < ActionDispatch::IntegrationTest
  def setup()
    @site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com'})
  end

  test "preview" do
    email = @site.emails.create!({:message => Mail::Message.new().encoded()})
    get email_preview_url(email.id)
  end
end
