require_relative "helper"

Dir.glob("components/*.rb") do |f|
  require_relative("components/#{File.basename(f, ".rb")}")
end

module UtilityBill
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
end

address = "Mike Johnson\n123 Any Street\nAny Town, US 00000"
account_number = "012-0000345-6789"

Prawn::Document.generate("bill.pdf") do
  draw :logo, 
    :box => [0.in, 0.in, 2.25.in, 0.75.in]

  draw :customer_address, 
    :box => [0.in, 1.in, 2.in, 0.5.in],
    :address  => address

  draw :account_number_box,
    :box => [2.5.in, 0.in, 1.8.in, 0.75.in],
    :account_number => account_number

  draw :payment_due_box,
    :box => [-3.1.in, 0.in, 3.1.in, 0.75.in],
    :due_date   => "07/04/14",
    :amount_due => "$110.00"

  draw :check_payable,
    :box => [-3.1.in, 0.8.in, 3.1.in, 1.in]

  draw :cut_line,
    :box => [0.in, 3.0.in, bounds.width, 0.25.in]

  draw :account_details,
    :box => [0.in, 3.25.in, bounds.width-1.5.in, 1.in],
    :customer_name_key => "JOHNSON",
    :address => address,
    :account_number => account_number

  draw :charts, 
    :box => [-1.5.in, -3.in, 1.5.in, 3.in],
    :generation_chart => "generation.jpg", 
    :delivery_chart   => "delivery.jpg"


end

`open -g bill.pdf`
