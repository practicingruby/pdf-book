require_relative "helper"
require_relative "bill"

Dir.glob("components/*.rb") do |f|
  require_relative("components/#{File.basename(f, ".rb")}")
end

Prawn::Document.generate("bill.pdf") do
  data_source(:bill) { UtilityBill.new }

  draw :logo, 
    :box => [0.in, 0.in, 2.25.in, 0.75.in]

  draw :customer_address, 
    :box => [0.in, 1.25.in, 2.in, 0.5.in]

  draw :company_address,
    :box => [-3.1.in, 2.in, 3.1.in, 0.75.in]

  draw :account_number_box,
    :box => [2.5.in, 0.in, 1.8.in, 0.75.in]

  draw :payment_due_box,
    :box => [-3.1.in, 0.in, 3.1.in, 0.75.in]

  draw :check_payable,
    :box => [-3.1.in, 0.8.in, 3.1.in, 1.in]

  draw :cut_line,
    :box => [0.in, 3.0.in, bounds.width, 0.25.in]

  draw :account_details,
    :box => [0.in, 3.25.in, bounds.width-2.in, 1.in]

  draw :charges,
    :box => [0.in, 4.5.in, bounds.width - 2.in, 3.5.in]

  draw :messages,
    :box => [-1.75.in, -6.25.in, 1.75.in, 3.in]

  draw :charts, 
    :box => [-1.75.in, -3.in, 1.75.in, 3.in]

  draw :late_notice,
    :box => [0.in, -2.in, bounds.width - 2.in, 0.75.in]

  draw :usage,
    :box => [0.in, -1.25.in, bounds.width - 2.in, 0.75.in]
end

`open -g bill.pdf`
