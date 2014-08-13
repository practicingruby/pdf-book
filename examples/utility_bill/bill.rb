require_relative "helper"

Prawn.debug = true

# FIXME: Normalize data! Should reflect 8/5/14 bill for 165.36

# FIXME: Might be nice to support row(:first), row(:last)
#                                 column(:first), column(:last)
# And/or negative indexing, e.g. row(-1).
#
# FIXME: Allow all dynamic fields (names, dates, numbers etc.) to be
# set dynamically.

class UtilityBill
  include Prawn::View

  def initialize(data1, data2)
    font_size 8

    define_grid(:columns => 12, :rows => 3)
    #grid.show_all

    grid([1,0],[1,8]).bounding_box do
      float do
        text "Your Account Information"
        formatted_text [{:text => "Customer Name Key:  ", :styles => [:italic]},
                        {:text => "JOHNSON", :styles => [:bold]}]
        text "Mike Johnson"
        text "123 Any Street"
        text "Any Town, USA 00000"
      end

      indent(120) do
        move_up font.line_gap # this is a hack, because by default Prawn inserts 
                              # a line_gap space at the top of table cells.
                              # There is a ticket that complains about it.
        table [["Account Number:", "0100000-000"],["Meter Number:","00020003"],
        ["Trans and Dist Rate:","R - Residential"],["Generation Rate:","Standard Service"],
        ["Billing Period:","5/6/14 - 6/04/14"],["Statement Date:","6/06/14"],
        ["Next Meter Reading (on or about):","7/07/14"]] do |t|
          t.cells.style(:borders => [], :padding_bottom => 0.5, :padding_top => 0)
          t.column(0).style(:align => :right)
          t.column(1).style(:align => :left)
        end
      end

      move_down 10

      table data1 do |t|
        apply_charge_styling(t, data1.size)

        # consists of a single cell
        t.row(0).style(:borders => [:left, :top, :right])
      end

      move_down 10

      table(data2) do |t|
        apply_charge_styling(t, data2.size)
      end

      move_down 5

      table [["Total New Charges", "$", "165.36"]] do
        cells.style(:borders => [], :font_style => :bold)
        column(0).width = 284
        column(1).width = 87
      end
    end

    grid([0,0], [0,3]).bounding_box do
      text "FBL/C", :size => 48, :leading => -15, :color => "ff6666"
      text "The Flying Blinky Lights Company", :style => :italic, :size => 10,
                                               :color => "999999" 
    end

    grid([0,0], [0,7]).bounding_box do
      move_down 100
      text "001111 000011111"
      text "Mike Johnson\n123 Any Street\nAny Town, USA 00000", 
           :size => 11
    end

    grid([0,0], [0,11]).bounding_box do
      move_down 220
      text "Please consider adding $1 for Fancy Charity to your payment this month or call 1-800-000-0000 to donate move than $1",
      :style => :bold
      move_down 3
      dash 10, :space => 4
      stroke_horizontal_rule
      undash
    end

    grid([0,4],[0,6]).bounding_box do
      table([["Account Number"], ["012-0000345-6789"]], :width => bounds.width - 5) do |t|
        t.row(0).style(:background_color => "CCCCCC", :text_color => "666666", :size => 12, :font_style => :bold)
        t.cells[1,0].style(:size => 14, :height => 25)
      end

    end

    grid([0,7], [0,11]).bounding_box do
      table [["Payment Due Date", "Amount Now Due"],
             ["7/04/14", "$ 110.00"]] do |t|

        t.row(0).style(:background_color => "CCCCCC", :text_color => "666666", :size => 12, :font_style => :bold)
        t.cells[1,0].style(:size => 14, :height => 25, :align => :center)
        t.cells[1,1].style(:size => 16, :align => :right, :height => 25)
      end

      move_down 5

      text "Please make your check payable to:", :color => "666666", :size => 12, :style => :italic
      text "The Flying Blinky Lights Company.", :color => "666666", :size => 13, :style => :bold

      table [["Please Indicate Amount Paid",""]] do |t|
        t.cells[0,0].style(:background_color => "CCCCCC", :text_color => "666666", :size => 12, :font_style => :bold)
        t.cells[0,1].style(:width => 50)
      end
    end

    grid([0,7], [0,11]).bounding_box do
      move_down 150
      text "THE FLYING BLINKY LIGHTS COMPANY\nPO BOX 0000\nANY TOWN, USA 00000", :size => 11
    end

    grid([1,9],[1,11]).bounding_box do
      indent(10) do
        stroke_rectangle bounds.top_left, bounds.width, bounds.height - 10 

        bounding_box([bounds.left+5, bounds.top-5], :width => bounds.width-10) do
        text "MESSAGES", :size => 15, :align => :center
        text "Your electric supplier is :", :style => :bold
        text "THE FLYING BLINKY LIGHTS COMPANY\nPO BOX 0000\nANY TOWN, USA 00000-0000" +
        "1-800-000-0000\nwww.aaaaa.com\n\n" +
        "Have a question for us?\nClick on Customer Care on\nOur website at example.com.\n\n" +
        "No stamps, no checks, no fees! Enroll now to receive and pay your bill on the internet.\n\n" +
        "MONTHLY MONEY-SAVER\n" +
        "During hot summer months, close drapes to help keep our "+
        "unwanted heat and reduce your air conditioning costs. "+
        "Use ceiling or portable fans instead of room air "+
        "conditioners where possible.", :size => 7
        end
      end
    end

    grid([2,9],[2,11]).bounding_box do
      indent(10) do
        image "delivery.jpg",  :height => bounds.height/2
        image "generation.jpg",:height => bounds.height/2
        stroke_bounds
      end
    end

    grid([2,0],[2,8]).bounding_box do
      table [["Amount Now Due: $", "165.36"]], :position => :right do |t|
        t.column(0).style(:borders => [:top, :left, :bottom],)
        t.column(1).style(:borders => [:top, :right, :bottom], :width => 106, :align => :right)
        t.cells.style(:size => 9, :font_style => :bold)
      end

      move_down 40

      formatted_text [{ :text => "All charges are due as of your Statement Date. Any unpaid charges will be "+
           "subject to interest as of your Statement Date, at the rate of 1.25% per month, "+
           "if not paid on or before ", :styles => [:italic] }, 
           { :text => "August 5, 2014. ", :styles => [:bold] },
           { :text => "Making your payment on the Due Date at an authorized payment agent "+
            "may not post until the following business day. If you have a question "+
            "contact FBL/C. As authorized by law, for residential accounts, we "+
            "supply payment information to credit rating agencies. If your account is "+
            "more than sixty days delinquent, a delinquency report could harm your credit rating.",
            :styles => [:italic] }]

      move_down 20

      text "Electricity Usage:"

      table [["Meter", "Service Period", "Last Meter Reading", "Current Meter Reading", "Multiplier", "Kilowatt hours"],
             ["012345678", "32 days", "78548", "79301", "1", "753 kWh"]]
    end
  end

  private

  def apply_charge_styling(t, size)
    width = bounds.width

    t.instance_eval do
      cells.style(:padding_top => 0, :padding_bottom => 1)

      column(0).style(:borders => [:left],  :width => width*0.4)
      column(1).style(:borders => [],       :width => width*0.3, :align => :right)
      column(2).style(:borders => [],       :width => width*0.15)
      column(3).style(:borders => [:right], :width => width*0.15, :align => :right)
      
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
   ["Non-Bypassable FMCC per kwh", "6 kWh X $.011769", "$", "0.78"],
   ["Decoupling Adjustment", "491 kWh X $.002215", "$", "1.09"],
   [{ :content => "Total Delivery Charges", :colspan => 2 }, "$", "65.79"]]

UtilityBill.new(data1, data2).save_as("x.pdf")
