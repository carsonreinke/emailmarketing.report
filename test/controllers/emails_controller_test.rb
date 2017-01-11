require 'test_helper'

class EmailsControllerTest < ActionDispatch::IntegrationTest
  def setup()
    @site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com'})
  end

  test "show" do
    email = @site.emails.create!({:message => Mail::Message.new().encoded()})
    get email_url(email)
    assert_response :ok
  end

  test "show part" do
    message = Mail::Message.new()
    message.text_part = 'Test'
    email = @site.emails.create!({:message => message.encoded()})
    get email_url(email, {:params => {:part => 'text/plain'}})
    assert_response :ok
  end

  test "show part with attachment" do
    message = Mail.new do
      subject 'Test'
      attachment = add_file File.join(Rails.root, 'test', 'fixtures', 'files', '1x1.png')
    end
    message.html_part do
      body %(<html><body><img src="cid:#{message.attachments.first.cid}"></body></html>)
    end
    email = @site.emails.create!({:message => message.encoded()})

    get email_url(email, {:params => {:part => 'text/html'}})
    assert_response :ok
    assert_select "img:match('src', ?)", /^data:/
  end

  test "show missing part" do
    email = @site.emails.create!({:message => Mail::Message.new().encoded()})
    assert_raises AbstractController::ActionNotFound do
      get email_url(email, {:params => {:part => 'text/html'}})
    end
  end
end
