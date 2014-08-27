require_relative "../helper"

Prawn::Component.define(:usage) do
  text "Electricity Usage:", :size => 9 
  
  move_down 0.05.in

  usage_data = [["Meter", "Service Period", "Last Meter Reading", "Current Meter Reading", 
                 "Multiplier", "Kilowatt hours"],
                [params[:meter_id], params[:service_period], params[:last_meter_reading],
                 params[:current_meter_reading], params[:multiplier], 
                 "#{params[:kwh_used]} kWh"]]

  table(usage_data) { |t| t.cells.style(:size => 8) }
end
