require_relative "helper"

require_relative "letter_data"

if __FILE__ == $PROGRAM_NAME
  ## Set relevant formatting for different sections
  formatting = {
    :company            => { :styles => [:bold] },
    :company_subheading => { :size => 8 },
    :company_header     => { :align => :center, :leading => 4, :color => "555555" },
    :company_address    => { :align => :center, :color => "555555", :size => 10 },
    :from               => { :align => :left, :color => "555555", :size => 10 },
    :contact            => { :align => :right, :color => "555555", :size => 10 },
    :body               => { :size => 10, :inline_format => true },
    :footer             => { :size => 8, :color => "555555" }
  }

  letter = FormLetter.new(LetterData.new, formatting)

  letter.update do
    font "Helvetica"

    header_box(:left) do
      move_down 0.75.in
      text(:from)
    end

    header_box(:center) do
      text_group [:company, :company_subheading], :company_header

      text(:company_address)
    end

    header_box(:right) do
      move_down 0.75.in
      text(:contact)
    end

    font "Times-Roman"

    move_down 2.in

    body { letter.text(:body) }

    move_cursor_to 0.5.in

    font "Helvetica"

    text(:footer)
  end

  letter.save_as("letter.pdf")
end
