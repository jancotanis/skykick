# frozen_string_literal: true

module Skykick
  class Client
    # Contains all backup-related API calls for managing Skykick backup subscriptions and settings.
    # This module provides methods to interact with backup services, including retrieving subscription
    # settings, storage settings, and mailbox information.
    #
    # @see https://developers.skykick.com/ Skykick Developer Documentation
    module Backup

      # Retrieves a list of supported Azure data centers.
      # @return [Array<Hash>] A list of Azure data centers supported by Skykick.
      # @example Fetch available data centers
      #   client.datacenters  # => Returns a list of supported data centers
      def datacenters
        get('Backup/datacenters')
      end

      # Retrieves a list of placed Backup subscription orders.
      # @return [Array<Hash>] A list of backup subscriptions.
      # @example Get all backup subscriptions
      #   client.subscriptions  # => Returns a list of placed backup subscription orders
      def subscriptions
        get('Backup')
      end

      # Retrieves a list of backup subscription orders for a specific partner.
      # @param partner_id [String] The unique identifier of the partner.
      # @return [Array<Hash>] A list of partner-specific backup subscriptions.
      # @example Get partner backup subscriptions
      #   client.partner_subscriptions('partner123')  # => Returns subscriptions for the partner
      def partner_subscriptions(partner_id)
        get("Backup/#{partner_id}")
      end

      # Retrieves backup subscription settings, including the state of Exchange and SharePoint Backups,
      # the number of enabled mailboxes and SharePoint sites, and the subscription state.
      # @param id [String] The subscription ID.
      # @return [Hash] Backup subscription settings.
      # @example Fetch subscription settings
      #   client.subscription_settings('sub123')  # => Returns backup subscription settings
      def subscription_settings(id)
        get("Backup/#{id}/subscriptionsettings")
      end

      # Retrieves storage settings for a backup subscription.
      # @param id [String] The subscription ID.
      # @return [Hash] Storage settings for the specified subscription.
      # @example Get storage settings
      #   client.storage_settings('sub123')  # => Returns storage settings
      def storage_settings(id)
        get("Backup/#{id}/storagesettings")
      end

      # Retrieves SKU or promotional details for a backup service.
      # @param id [String] The subscription ID.
      # @return [Hash] SKU or promotional details.
      # @example Fetch SKU details
      #   client.sku('sub123')  # => Returns SKU or promo details
      def sku(id)
        get("Backup/#{id}/sku")
      end

      # Retrieves a list of SharePoint site URLs and their statuses (enabled/disabled) for a backup subscription.
      # @param id [String] The subscription ID.
      # @return [Array<Hash>] A list of SharePoint site URLs and statuses.
      # @example Get SharePoint sites
      #   client.sharepoint_sites('sub123')  # => Returns a list of SharePoint sites and their statuses
      def sharepoint_sites(id)
        get("Backup/#{id}/sites")
      end

      # Retrieves the data retention periods for a backup subscription.
      # Different retention periods apply for Exchange and SharePoint data.
      #
      # @note There is a known spelling issue in the response field: `ExchangeRentionPeriodInDays`.
      #   This is intentional to avoid breaking existing integrations.
      # @param id [String] The subscription ID.
      # @return [Hash] Retention period details.
      # @example Get retention periods
      #   client.retentionperiod('sub123')  # => Returns retention periods for Exchange and SharePoint data
      def retentionperiod(id)
        get("Backup/#{id}/retentionperiod")
      end

      # Retrieves snapshot statistics from SKDataWarehouse for all mailboxes in a given backup subscription.
      # @param id [String] The subscription ID.
      # @return [Hash] Snapshot statistics for the mailboxes.
      # @example Fetch last snapshot stats
      #   client.lastsnapshotstats('sub123')  # => Returns snapshot stats for the subscription's mailboxes
      def lastsnapshotstats(id)
        get("Backup/#{id}/lastsnapshotstats")
      end

      # Retrieves a list of Exchange mailboxes and their statuses (enabled/disabled) for a backup subscription.
      # @param id [String] The subscription ID.
      # @return [Array<Hash>] A list of Exchange mailboxes and their statuses.
      # @example Get Exchange mailboxes
      #   client.exchange_mailboxes('sub123')  # => Returns a list of Exchange mailboxes and statuses
      def exchange_mailboxes(id)
        get("Backup/#{id}/mailboxes")
      end

      # Retrieves details of a specific Exchange mailbox in a backup subscription.
      # @param id [String] The subscription ID.
      # @param mailbox_id [String] The unique identifier of the mailbox.
      # @return [Hash] Details of the specified Exchange mailbox.
      # @example Get details of a specific mailbox
      #   client.exchange_mailbox('sub123', 'mailbox123')  # => Returns mailbox details
      def exchange_mailbox(id, mailbox_id)
        get("Backup/#{id}/mailboxes/#{mailbox_id}")
      end

      # Retrieves the auto-discover state (enabled/disabled) for Exchange and SharePoint backups in a subscription.
      # @param id [String] The subscription ID.
      # @return [Hash] Auto-discover states for Exchange and SharePoint.
      # @example Check auto-discover state
      #   client.autodiscover('sub123')  # => Returns the auto-discover state of the subscription
      def autodiscover(id)
        get("Backup/#{id}/autodiscover")
      end
    end
  end
end
