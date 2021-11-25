class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後に投稿一覧へ遷移
  def after_sign_in_path_for(_resource)
    posts_path
  end

  # ログアウト後にトップページへ遷移
  def after_sign_out_path_for(_resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
