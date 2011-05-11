# Casper Client

It's a simple api to the Casper Server (https://github.com/twilson63/casper_server/) a sinatra web service to the Casper Reports (a jasperreports wrapper in jruby).
With this client you can send a jrxml template, a xml document and a xpath string and get the report.

# Install

```
gem install casper-client
```

# Usage Examples

Using the default service:

```
pdf = Casper::Client.build do |report|
  report.xml = # xml dataset
  report.template = # jrxml template
  report.xpath = # xpath query string
end
```

Using another host:

```
pdf = Casper::Client.build :host => 'http://mycasperserver.com' do |report|
  report.xml = # xml dataset
  report.template = # jrxml template
  report.xpath = # xpath query string
end
```