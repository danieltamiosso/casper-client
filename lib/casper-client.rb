require 'rest_client'
require 'json'
require 'base64'

module Casper

  class Client

    DEFAULT_HOST = 'http://casper.jrs-labs.com:8080'
        
    def self.build(options={}, &block)
      options = {:host => DEFAULT_HOST}.merge!(options)
      report = Report.new
      report.instance_eval(&block)
      RestClient.post options[:host], report.to_json, :content_type => :json, :accept => :json
    end
    
    def self.report options={}
      Client.build options do |report| 
        report.template = options[:template]
        report.xml = options[:xml]
        report.xpath = options[:xpath]
      end
    end

  end
  
  class Report
      attr_accessor :xml, :template, :xpath
      
      def to_json
        {:casper =>
              {
                :jrxml => Base64.encode64(self.template.read),
                :data => Base64.encode64((self.xml.kind_of? File) ? self.xml.read : xml),
                :xpath => self.xpath
              }
        }.to_json
      end
      
  end

end