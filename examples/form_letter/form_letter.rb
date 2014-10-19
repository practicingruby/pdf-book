require_relative "helper"

require_relative "letter_data"

if __FILE__ == $PROGRAM_NAME
  secondary_color    = "555555"
  normal_font_size   = 10
  small_font_size    = 8

  ## Set relevant formatting for different sections
  formatting = {
    :company             => { :styles => [:bold] },

    :company_subheading  => { :size => small_font_size },

    :company_header      => { :align => :center, 
                              :leading => 4, 
                              :color => secondary_color },

    :company_address     => { :align => :center, 
                              :color => secondary_color, 
                              :size  => normal_font_size },

    :from                => { :align => :left, 
                              :color => secondary_color, 
                              :size  => normal_font_size },

    :contact             => { :align => :right, 
                              :color => secondary_color, 
                              :size => normal_font_size },

    :body                => { :size => normal_font_size, 
                              :inline_format => true },

    :footer              => { :size => small_font_size, 
                              :color => secondary_color }
  }

  letter = FormLetter.new(LetterData.new, formatting)

  letter.update do
    font "Helvetica"

    header_box(:left) do
      move_down 0.75.in
      text_snippet(:from)
    end

    header_box(:center) do
      text_snippet_group [:company, :company_subheading], :company_header

      text_snippet(:company_address)
    end

    header_box(:right) do
      move_down 0.75.in
      text_snippet(:contact)
    end

    font "Times-Roman"

    move_down 2.in

    body { text_snippet(:body) }

    move_cursor_to 0.5.in

    font "Helvetica"

    text_snippet(:footer)
  end

  letter.save_as("letter.pdf")
end
