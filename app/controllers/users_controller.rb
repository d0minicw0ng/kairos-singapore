class UsersController < ApplicationController

  before_filter :authenticate_user!, only: [:show]

  def show
    @user = User.includes(:articles).find(params[:id])
  end
end
