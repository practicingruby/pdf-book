require "erb"

class LetterData
  def from
    "Enrico O'Keefe\nFlorine Grant\n"
  end

  def contact
    "Phone: 203-555-1234\nFax: 203-555-4321\n"
  end

  def company
    "O'KEEFE AND GRANT, P.C."
  end

  def company_subheading
   "Certified Public Accountants".upcase
  end

  def company_address
    "24410 Rice Meadow Road • Suite A\n"+
    "New Haven, Connecticut 06512\n"
  end

  def deadline
    "March 31, 2014"
  end
   
  def emails
    "    <u>enrico@okgracpas.com</u>\n    <u>florine@okgracpas.com</u>\n"
  end

  def footer
    "Members:\nAmerican Institute of Certified Public Accounts\n"+
    "Connecticut Society of Certified Public Accountants\n"
  end

  def date
    Date.today.strftime("%b %d, %Y")
  end
  
  def year
    (Date.today.year - 1).to_s
  end

  def customer_name
    ["Gregory", "Brad", "James", "Daniel", "Jonathan" ].sample 
  end

  def signature
    "Sincerely,\n#{company}\n#{company_subheading.capitalize}"
  end

  def body
    ERB.new(Text.unwrap(File.read("letter.txt")), 0, "-").result(binding)
  end
end
