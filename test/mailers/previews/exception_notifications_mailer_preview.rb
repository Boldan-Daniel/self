# Preview all emails at http://localhost:3000/rails/mailers/exception_notifications_mailer
class ExceptionNotificationsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/exception_notifications_mailer/report
  def report
    ExceptionNotificationsMailer.report
  end

end
