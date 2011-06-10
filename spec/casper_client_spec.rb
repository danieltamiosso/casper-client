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
      report = Casper::Client.report(
        :template => open(File.join(File.dirname(__FILE__),'data/report.jrxml')),
        :xml => open(File.join(File.dirname(__FILE__),'data/dataset.xml')),
        :xpath => '//root'
      )
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
      report = Casper::Client.report(
        :template => open(File.join(File.dirname(__FILE__),'data/report.jrxml')),
        :xml => open(File.join(File.dirname(__FILE__),'data/dataset.xml')),
        :xpath => '//root',
        :host => 'http://myserver'
      )
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
      report = Casper::Client.report(
        :template => open(File.join(File.dirname(__FILE__),'data/report.jrxml')),
        :xml => '<model/>',
        :xpath => '//root',
        :host => 'http://mycasperserver.com'
      )
    end
    
    
    it 'should be possible to configure the client directly from a single point' do
      Casper::Client.options[:host] = 'http://host.config.com'
      RestClient.should_receive(:post).with(
        'http://host.config.com',
        {:casper =>
              {
                :jrxml => Base64.encode64(open(File.join(File.dirname(__FILE__),'data/report.jrxml')).read),
                :data => Base64.encode64('<model/>'),
                :xpath => '//root'
              }
        }.to_json, :content_type => :json, :accept => :json
      )
      report = Casper::Client.report(
        :template => open(File.join(File.dirname(__FILE__),'data/report.jrxml')),
        :xml => '<model/>',
        :xpath => '//root',
        :host => 'http://host.config.com'
      )
    end
    
  end

end