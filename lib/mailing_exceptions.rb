class MailingExceptions
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call env

  rescue Exception => exception
    ExceptionNotificationsMailer.report exception
  end

end