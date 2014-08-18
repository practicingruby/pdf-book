# Alternative interface
#
# Prawn::Component.define(:customer_address) do |params|
#   text params[:address], :size => 10
# end
#
# then elsewhere...
#
# draw(:customer_address, :address => "...")
#
# Would create an anonymous class under the hood.

require_relative "../helper"

Prawn::Component.define(:customer_address) do
  text(params[:address], :size => 10)
end
