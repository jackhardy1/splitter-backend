class ApplicationMailer < ActionMailer::Base
  default from: "bills@splitter.com"
  layout 'mailer'
end
