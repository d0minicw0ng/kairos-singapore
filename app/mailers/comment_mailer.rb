class CommentMailer < ActionMailer::Base
  default from: "notification@kairossociety.com.sg"

  def new_comment_notification(comment)
    receivers = CommentMailer.get_receivers(comment)
    @event_type = comment.commentable_type.downcase
    receivers.each do |receiver|
      @receiver = receiver
      mail(to: @receiver.email, subject: "Your #{@event_type} has a new comment!")
    end
  end

  private

  def self.get_receivers(comment)
    case comment.commentable_type
    when 'Project'
      receivers = comment.project.users
    when 'Article'
      receivers = [comment.article.user]
    when 'Event'
      #FIXME: who should receive an e-mail when a comment is left?
      receivers = []
    else
      receivers = []
    end
    receivers
  end
end
