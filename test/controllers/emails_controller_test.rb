require 'test_helper'

class EmailsControllerTest < ActionDispatch::IntegrationTest
  def setup()
    @site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com'})
  end

  test "show" do
    email = @site.emails.create!({:message => Mail::Message.new().encoded()})
    get email_url(email)
  end
end
