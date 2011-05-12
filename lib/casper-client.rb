require 'rest_client'
require 'json'
require 'base64'

module Casper

  class Client

    attr_reader :options
        
    def self.build(options={}, &block)
      options = {:host => 'http://casper.jrs-labs.com:8080'}.merge!(options)
      report = Report.new
      report.instance_eval(&block)
      RestClient.post options[:host], report.to_json, :content_type => :json, :accept => :json
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