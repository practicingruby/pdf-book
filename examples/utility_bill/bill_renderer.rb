# FIXME: Normalize data! Should reflect 8/5/14 bill for 165.36
require_relative "helper"
require_relative "bill"

Dir.glob("components/*.rb") do |f|
  require_relative("components/#{File.basename(f, ".rb")}")
end

messages = 
  "Have a question for us? Click on Customer Care on our website "+
  "at www.example.com.\n\nNo stamps, no checks, no fees! "+
  "Enroll now to pay your bill on the Internet.\n\n\n"+
  "MONTHLY MONEY SAVER:\n\n"+
  "During hot summer months, close the drapes to keep out unwanted "+
  "heat and reduce your air conditioning costs. Use ceiling or "+
  "portable fans instead of room air conditioners where possible."

# FIXME: Push some of the structure logic down into component (i.e. colspan
# stuff, break into :header, :body, :footer may do it.)
# FIXME: (break out compound fields, i.e. X KwH, Rate in
# two fields rather than 1

generation_charges =
  [ [{ :content => "Current Supplier: THE FLYING BLINKY LIGHTS COMPANY", :colspan => 4 }],
      ["Generation Service Charge", "491 kWh X $.090041", "$", "44.21"],
      [{ :content => "Total Generation Services Charges", :colspan => 2 }, "$", "44.21"]]


# FIXME: Push some of the structure logic down into component 
# (i.e. colspan stuff)
# FIXME: (break out compound fields, i.e. X KwH, Rate in
# two fields rather than 1
delivery_charges = 
  [["Transmission per kwh", "425 kWh X $.020207", "$", "8.59"],
   ["Transmission per kwh", "66 kWh X $.025259", "$", "1.67"],
   [{ :content => "Distribution Basic Service", :colspan => 2 }, "$", "16.50"],
   ["Distribution per kwh", "491 kWh X $.055807", "$", "27.40"],
   ["Combined Public Benefits Charge", "491 kWh X $.011731", "$", "5.76"],
   ["Non-Bypassable FMCC per kwh", "425 kWh X $.009415", "$", "4.00"],
   ["Non-Bypassable FMCC per kwh", "6 kWh X $.011769", "$", "0.78"],
   ["Decoupling Adjustment", "491 kWh X $.002215", "$", "1.09"],
   [{ :content => "Total Delivery Charges", :colspan => 2 }, "$", "65.79"]]


Prawn::Document.generate("bill.pdf") do
  data_source(:bill) { UtilityBill.new }

  draw :logo, 
    :box => [0.in, 0.in, 2.25.in, 0.75.in]

  draw :customer_address, 
    :box => [0.in, 1.25.in, 2.in, 0.5.in]

  draw :company_address,
    :box => [-3.1.in, 2.in, 3.1.in, 0.75.in]

  draw :account_number_box,
    :box => [2.5.in, 0.in, 1.8.in, 0.75.in]

  draw :payment_due_box,
    :box => [-3.1.in, 0.in, 3.1.in, 0.75.in]

  draw :check_payable,
    :box => [-3.1.in, 0.8.in, 3.1.in, 1.in]

  draw :cut_line,
    :box => [0.in, 3.0.in, bounds.width, 0.25.in]

  draw :account_details,
    :box => [0.in, 3.25.in, bounds.width-2.in, 1.in]

  draw :charges,
    :box => [0.in, 4.5.in, bounds.width - 2.in, 3.5.in],
    :generation_charges => generation_charges,
    :delivery_charges   => delivery_charges,
    :new_charge_total   => "110.00"

  draw :messages,
    :box => [-1.75.in, -6.25.in, 1.75.in, 3.in],
    :company_phone   => "800-555-1234",
    :company_website => "www.example.com",
    :messages        => messages

  draw :charts, 
    :box => [-1.75.in, -3.in, 1.75.in, 3.in],
    :generation_chart => "generation.jpg", 
    :delivery_chart   => "delivery.jpg"

  draw :late_notice,
    :box => [0.in, -2.in, bounds.width - 2.in, 0.75.in],
    :deadline => "July 4, 2014",
    :interest_rate => "1.25"

  draw :usage,
    :box => [0.in, -1.25.in, bounds.width - 2.in, 0.75.in],
    :meter_id => "012345678",
    :service_period => "32 days",
    :last_meter_reading => "78548",
    :current_meter_reading => "79301",
    :multiplier            => "1",
    :kwh_used              => "753"
end

`open -g bill.pdf`
