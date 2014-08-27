require_relative "../helper"


# FIXME: Move into formal styling system or at least into
# a constant on UtilityBill
common_header_style = { :background_color => "CCCCCC", 
                        :text_color       => "666666", 
                        :size             => 12, 
                        :font_style       => :bold }

# FIXME: Move into formal styling system or at least into
# a constant on UtilityBill
row_height = 0.35.in

Prawn::Component.instance_eval do
  define(:account_number_box) do
    data = [["Account Number"], [bill.account_number]]

    table(data, :width => bounds.width) do |t|
      t.row(0).style(common_header_style)
      t.cells[1,0].style(:size => 14, :height => row_height)
    end
  end

  define(:payment_due_box) do
    data = [["Payment Due Date", "Amount Now Due"],
            [bill.due_date, bill.amount_due]]

    table(data, :width => bounds.width) do |t|
      t.row(0).style(common_header_style)
      t.cells[1,0].style(:size => 14, :height => row_height, :align => :center)
      t.cells[1,1].style(:size => 16, :align => :right, :height => row_height)
    end
  end

  define(:check_payable) do
    text "Please make your check payable to:", :style => :italic, 
                                               :color => UtilityBill::STYLES[:gray_text]

    text "The Flying Blinky Lights Company", :style => :bold,
                                             :color  => UtilityBill::STYLES[:gray_text],
                                             :size => 13

    table([["Please Indicate Amount Paid", ""]], :width => bounds.width) do |t|
      t.cells[0,0].style(common_header_style)
      t.cells[0,1].style(:width => bounds.width * 0.22)
    end
  end

  define(:cut_line) do
    text "Please consider adding $1 for Fancy Charity to your payment this "+
         "month or call 1-800-000-0000 to donate move than $1", :size => 8,
         :style => :bold

    dash 10, :space => 4

    stroke_horizontal_rule

    undash
  end
end
