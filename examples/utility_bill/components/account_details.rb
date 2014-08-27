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
    data = [
      ["Account Number:", params[:account_number]],
      ["Meter Number:", params[:meter_number]],
      ["Trans and Dist Rate:", params[:trans_and_dist_rate]],
      ["Generation Rate:", params[:generation_rate]],
      ["Billing Period:",params[:billing_period]],
      ["Statement Date:",params[:statement_date]],
      ["Next Meter Reading (on or about):", params[:next_meter_reading]]
    ]

    table(data) do |t|
      t.cells.style(:borders => [], :padding_bottom => 0.5, :padding_top => 0, :size => 8)
      t.column(0).style(:align => :right)
      t.column(1).style(:align => :left)
    end
  end
end
