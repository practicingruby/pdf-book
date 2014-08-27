require_relative "../helper"

Prawn::Component.define(:account_details) do
  float do
    text "Your Account Information", :size => 8
    formatted_text [{:text => "Customer Name Key:  ", :styles => [:italic]},
                    {:text => bill.customer_name_key, :styles => [:bold]}],
                    :size => 8
    text bill.customer_address, :size => 8
  end

  indent(120) do
    move_up font.line_gap # this is a hack, because by default Prawn inserts 
                          # a line_gap space at the top of table cells.
                          # There is a ticket that complains about it.
    data = [
      ["Account Number:", bill.account_number],
      ["Meter Number:", bill.meter_number],
      ["Trans and Dist Rate:", bill.trans_and_dist_rate],
      ["Generation Rate:", bill.generation_rate],
      ["Billing Period:",  bill.billing_period],
      ["Statement Date:",  bill.statement_date],
      ["Next Meter Reading (on or about):", bill.next_meter_reading]
    ]

    table(data) do |t|
      t.cells.style(:borders => [], :padding_bottom => 0.5, :padding_top => 0, :size => 8)
      t.column(0).style(:align => :right)
      t.column(1).style(:align => :left)
    end
  end
end
