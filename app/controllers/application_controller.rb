class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top, :about]
  # ログイン
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
    # サインインした後に飛ぶページ currnt_userは現在ログインしているユーザー
  end

  def after_sign_out_path_for(resource)
    root_path
    # サインインした後に飛ぶページ currnt_userは現在ログインしているユーザー
  end

  add_flash_types :success, :info, :warning, :danger

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:name, :email])
    devise_parameter_sanitizer.permit(:sign_in,keys:[:name])
  end
  # ストロングパラメーター
end
