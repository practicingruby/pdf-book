require_relative "../helper"

Prawn::Component.define(:company_address) do
  text params[:company_address], :size => 11
end
