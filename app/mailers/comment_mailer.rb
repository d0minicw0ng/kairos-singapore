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
      receivers = comment.commentable.users
    when 'Article'
      article = comment.commentable
      author = article.user
      receivers = article.comments.map(&:user).reject {|user| user == author}
      receivers << author
    when 'Event'
      jian_min = User.find_by_email('jian.sim@kairossociety.org')
      event = comment.commentable
      receivers = event.comments.map(&:user)
      receivers << jian_min if jian_min
    else
      receivers = []
    end
    receivers
  end
end
