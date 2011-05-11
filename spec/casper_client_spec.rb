require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Casper::Client do
  
  TEMPLATE = open(File.join(File.dirname(__FILE__), 'data', 'report.jrxml'))
  DATASET = open(File.join(File.dirname(__FILE__), 'data','dataset.xml'))
    
  describe 'a basic flow of generation of a report' do
    
    before(:each) do
      RestClient.stub!(:post).and_return('report')
    end

    it 'should build the correct request to a report with a xml datasource' do
      RestClient.should_receive(:post).with(
        'http://casper.jrs-labs.com:8080',
        {'casper[jrxml]'=> TEMPLATE, 
          'casper[data]'=> DATASET, 
          'casper[xpath]'=>'//root'
        }
      )
      report = Casper::Client.build do |report|
        report.xml = DATASET
        report.template = TEMPLATE
        report.xpath = '//root'
      end
    end
    
    it 'should build the correct request to a report with a xml datasource with a optional host' do
      RestClient.should_receive(:post).with(
        'http://mycasperserver.com',
        {'casper[jrxml]'=> TEMPLATE, 
          'casper[data]'=> DATASET, 
          'casper[xpath]'=> '//root'
        }
      )
      report = Casper::Client.build :host => 'http://mycasperserver.com' do |report|
        report.xml = DATASET
        report.template = TEMPLATE
        report.xpath = '//root'
      end
    end

  end

end