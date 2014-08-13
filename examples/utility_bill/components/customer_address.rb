require_relative "../helper"

module UtilityBill
  class CustomerAddress
    include Prawn::Component

    def draw
      text(params[:address], :size => 10)
    end
  end
end
