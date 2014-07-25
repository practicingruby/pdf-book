require_relative "helper"

Prawn.debug = true

# FIXME: Might be nice to support row(:first), row(:last)
#                                 column(:first), column(:last)
# And/or negative indexing, e.g. row(-1).

class UtilityBill
  include Prawn::View

  def initialize(data1, data2)
    font_size 8

    define_grid(:columns => 12, :rows => 2)
    grid.show_all

    grid([1,0],[1,7]).bounding_box do
      table data1 do |t|
        apply_charge_styling(t, data1.size)

        # consists of a single cell
        t.row(0).style(:borders => [:left, :top, :right])
      end

      move_down 10

      table(data2) do |t|
        apply_charge_styling(t, data2.size)
      end
    end

    grid([0,7], [0,11]).bounding_box do
      table [["Payment Due Date", "Amount Now Due"],
             ["7/04/14", "$ 110.00"]] do |t|

        t.row(0).style(:background_color => "CCCCCC", :text_color => "666666", :size => 12, :font_style => :bold)
        t.cells[1,0].style(:size => 14)
        t.cells[1,1].style(:size => 16, :align => :right)
      end
    end

    grid([1,9],[1,11]).bounding_box do
      image "delivery.jpg",  :width => bounds.width
      image "generation.jpg",:width => bounds.width 
    end
  end

  private

  def apply_charge_styling(t, size)
    t.instance_eval do
      column(0).style(:borders => [:left],  :width => 160)
      column(1).style(:borders => [],       :width => 120)
      column(2).style(:borders => [],       :width => 40)
      column(3).style(:borders => [:right], :width => 40, :align => :right)
      
      row(0).style { |c| c.borders += [:top] }

      row(size - 1).style do |c| 
        c.borders += [:bottom]
        c.font_style = :bold
      end
    end
  end
end

# TODO: Move input data into CSVs (break out compound fields, i.e. X KwH, Rate in
# two fields rather than 1

data1 =
  [ [{ :content => "Current Supplier: THE FLYING BLINKY LIGHTS COMPANY", :colspan => 4 }],
      ["Generation Service Charge", "491 kWh X $.090041", "$", "44.21"],
      [{ :content => "Total Generation Services Charges", :colspan => 2 }, "$", "44.21"]]

data2 =
  [["Transmission per kwh", "425 kWh X $.020207", "$", "8.59"],
   ["Transmission per kwh", "66 kWh X $.025259", "$", "1.67"],
   [{ :content => "Distribution Basic Service", :colspan => 2 }, "$", "16.50"],
   ["Distribution per kwh", "491 kWh X $.055807", "$", "27.40"],
   ["Combined Public Benefits Charge", "491 kWh X $.011731", "$", "5.76"],
   ["Non-Bypassable FMCC per kwh", "425 kWh X $.009415", "$", "4.00"],
   ["Non-Bypassable FMCC per kwh", "6 KWh x $.011769", "$", "0.78"],
   ["Decoupling Adjustment", "491 kWh X $.002215", "$", "1.09"],
   [{ :content => "Total Delivery Charges", :colspan => 2 }, "$", "65.79"]]

UtilityBill.new(data1, data2).save_as("x.pdf")
