class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_approved_current_user
    if !current_user
      flash[:error] = t(:'common.no_right')
      redirect_to root_url
    end

    if current_user && !current_user.approved
      flash[:error] = t(:'common.not_yet_approved')
      redirect_to root_url
    end
  end

  def authenticate_admin
    if !current_user.try(:admin)
      flash[:error] = t(:'common.no_right')
      redirect_to root_url
    end
  end
end
