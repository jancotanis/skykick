# Skykick Office365 backup API

[![Version](https://img.shields.io/gem/v/skykick.svg)](https://rubygems.org/gems/skykick)
[![Maintainability](https://api.codeclimate.com/v1/badges/a340908aaf944745eeda/maintainability)](https://codeclimate.com/github/jancotanis/skykick/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a340908aaf944745eeda/test_coverage)](https://codeclimate.com/github/jancotanis/skykick/test_coverage)

This is a wrapper for the Skykick Office365 backup API.
You can see the [API endpoints](https://developers.skykick.com/apis)

Currently only the GET requests to endpoints /Backup and /Alerts
are implemented (readonly).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'skykick'
```

And then execute:

```console
> bundle install
```

Or install it yourself as:

```console
> gem install skykick
```

## Usage

Before you start making the requests to API provide the client id and client secret
and email/password using the configuration wrapping.

```ruby
require 'skykick'

Skykick.configure do |config|
  config.client_id = ENV["SKYKICK_CLIENT_ID"]
  config.client_secret = ENV["SKYKICK_CLIENT_SECRET"]
end
@client = Skykick.client()
@client.login

dc = @client.datacenters

dc.each do |t|
  puts "#{t.name}"
end
```

## Resources

### Authentication

```ruby
# setup configuration
#
client.login
```

|Resource|API endpoint|
|:--|:--|
|.auth_token or .login|https://apis.cloudservices.connectwise.com/auth/token|

### Backup

Endpoint for backup related requests

```ruby
subscriptions = client.subscriptions
```

|Resource|API endpoint|
|:--|:--|
|autodiscover          |https://apis.cloudservices.connectwise.com/Backup/{id}/autodiscover|
|datacenters           |https://apis.cloudservices.connectwise.com/Backup/datacenters|
|exchange_mailboxe     |https://apis.cloudservices.connectwise.com/Backup/{id}/mailboxes/{mailboxId}|
|exchange_mailboxes    |https://apis.cloudservices.connectwise.com/Backup/{id}/mailboxes|
|lastsnapshotstats     |https://apis.cloudservices.connectwise.com/Backup/{backupServiceId}/lastsnapshotstats|
|retention_periods     |https://apis.cloudservices.connectwise.com/Backup/{id}/retentionperiod|
|sharePoint_sites      |https://apis.cloudservices.connectwise.com/Backup/{id}/sites|
|sku                   |https://apis.cloudservices.connectwise.com/Backup/{id}/sku|
|storage_settings      |https://apis.cloudservices.connectwise.com/Backup/{id}/storagesettings|
|subscription_settings |https://apis.cloudservices.connectwise.com/Backup/{id}/subscriptionsettings|
|subscriptions         |https://apis.cloudservices.connectwise.com/Backup/|
|partner_subscriptions(partner_id)|https://apis.cloudservices.connectwise.com/Backup/{partner_id}|

### Alerts

Returns Alerts for a provided Email Migration Order ID or Backup service ID.

```ruby
subscriptions = client.subscriptions
alerts = client.alerts(subscriptions.first.id)

```

|Resource|API endpoint|
|:--|:--|
|.alerts|/Alerts|

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/jancotanis/skykick).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
