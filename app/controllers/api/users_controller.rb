class Api::UsersController < ApplicationController

  def index
    @users = User.approved
    render json: @users.to_json, status: :ok
  end
end
