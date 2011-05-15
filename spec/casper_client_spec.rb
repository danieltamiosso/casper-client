require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Casper::Client do
      
  describe 'a basic flow of generation of a report' do
    
    before(:each) do
      RestClient.stub!(:post).and_return('report')
    end

    it 'should build the correct request to a report with a xml file as datasource' do
      RestClient.should_receive(:post).with(
        'http://casper.jrs-labs.com:8080',
        {:casper =>
              {
                :jrxml => Base64.encode64(open(File.join(File.dirname(__FILE__),'data/report.jrxml')).read),
                :data => Base64.encode64(open(File.join(File.dirname(__FILE__),'data/dataset.xml')).read),
                :xpath => '//root'
              }
        }.to_json, :content_type => :json, :accept => :json
      )
      report = Casper::Client.build do |report|
        report.template = open(File.join(File.dirname(__FILE__),'data/report.jrxml'))
        report.xml = open(File.join(File.dirname(__FILE__),'data/dataset.xml'))
        report.xpath = '//root'
      end
    end

    it 'should build the correct request to a report with a xml file as datasource with a optional host' do
      RestClient.should_receive(:post).with(
        'http://myserver',
        {:casper =>
              {
                :jrxml => Base64.encode64(open(File.join(File.dirname(__FILE__),'data/report.jrxml')).read),
                :data => Base64.encode64(open(File.join(File.dirname(__FILE__),'data/dataset.xml')).read),
                :xpath => '//root'
              }
        }.to_json, :content_type => :json, :accept => :json
      )
      report = Casper::Client.build :host => 'http://myserver' do |report|
        report.template = open(File.join(File.dirname(__FILE__),'data/report.jrxml'))
        report.xml = open(File.join(File.dirname(__FILE__),'data/dataset.xml'))        
        report.xpath = '//root'
      end
    end
    
 
    it 'should build the correct request to a report with a xml string as datasource' do
      RestClient.should_receive(:post).with(
        'http://mycasperserver.com',
        {:casper =>
              {
                :jrxml => Base64.encode64(open(File.join(File.dirname(__FILE__),'data/report.jrxml')).read),
                :data => Base64.encode64('<model/>'),
                :xpath => '//root'
              }
        }.to_json, :content_type => :json, :accept => :json
      )
      report = Casper::Client.build :host => 'http://mycasperserver.com' do |report|
        report.template = open(File.join(File.dirname(__FILE__),'data/report.jrxml'))
        report.xml = '<model/>'
        report.xpath = '//root'
      end
    end
    
    it 'should build the correct request to a report without a block as param' do
      RestClient.should_receive(:post).with(
        'http://casper.jrs-labs.com:8080',
        {:casper =>
              {
                :jrxml => Base64.encode64(open(File.join(File.dirname(__FILE__),'data/report.jrxml')).read),
                :data => Base64.encode64(open(File.join(File.dirname(__FILE__),'data/dataset.xml')).read),
                :xpath => '//root'
              }
        }.to_json, :content_type => :json, :accept => :json
      )
      report = Casper::Client.report(
        :template => open(File.join(File.dirname(__FILE__),'data/report.jrxml')),
        :xml => open(File.join(File.dirname(__FILE__),'data/dataset.xml')),
        :xpath => '//root'
      )  
    end

  end

end