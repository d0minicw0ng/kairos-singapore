class Api::UsersController < ApplicationController

  def index
    @users = User.approved.map &:serializable_hash
    render json: @users, status: :ok
  end
end
