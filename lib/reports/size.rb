require 'reports/base'

module Reports
  class Size < Base
    def create(email)
      report = super(email)

      _size = size(email.mail_message())
      return if _size.nil?()

      report.metric = Metric::Numeric.new({:value => _size})
      report.save!()
      report
    end


  protected
    def size(mail_message)
      mail_message.header.fields.reject! do |field|
        field.name == 'Received'
      end
      mail_message.encoded().bytesize()
    end
  end
end
