module Api::IkAuthenticateable
  extend ActiveSupport::Concern
  # controller and view

  included do
    helper_method :version_code
  end

  private
  def authenticate_app!
    raise InvalidAppError.new("app的access_token不对") unless current_app
  end

  def authenticate!
    raise UserAuthenticationError.new("您的登录已经过期，请重新登录！") unless current_user
  end

  def current_user
    raise RailsParam::Param::InvalidParameterError.new("user_token 不能为空！") if auth_params[:user_token].nil?
    @current_user ||= User.find_by(authentication_token: auth_params[:user_token])
  end

  def current_app
    conds = { access_token: auth_params[:access_token] }
    if device.present?
      conds[:app_type] = device
    end
    @current_app ||= ::App.find_by(conds)
  end

  def current_user_device
    current_user.user_devices.order("id desc").first if current_user.present?
  end

  def auth_params
    @auth_params ||= begin
      token, options = token_and_options(request)
      return params unless options
      options[:user_token] = token
      options
    end
  rescue
    params
  end

  # 确保version_code都按 major.minor.patch 格式传递过来，并且不同客户端同一版本api确保值一致
  def version_code
    auth_params[:version_code]
  end
end