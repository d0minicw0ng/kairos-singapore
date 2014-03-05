class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    #FIXME: If we have other mailers, we need to set a ActionMailer default_url_options instead
    CommentMailer.new_comment_notification(@comment, request).deliver

    if @comment.save
      render json: @comment.to_json(include: {user: {methods: [:thumb_url]}})
    else
      render json: { errors: @comment.errors.full_messages }
    end
  end

  def update
  end

  def destroy
  end

  private

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/ && name != 'user_id'
        return $1.classify.constantize.friendly.find(value)
      end
    end
    nil
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :content, :commentable_id, :commentable_type)
  end
end
