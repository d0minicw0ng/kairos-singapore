class CommentMailer < ActionMailer::Base
  default from: "notification@kairossociety.com.sg"

  def new_comment_notification(comment, request)
    receivers = CommentMailer.get_receivers(comment)
    @event_type = comment.commentable_type.downcase
    @comment = comment
    @comment_url = CommentMailer.generate_comment_url(@comment, request)
    receivers.each do |receiver|
      @receiver = receiver
      @is_creator = false
      @is_creator = true if CommentMailer.is_creator?(comment, @receiver)
      mail(to: @receiver.email, subject: "Your #{@event_type} has a new comment!")
    end
  end

  private

  def self.generate_comment_url(comment, request)
    "#{request.host_with_port}/#{comment.commentable_type.downcase.pluralize}/#{comment.commentable.id}"
  end

  def self.is_creator?(comment, receiver)
    if comment.commentable_type == 'Project'
      return true if comment.commentable.users.include?(receiver)
    elsif comment.commentable_type == 'Article'
      return true if comment.commentable.user_id == receiver.id
    end
    false
  end

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
