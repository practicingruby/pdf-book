require_relative "../helper"

Prawn::Component.define(:logo) do
  text "FBL/C", :size => 48, :leading => -15, :color => "ff6666"

  text "The Flying Blinky Lights Company", :style => :italic, 
                                           :size  => 10,
                                           :color => "999999"
end
