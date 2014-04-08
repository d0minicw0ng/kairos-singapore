class ContactUsMailer < ActionMailer::Base
  default from: "notification@kairossociety.com.sg"

  def contact_us(data)
    @message = data['message']
    mail(to: ['dominic.wong.617@gmail.com', 'sjm1988@hotmail.com'], subject: data['subject'])
  end

  def user_approved(data)
    email = data['email']
    name = data['name']
    mail(to: ['dominic.wong.617@gmail.com', 'sjm1988@hotmail.com', email], subject: 'Congratulations! Your Kairos Society membership has been approved!')
  end
end
