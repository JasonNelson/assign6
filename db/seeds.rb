# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# CustomerAccounts

CustomerAccount.delete_all

99.times do |n|
   fname = Faker::Name.first_name
   middle_initial = (Faker::Lorem.word).first.upcase
   lname = Faker::Name.last_name
   street_add = Faker::Address.street_address + ' ' + Faker::Address.street_suffix
   city = Faker::Address.city
   state = Faker::Address.state
   zipcode = Faker::Address.zip
   email = Faker::Internet.email([lname, fname].join('_'))
   home_phone = Faker::PhoneNumber.phone_number
   cell_phone = Faker::PhoneNumber.cell_phone
   phone_pref = "cell_phone"
   password = Faker::Internet.password(8)

   CustomerAccount.create!(
      fname: fname,
      middle_initial: middle_initial,
      lname: lname,
      street_add: street_add,
      city: city,
      state: state,
      zipcode: zipcode,
      email: email,
      home_phone: home_phone,
      cell_phone: cell_phone,
      phone_pref: phone_pref,
      password: password)
end

# InventoryItems

uom_array = ['case', 'box', 'each', 'dozen']
area_array = ('A'..'Z').to_a

InventoryItem.delete_all

99.times do |n|
   barcode = Faker::Number.number(5)
   product_name = Faker::Commerce.product_name
   description = Faker::Lorem.sentences(1)
   selling_price = Faker::Commerce.price
   unit_of_measure = uom_array[Random.new.rand(0..3)]
   qty_on_hand = Random.new.rand(100..1000)
   location_aisle = 1 + rand(50)
   location_area = area_array[rand(0..25)]

   InventoryItem.create!(
      barcode: barcode,
      product_name: product_name,
      description: description,
      selling_price: selling_price,
      unit_of_measure: unit_of_measure,
      qty_on_hand: qty_on_hand,
      location_aisle: location_aisle,
      location_area: location_area)
end

# OrderStatus

OrderStatus.delete_all
OrderStatus.create!(id: 1, status: "in progress")
OrderStatus.create!(id: 2, status: "placed")
OrderStatus.create!(id: 3, status: "picked")
OrderStatus.create!(id: 4, status: "packed")
OrderStatus.create!(id: 5, status: "shipped")

# SalesOrder

SalesOrder.delete_all

customers = CustomerAccount.order(:created_at).take(98)

customers.each_with_index do |customer_account, n|
   billing_street_add = Faker::Address.street_address + ' ' + Faker::Address.street_suffix
   billing_city = Faker::Address.city
   billing_state = Faker::Address.state
   billing_zipcode = Faker::Address.zip
   shipping_street_address = Faker::Address.street_address + ' ' + Faker::Address.street_suffix
   shipping_city = Faker::Address.city
   shipping_state = Faker::Address.state
   shipping_zipcode = Faker::Address.zip
   cc_fname = Faker::Name.first_name
   cc_middle_initial = (Faker::Lorem.word).first.upcase
   cc_lname = Faker::Name.last_name
   cc_number = Faker::Number.number(16)
   cc_security_code = Faker::Number.number(3)
   cc_exp_month = Random.new.rand(1..12)
   cc_exp_year = Random.new.rand(15..20)
   subtotal = Faker::Commerce.price
   tax_percent = 10
   shipping_fee = 10
   total = (subtotal + (subtotal * (tax_percent / 100) + shipping_fee))
   customer_account_id = customer_account_id
   order_line_id = n * 5
   order_status_id = Random.new.rand(1..5)

   customer_account.sales_orders.create!(
      billing_street_add: billing_street_add,
      billing_city: billing_city,
      billing_state: billing_state,
      billing_zipcode: billing_zipcode,
      shipping_street_address: shipping_street_address,
      shipping_city: shipping_city,
      shipping_state: shipping_state,
      shipping_zipcode: shipping_zipcode,
      cc_fname: cc_fname,
      cc_middle_initial: cc_middle_initial,
      cc_lname: cc_lname,
      cc_number: cc_number,
      cc_security_code: cc_security_code,
      cc_exp_month: cc_exp_month,
      cc_exp_year: cc_exp_year,
      subtotal: subtotal,
      tax_percent: tax_percent,
      shipping_fee: shipping_fee,
      total: total,
      customer_account_id: customer_account_id,
      order_line_id: order_line_id,
      order_status_id: order_status_id)
end

# OrderLines

OrderLine.delete_all

orders = SalesOrder.order(:id).take(98)
items = InventoryItem.order(:id).take(98)

items.shuffle!

orders.each do |sales_order|
   rand(3..10).times do |n|
   qty_ordered = Random.new.rand(1..10)
   unit_price = items[n].selling_price
   total_price = unit_price * qty_ordered
   sales_order_id = sales_order_id
   inventory_item_id = items[n].id

   sales_order.order_lines.create!(
      qty_ordered: qty_ordered,
      unit_price: unit_price,
      total_price: total_price,
      sales_order_id: sales_order_id,
      inventory_item_id: inventory_item_id)
   end
end

# SoPickLists - do not need seeds

# SoShipments - do not need seeds

