require_relative "components/logo"
require_relative "components/customer_address"

include UtilityBill

Prawn::Document.generate("bill.pdf") do
  draw Logo

  # FIXME: Should draw handle positioning logic?

  move_down 20

  draw CustomerAddress, :address => "Mike Johnson\n123 Any Street\nAny Town, USA 00000"
end
