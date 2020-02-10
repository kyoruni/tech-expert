class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(resource)
    '/users/sign_in' # サインアウト後、users/sign_inにリダイレクト
  end

  def configure_permitted_parameters
    # sign_upアクションが実行されるときに、nicknameと
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :avatar])
  end
end
