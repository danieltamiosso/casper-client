require 'rest_client'

module Casper

  class Client

    attr_reader :options
        
    def self.build(options={}, &block)
      options = {:host => 'http://casper.jrs-labs.com:8080'}.merge!(options)
      report = Report.new
      report.instance_eval(&block)
      RestClient.post options[:host], {'casper[jrxml]' => report.template, 'casper[data]' => report.xml, 'casper[xpath]' => report.xpath}
    end
  
  end
  
  class Report
      attr_accessor :xml, :template, :xpath
  end

end