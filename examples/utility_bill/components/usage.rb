require_relative "../helper"

Prawn::Component.define(:usage) do
  text "Electricity Usage:", :size => 9 
  
  move_down 0.05.in

  usage_data = [["Meter", "Service Period", "Last Meter Reading", "Current Meter Reading", 
                 "Multiplier", "Kilowatt hours"],
                [bill.meter_id, bill.service_period, bill.last_meter_reading,
                 bill.current_meter_reading, bill.multiplier, 
                 "#{bill.kwh_used} kWh"]]

  table(usage_data) { |t| t.cells.style(:size => 8) }
end
