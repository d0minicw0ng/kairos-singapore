class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    @comment.user_id = current_user.id

    if @comment.save
      render json: @comment.to_json(include: [:user])
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
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
