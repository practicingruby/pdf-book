require_relative "helper"

require "mustache"

params = {}

## NOTE: Consider splitting into header file and letter file

Mustache.render(File.read("letter.txt"), 
  :body => ->(e) { 
    params[:body] = Mustache.render(e, :date => Date.today.strftime("%B %d, %Y"),
                                       :emails => params[:emails])
   },
   :emails  => -> (e) { params[:emails] = e },
   :from    => -> (e) { params[:from]    = e },
   :contact => -> (e) { params[:contact] = e },
   :company => -> (e) { params[:company] = e },
   :footer  => -> (e) { params[:footer]  = e },
   :company_subtext => -> (e) { params[:company_subtext] = e },
   :company_address => -> (e) { params[:company_address] = e }
 )

formatting = {
  :company            => { :styles => [:bold] },
  :company_subtext    => { :size => 8 },
  :company_header     => { :align => :center, :leading => 4, :color => "555555" },
  :company_address    => { :align => :center, :color => "555555", :size => 10 },
  :from               => { :align => :left, :color => "555555", :size => 10 },
  :contact            => { :align => :right, :color => "555555", :size => 10 },
  :body               => { :size => 10, :inline_format => true },
  :footer             => { :size => 8, :color => "555555" }
}

document = DocumentBuilder.new
letter   = FormLetter.new(document, params, formatting)

document.update do
  font "Helvetica"

  float do
    span(bounds.width/3, :position => :left) do
      move_down 0.75.in
      letter.text(:from)
    end
  end

  float do
    span(bounds.width/3, :position => :center) do
      letter.text_group [:company, :company_subtext], :company_header

      letter.text(:company_address)
    end
  end

  float do
    span(bounds.width/3, :position => :right) do
      move_down 0.75.in
      letter.text(:contact)
    end
  end

  font "Times-Roman"

  move_down 2.in

  span(6.5.in, :position => :center) do
    letter.text(:body) # NOTE: nbsp in content
  end

  move_cursor_to 0.5.in

  font "Helvetica"

  text params[:footer], formatting[:footer]
end

document.save_as("hello.pdf")
