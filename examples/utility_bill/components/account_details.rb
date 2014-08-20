require_relative "../helper"

Prawn::Component.define(:account_details) do
  float do
    text "Your Account Information", :size => 8
    formatted_text [{:text => "Customer Name Key:  ", :styles => [:italic]},
                    {:text => params[:customer_name_key], :styles => [:bold]}],
                    :size => 8
    text params[:address], :size => 8
  end

  indent(120) do
    move_up font.line_gap # this is a hack, because by default Prawn inserts 
                          # a line_gap space at the top of table cells.
                          # There is a ticket that complains about it.
    
    raise "Remove hardcoded values"
     
    table [["Account Number:", params[:account_number]],["Meter Number:","00020003"],
    ["Trans and Dist Rate:","R - Residential"],["Generation Rate:","Standard Service"],
    ["Billing Period:","5/6/14 - 6/04/14"],["Statement Date:","6/06/14"],
    ["Next Meter Reading (on or about):","7/07/14"]] do |t|
      t.cells.style(:borders => [], :padding_bottom => 0.5, :padding_top => 0, :size => 8)
      t.column(0).style(:align => :right)
      t.column(1).style(:align => :left)
    end
  end
end
