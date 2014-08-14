require_relative "components/logo"
require_relative "components/customer_address"
require_relative "components/charts"

require "prawn/measurement_extensions"

include UtilityBill

Prawn::Document.generate("bill.pdf") do
  draw Logo, 
    [0.in, 0.in, 2.25.in, 0.75.in]

  draw CustomerAddress, 
    [1.in, 0.in, 2.in, 1.in],
    :address  => "Mike Johnson\n123 Any Street\nAny Town, US 00000"

  draw Charts, 
    [-3.in, -1.5.in, 1.5.in, 3.in],
    :generation_chart => "generation.jpg", 
    :delivery_chart   => "delivery.jpg"
end

`open -g bill.pdf`
