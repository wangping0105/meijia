class Api::V1::BaseController < ActionController::API
  include Api::IkDeviceDetectable
  include Api::IkParamsProcessable
  include Api::IkAuthenticateable
  include Api::IkRescueable

  helper_method :current_user
  before_action :authenticate!

  protected

  def set_default_page_params
    params[:page] ||= 1
    params[:per_page] ||= Kaminari.config.default_per_page
  end
end
