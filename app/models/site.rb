# frozen_string_literal: true
require 'securerandom'
require 'metainspector'

class Site < ApplicationRecord
  EMAIL_ADDRESS_DOMAIN = 'emailmarketing.report'
  EMAIL_ADDRESS_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze()

  #attr_accessor :name, :url, :email_address, :verified

  has_many :emails, :dependent => :destroy
  has_many :reports, :through => :emails

  validates :name, {:presence => true}
  validates :url, {:presence => true, :uniqueness => true}
  validate do #TODO Better validation
    uri = begin
      URI.parse(self.url)
    rescue URI::InvalidURIError
      errors.add(:url, :format)
    end

    #Ensure we don't have an abnormal URL (e.g. mailto, FTP)
    unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
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
  before_validation do
    self.name ||= self.class.default_name(self.url)
  end

  class << self
    #
    # Clean the provided URL
    #
    def clean_url(url)
      url = url.to_s()
      url = url.prepend('http://') unless url.match(/^http(s)?:\/\//)
      uri = URI.parse(url)
      uri.path = '/'
      uri.query = nil
      uri.fragment = nil
      uri.normalize!()
      uri.to_s()
    end

    #
    # Generate name from the page title
    #
    def default_name(url)
      title = begin
        MetaInspector.new(url).title
      rescue
        Rails.logger.warn($!)
        nil
      end
      title || url
    end
  end
end
