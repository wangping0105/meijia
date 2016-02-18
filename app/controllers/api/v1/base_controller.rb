class Api::V1::BaseController < ActionController::API

  protected
  def authenticate!
    raise "您的登录已经过期，请重新登录！" unless current_user
  end

  def set_default_page_params
    params[:page] ||= 1
    params[:per_page] ||= Kaminari.config.default_per_page
  end
end
