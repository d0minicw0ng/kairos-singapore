class EmailWorker
  # include Sidekiq::Worker

  def perform(mailer_class, method, data)
    mailer_class = mailer_class.constantize
    mailer_class.send(method, data).deliver
  end
end
