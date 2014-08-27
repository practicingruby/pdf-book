class UtilityBill  
  # FIXME: Integrate with component system somehow
  # maybe allow Prawn::Component.styles(:component_name, :...) [ID-like]
  # and also Prawn::Component.default_styles(:....) [Global]
  #
  # This would then allow for components themselves to say things like
  # text "foo", :color => styles[:main_text_color]
  #
  # Also have some class-like mechanism
  #
  # styles[:report_table, :font_size] 

  STYLES = { :gray_text => "666666" }

  def company_phone
    "800-555-1234"
  end

  def company_website
    "www.example.com"
  end

  def messages
    "Have a question for us? Click on Customer Care on our website "+
    "at www.example.com.\n\nNo stamps, no checks, no fees! "+
    "Enroll now to pay your bill on the Internet.\n\n\n"+
    "MONTHLY MONEY SAVER:\n\n"+
    "During hot summer months, close the drapes to keep out unwanted "+
    "heat and reduce your air conditioning costs. Use ceiling or "+
    "portable fans instead of room air conditioners where possible."
  end

  def generation_chart
    "generation.jpg"
  end

  def delivery_chart
    "delivery.jpg"
  end

  def meter_id 
    "012345678"
  end

  def service_period
    "32 days"
  end

  def last_meter_reading
    "78548"
  end

  def current_meter_reading 
    "79301"
  end

  def multiplier
    "1"
  end

  def kwh_used
    "753"
  end

  # FIXME: Push some of the structure logic down into component (i.e. colspan
  # stuff, break into :header, :body, :footer may do it.)
  # FIXME: (break out compound fields, i.e. X KwH, Rate in
  # two fields rather than 1
  
  def generation_charges
    [ [{ :content => "Current Supplier: THE FLYING BLINKY LIGHTS COMPANY", :colspan => 4 }],
      ["Generation Service Charge", "491 kWh X $.090041", "$", "44.21"],
      [{ :content => "Total Generation Services Charges", :colspan => 2 }, "$", "44.21"]]
  end

  # FIXME: Push some of the structure logic down into component 
  # (i.e. colspan stuff)
  # FIXME: (break out compound fields, i.e. X KwH, Rate in
  # two fields rather than 1

  def delivery_charges
    [["Transmission per kwh", "425 kWh X $.020207", "$", "8.59"],
     ["Transmission per kwh", "66 kWh X $.025259", "$", "1.67"],
     [{ :content => "Distribution Basic Service", :colspan => 2 }, "$", "16.50"],
     ["Distribution per kwh", "491 kWh X $.055807", "$", "27.40"],
     ["Combined Public Benefits Charge", "491 kWh X $.011731", "$", "5.76"],
     ["Non-Bypassable FMCC per kwh", "425 kWh X $.009415", "$", "4.00"],
     ["Non-Bypassable FMCC per kwh", "6 kWh X $.011769", "$", "0.78"],
     ["Decoupling Adjustment", "491 kWh X $.002215", "$", "1.09"],
     [{ :content => "Total Delivery Charges", :colspan => 2 }, "$", "65.79"]]
  end

  def new_charges_total
    "110.00"
  end

  def customer_address
    "Mike Johnson\n123 Any Street\nAny Town, USA 01234"
  end

  def company_address
    "THE FLYING BLINKY LIGHTS COMPANY\nPO BOX 0000\n"+
    "ANY TOWN, USA 01234"
  end

  def account_number
    "012-0000345-6789"
  end

  def due_date
    "07/04/14"
  end

  # FIXME: reduce duplication w. due date
  def deadline
    "July 4, 2014"
  end
  
  def interest_rate
    "1.25"
  end

  def amount_due
    "$110.00"
  end

  def customer_name_key
    "JOHNSON"
  end

  def meter_number
    "00020003"
  end

  def trans_and_dist_rate
    "R - Residential"
  end

  def generation_rate
    "Standard Service"
  end

  def billing_period
    "5/06/15 - 6/04/14"
  end

  def statement_date
    "6/06/14"
  end

  def next_meter_reading
    "7/07/14"
  end
end

