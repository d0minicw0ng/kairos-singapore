class ContactUsMailer < ActionMailer::Base
  default from: "notification@kairossociety.com.sg"

  def contact_us(data)
    @message = data['message']
    mail(to: ['dominic.wong.617@gmail.com', 'sjm1988@hotmail.com'], subject: data['subject'])
  end
end
