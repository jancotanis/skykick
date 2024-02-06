module Skykick
  class Client

    # All backup related api calls
    # @see https://developers.skykick.com/
    module Backup

      # Returns a list of supported Azure data centers.
      def datacenters
          get('Backup/datacenters')
      end

      # Gets a list of placed Backup subscription orders
      def subscriptions()
          get('Backup')
      end

      # Gets a list of placed Backup subscription orders
      def partner_subscriptions(partner_id)
          get("Backup/#{partner_id}")
      end

      # Returns Backup subscription settings. Settings include the enabled 
      # state for Exchange and SharePoint Backups and total count of enabled
      # Exchange mailboxes and SharePoint sites as well as the state of the subscription.
      def subscription_settings(id)
          get("Backup/#{id}/subscriptionsettings")
      end

      # Returns storage settings for a Backup subscription.
      def storage_settings(id)
          get("Backup/#{id}/storagesettings")
      end

      # Gets SKU/promo details for a Backup service.
      def sku(id)
          get("Backup/#{id}/sku")
      end

      # Returns a list of SharePoint site URLs and statuses (enabled/disabled)
      # for a Backup subscription.
      def sharepoint_sites(id)
          get("Backup/#{id}/sites")
      end

      # Returns the data retention periods for a Backup subscription. There are different
      # retention periods for Exchange and SharePoint Data.
      #
      # Please Note: We are aware of the spelling error of the word "retention" in the response 
      # field ExchangeRentionPeriodInDays. This is not a mistake in the documentation, but has 
      # been left this way as not to disrupt any existing integrations with this endpoint.
      def retentionperiod(id)
          get("Backup/#{id}/retentionperiod")
      end

      # Gets stats for snapshots from SKDataWarehouse for all mailboxes of a given backupServiceId
      def lastsnapshotstats(id)
          get("Backup/#{id}/lastsnapshotstats")
      end

      # Returns a list of Exchange mailboxes and statuses (enabled/disabled) for a Backup subscription.
      def exchange_mailboxes(id)
          get("Backup/#{id}/mailboxes")
      end

      # Returns a list of Exchange mailboxes and statuses (enabled/disabled) for a Backup subscription.
      def exchange_mailbox(id, mailbox_id)
          get("Backup/#{id}/mailboxes/#{mailbox_id}")
      end

      # Returns the Exchange and SharePoint auto-discover states (enabled/disabled) of a Backup subscription.
      def autodiscover(id)
          get("Backup/#{id}/autodiscover")
      end
    end
  end
end
