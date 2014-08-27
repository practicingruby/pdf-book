require_relative "../helper"

Prawn::Component.define(:late_notice) do
  # FIXME: Move into an ERB text file a read it here?

  formatted_text [
    { :text => "All charges are due as of your Statement Date. Any unpaid charges will be "+
           "subject to interest as of your Statement Date, at the rate of #{bill.interest_rate}% per month, "+
           "if not paid on or before ", :styles => [:italic] }, 
           { :text => "#{bill.deadline}. ", :styles => [:bold] },
           { :text => "Making your payment on the Due Date at an authorized payment agent "+
            "may not post until the following business day. If you have a question "+
            "contact FBL/C. As authorized by law, for residential accounts, we "+
            "supply payment information to credit rating agencies. If your account is "+
            "more than sixty days delinquent, a delinquency report could harm your credit rating.",
            :styles => [:italic] }], :size => 7
end
