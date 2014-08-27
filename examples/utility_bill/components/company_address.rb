require_relative "../helper"

Prawn::Component.define(:company_address) do
  text bill.company_address, :size => 11
end
