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

