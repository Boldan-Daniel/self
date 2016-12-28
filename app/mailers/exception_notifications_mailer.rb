class ExceptionNotificationsMailer < ApplicationMailer
  default from: "exceptions@#{Figaro.env.app_title}.com"

  def report(exceptions_to_notify)
    @exceptions_to_notify = exceptions_to_notify
    mail to: Figaro.env.error_mail, subject: 'Exceptions Report'
  end

end
