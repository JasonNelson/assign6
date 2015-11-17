class SalesOrder < ActiveRecord::Base
  belongs_to :customer_account
  belongs_to :order_line
  belongs_to :order_status
end
