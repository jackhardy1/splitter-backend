class SplitterMailerPreview < ActionMailer::Preview

  def send_email_preview
    SplitterMailer.send_email(Item.first)
  end

end
