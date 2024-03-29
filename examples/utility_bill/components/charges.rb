require_relative "../helper"

## FIXME: Check measurements and make as generic as possible,
# reduce duplication.

class UtilityBill
  class Charges
    include Prawn::Component

    def draw
      table bill.generation_charges do |t|
        apply_common_styling(t, bill.generation_charges.size)

        # consists of a single header cell
        t.row(0).style(:borders => [:left, :top, :right])
      end
      
      move_down 0.1.in

      table bill.delivery_charges do |t|
        apply_common_styling(t, bill.delivery_charges.size)
      end

      move_down 0.05.in

      table [["Total New Charges", "$", bill.new_charges_total]], :width => bounds.width do |t|
        t.cells.style(:borders => [], :font_style => :bold, :size => 9)
        t.column(0).width = bounds.width * 0.7
        t.column(1).width = bounds.width * 0.2
        t.column(2).align = :right
      end

      move_down 0.05.in

      table [["Amount Now Due: $", bill.amount_due]], :position => :right do |t|
        t.column(0).style(:borders => [:top, :left, :bottom],)
        t.cells.style(:border_color => "999999")
        # FIXME: MAGIC NUMBER!
        t.column(1).style(:borders => [:top, :right, :bottom], :width => bounds.width*0.26, 
                          :align => :right, :size => 10)
        t.cells.style(:size => 10, :font_style => :bold)
      end
    end

    private

    def apply_common_styling(t, size)
      width = bounds.width

      t.instance_eval do
        cells.style(:padding_top => 0, :padding_bottom => 1, :size => 9,
                    :border_color => "999999")

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
end


Prawn::Component.define(:charges, UtilityBill::Charges)
