class Users::RegistrationsController < Devise::RegistrationsController

  prepend_before_filter :require_no_authentication, only: [:cancel]
  before_filter :verify_admin, only: [:new, :create]
  before_filter :update_sanitized_params, if: :devise_controller?


  private

  # NOTE: This is probably a common method among different controller
  def verify_admin
    unless current_user.try(:admin)
      flash[:alert] = t(:'common.no_right')
      redirect_to root_url
    end
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
       :username,
       :first_name,
       :last_name,
       :email,
       :password,
       :password_confirmation,
       :member_type,
       :company,
       :job_title,
       :biography,
       :avatar)
    end
  end
end
