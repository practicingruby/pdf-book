require_relative "helper"

Prawn.debug = true

# FIXME: Might be nice to support row(:first), row(:last)
#                                 column(:first), column(:last)
# And/or negative indexing, e.g. row(-1).

class UtilityBill
  include Prawn::View

  def initialize(data1, data2)
    font_size 10

    table data1 do |t|
      apply_charge_styling(t, data1.size)

      # consists of a single cell
      t.row(0).style(:borders => [:left, :top, :right])
    end

    move_down 20

    table(data2) do |t|
      apply_charge_styling(t, data2.size)
    end
  end

  private

  def apply_charge_styling(t, size)
    t.instance_eval do
      column(0).style(:borders => [:left],  :width => 200)
      column(1).style(:borders => [],       :width => 150)
      column(2).style(:borders => [],       :width => 50)
      column(3).style(:borders => [:right], :width => 100, :align => :right)
      
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
