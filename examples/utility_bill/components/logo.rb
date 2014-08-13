require_relative "../helper"

module UtilityBill
  class Logo
    include Prawn::Component

    def draw
      text "FBL/C", :size => 48, :leading => -15, :color => "ff6666"

      text "The Flying Blinky Lights Company", :style => :italic, 
                                               :size  => 10,
                                               :color => "999999"
    end
  end
end
