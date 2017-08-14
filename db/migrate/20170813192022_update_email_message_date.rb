
class UpdateEmailMessageDate < ActiveRecord::Migration[5.0]
  def up
    change_table(:emails) do |t|
      t.datetime :sent_at, :null => true
    end
    Email.reset_column_information
    Email.find_each do |email|
      email.sent_at = email.mail_message.date rescue email.created_at
      email.save!
    end
    change_column_null(:emails, :sent_at, false)
  end

  def down
    change_table(:emails) do |t|
      t.remove(:sent_at)
    end
  end
end
