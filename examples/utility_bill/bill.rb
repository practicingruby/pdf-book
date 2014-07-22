require_relative "helper"


BILL_DATA = 
  [["Generation Service Charge", "611 kWh X $.090041", "$", "55.02"],
   ["Generation Service Charge", "611 kWh X $.090041", "$", "55.02"],
   ["Generation Service Charge", "611 kWh X $.090041", "$", "55.02"],
   ["Generation Service Charge", "611 kWh X $.090041", "$", "55.02"]]

class UtilityBill
  include Prawn::DSL

  def initialize(name)
    text "Hello #{name}"

    # FIXME: Find a better way around this mess.
    table BILL_DATA do |t|
      if BILL_DATA.size > 1
        t.column(0).borders     = [:left]
        t.columns(1..BILL_DATA[0].length-2).borders = []
        t.columns(BILL_DATA[0].length-1).borders    = [:right]
        t.row(0).borders = [:top]
        t.row(BILL_DATA.length-1).borders = [:bottom]

        t.cells[0,0].borders = [:top,    :left]
        t.cells[0,BILL_DATA[0].length-1].borders = [:top,    :right]
        t.cells[BILL_DATA.length-1,0].borders = [:bottom, :left]
        t.cells[BILL_DATA.length-1,BILL_DATA[0].length-1].borders = [:bottom, :right]
      else
        t.row(0).borders = [:top, :bottom]
        t.cells[0,0].borders = [:top, :left, :bottom]
        t.cells[0,BILL_DATA[0].length-1].borders = [:top, :right, :bottom]
      end
    end
  end
end

UtilityBill.new("Gregory").save_as("x.pdf")
