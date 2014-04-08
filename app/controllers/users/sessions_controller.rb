class Users::SessionsController < Devise::SessionsController

  def create
    #NOTE: Hacky way to redirect user if he is not approved. Do not want to spend
    #too much time in devise documentation.
    user = User.find_by_email(params['user']['email'])
    if !user.approved
      flash[:alert] = t(:'common.not_yet_approved')
      return redirect_to root_url
    end

    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end
end
