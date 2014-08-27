require_relative "../helper"

Prawn::Component.define(:messages) do
  move_down 0.1.in

  text "MESSAGES", :size => 16, :align => :center

  move_down 0.1.in

  indent(0.1.in, 0.1.in) do
    text "Your electric supplier is:", :style => :bold, :size => 8
    text bill.company_address, :size => 6
    text bill.company_phone,   :size => 6
    text bill.company_website, :size => 6

    move_down 0.1.in

    text bill.messages, :size => 6
  end

  # FIXME: We should find a way to prevent the need for explicit mask here.
  # Also eliminate duplication between this and charts
  mask(:stroke_color) do
    stroke_color "999999"
    stroke_bounds
  end
end
