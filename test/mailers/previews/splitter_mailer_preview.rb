class SplitterMailerPreview < ActionMailer::Preview

  def payment_email_preview
    SplitterMailer.payment_email(Item.first)
  end

end
