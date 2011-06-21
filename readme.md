# Casper Client

It's a simple api to the Casper Server (https://github.com/twilson63/casper_server/) a sinatra web service to the Casper Reports (a jasperreports wrapper in jruby).
With this client you can send a jrxml template, a xml document and a xpath string and get the report.

# Install

```
gem install casper-client
```

# Usage Examples

Default streaming is pdf:

```
report = Casper::Client.report(
  :template => # xml dataset,
  :xml => # jrxml template,
  :xpath => # xpath query string
)
```

Or you can specify the streaming type

```
xls = Casper::Client.xls(
  :template => # xml dataset,
  :xml => # jrxml template,
  :xpath => # xpath query string
)

pdf = Casper::Client.pdf(
  :template => # xml dataset,
  :xml => # jrxml template,
  :xpath => # xpath query string
)
```

To change the default web service to bind your reports, you can do:

```
Casper::Client.options[:host] = 'http://host.config.com'
```

Or you can inform by request:

```
report = Casper::Client.report(
  :template => # xml dataset,
  :xml => # jrxml template,
  :xpath => # xpath query string,
  :host => # host
)
```