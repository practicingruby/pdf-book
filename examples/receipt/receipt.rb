require_relative '../helper'

logo_image_path = "#{File.dirname(__FILE__)}/logo.png"

receipt = Prawn::Receipt.new :logo_image_path => logo_image_path,
                             :company_name    => "Great Startup",
                             :company_email   => "support@great-startup.com",
                             :customer_email  => "nope@one.com",
                             :customer_name   => "noone",
                             :amount_billed   => "100.00",
                             :credit_card     => "123-1234-3456",
                             :transaction_id  => "123"

receipt.render_file "receipt.pdf"

