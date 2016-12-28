# frozen_string_literal: true
require 'securerandom'

class Site < ApplicationRecord
  EMAIL_ADDRESS_DOMAIN = 'emailmarketing.report'
  EMAIL_ADDRESS_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze()

  #attr_accessor :name, :url, :email_address, :verified

  has_many :emails
  has_many :reports, :through => :emails

  validates :name, {:presence => true}
  validates :url, {:presence => true, :uniqueness => true}
  validate do #TODO Better validation
    begin
      URI.parse(self.url)
    rescue URI::InvalidURIError
      errors.add(:url, :format)
    end
  end
  validates :email_address, {:presence => true, :uniqueness => true}
  validate do #TODO Better validation
    self.email_address.to_s() =~ EMAIL_ADDRESS_REGEXP
  end
  validates :verified, {:inclusion => [true, false]}

  after_initialize do
    self.email_address ||= "#{SecureRandom.hex()}@#{EMAIL_ADDRESS_DOMAIN}"
  end
end
