require 'rest_client'
require 'json'
require 'base64'

module Casper
  
  class Client
    
    @@options = {
      :host => 'http://casper.jrs-labs.com:8080',
      :type => 'pdf'
    }
    
    def self.pdf options={}
      options[:type] = 'pdf'
      self.report options
    end
    
    def self.xls options={}
      options[:type] = 'xls'
      self.report options
    end
    
    def self.report options={}
      options = @@options.merge!(options)
      Client.build options do |report| 
        report.template = options[:template]
        report.xml = options[:xml]
        report.xpath = options[:xpath]
        report.type = options[:type]
      end
    end
    
    def self.options options={}
      @@options.merge!(options)
    end  
    
    private
    
    def self.build(options={}, &block)
      report = Report.new
      report.instance_eval(&block)
      RestClient.post options[:host], report.to_json, :content_type => :json, :accept => :json
    end

  end
  
  class Report
      attr_accessor :xml, :template, :xpath, :type
      
      def to_json
        {:casper =>
              {
                :jrxml => Base64.encode64(self.template.read),
                :data => Base64.encode64((self.xml.kind_of? File) ? self.xml.read : xml),
                :xpath => self.xpath,
                :type => self.type
              }
        }.to_json
      end
      
  end

end