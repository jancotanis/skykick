require 'Dotenv'
require 'logger'
require "test_helper"

CLIENT_LOGGER = "client_test.log"
File.delete(CLIENT_LOGGER) if File.exist?(CLIENT_LOGGER)


describe 'client' do
  before do
    Dotenv.load
    Skykick.configure do |config|
      config.client_id = ENV["SKYKICK_CLIENT_ID"]
      config.client_secret = ENV["SKYKICK_CLIENT_SECRET"]
    end
    @client = Skykick.client()
    @client.login
  end
  it "#1 GET /Backup/datacenters" do
    dc = @client.datacenters

    assert dc.count > 0, ".count > 0" 
    refute_empty dc.first.name, ".name not empty" 
  end
  it "#2 GET /Backup/id/subscriptionsettings" do
    subs = @client.subscriptions
    assert subs.count > 0, ".count > 0" 

    # get details and chekc if correct company name
    sub = @client.subscription_settings( subs.first.id )
    assert value(sub.CustomerInformation.CompanyName).must_equal(subs.first.companyName), " check subscription settings with subscription" 
  end
  it "#3 GET /Backup/id/*" do

    sub = @client.subscriptions.first
    id = sub.id
    assert @client.storage_settings(id).count > 0, '.storage_settings(id).count > 0'
    assert @client.sku(id).count > 0, '.sku(id).count > 0'
    assert @client.sharepoint_sites(id).count > 0, '.sharepoint_sites(id).count > 0'
    assert @client.retentionperiod(id).count > 0, '.retentionperiod(id).count > 0'
    assert @client.lastsnapshotstats(id).count > 0, '.lastsnapshotstats(id).count > 0'
    mbxs = @client.exchange_mailboxes(id)
    assert mbxs, '.exchange_mailboxes(id)'
    mbx = mbxs.IndividualMailboxes.first
    assert @client.exchange_mailbox(id, mbx.SubscriptionId).count > 0 if mbx
    assert @client.autodiscover(id), '.autodiscover(id)' 
  end
  it "#4 GET /Alerts/id" do
    assert alerts, '.alerts(.subscriptions.first.id)'
    @client.mark_as_complete(alerts.first.Id)
    assert alerts.count > @client.alerts(subscription_id).count, "less alerts as one is completed"
  end
end
