module Amazon
  module MWS
    module Feed

    module Enumerations

      # Note: We do not handle flat file feed types
      FEED_TYPES = {
        :product_data              => '_POST_PRODUCT_DATA_',
        :product_relationship_data => '_POST_PRODUCT_RELATIONSHIP_DATA_',
        :item_data                 => '_POST_ITEM_DATA_',
        :product_overrides         => '_POST_PRODUCT_OVERRIDES_DATA_',
        :product_image_data        => '_POST_PRODUCT_IMAGE_DATA_',
        :product_pricing           => '_POST_PRODUCT_PRICING_DATA_',
        :inventory_availability    => '_POST_INVENTORY_AVAILABILITY_DATA_',
        :order_acknowledgement     => '_POST_ORDER_ACKNOWLEDGEMENT_DATA_',
        :order_fulfillment         => '_POST_ORDER_FULFILLMENT_DATA_',
        :payment_adjustment        => '_POST_PAYMENT_ADJUSTMENT_DATA_',
        :store                     => '_POST_STOREINFO_DATA_', #this is not documented in the public API
        # :flat_file_listings              => '_POST_FLAT_FILE_LISTINGS_DATA_',
        # :flat_file_order_acknowledgement => '_POST_FLAT_FILE_ORDER_ACKNOWLEDGEMENT_DATA_',
        # :flat_file_fulfillment_data      => '_POST_FLAT_FILE_FULFILLMENT_DATA_',
        # :flat_file_payment_adjustment    => '_POST_FLAT_FILE_PAYMENT_ADJUSTMENT_DATA_',
        # :flat_file_invloader             => '_POST_FLAT_FILE_INVLOADER_DATA_'
      }

      MESSAGE_TYPES = [
        "FulfillmentCenter",
        "Inventory",
        "OrderAcknowledgement",
        "OrderAdjustment",
        "OrderFulfillment",
        "OrderReport",
        "Override",
        "Price",
        "ProcessingReport",
        "Product",
        "ProductImage",
        "Relationship",
        "SettlementReport",
        "Store"
      ]
      
      PRODUCT_MESSAGE_TYPES = [
        "Product",
        "Price",
        "ProductImage",
        "Relationship",
        "Inventory"
      ]
      
      PROCESSING_STATUSES = {
        :submitted => '_SUBMITTED_',
        :in_progress => '_IN_PROGRESS_',
        :done => '_DONE_',
        :completed => '_COMPLETED_'
      }
      
    end

    end
  end
end
