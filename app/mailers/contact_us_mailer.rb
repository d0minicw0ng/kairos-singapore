class ContactUsMailer < ActionMailer::Base
  default from: "notification@kairossociety.com.sg"

  def contact_us(data)
    @message = data['message']
    mail(to: 'jian.sim@kairossociety.org', subject: data['subject'])
  end
end
