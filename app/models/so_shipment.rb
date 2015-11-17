class SoShipment < ActiveRecord::Base
  belongs_to :sales_order
  belongs_to :customer_account
end
