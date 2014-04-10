class EventMailer < ActionMailer::Base
  default from: "notification@kairossociety.com.sg"

  def new_event_notification(data)
    @event = Event.find(data['event_id'])
    @event_url = event_url(data['host_with_port'], data['event_id'])
    receivers = User.all.map(&:email)
    mail(to: receivers, subject: "New Announcement - #{@event.name}")
  end

  private

  def event_url(host_with_port, event_id)
    "#{host_with_port}/events/#{event_id}"
  end
end
