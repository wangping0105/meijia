module Api::IkRescueable
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :rescue_all
    rescue_from CommonExceedError, with: :common_exceed_error
    rescue_from InvalidAppError, with: :invalid_app_error
    rescue_from UserAuthenticationError, with: :user_authentication_error
    rescue_from EntityValidationError, with: :entity_validation_error
    rescue_from SignupInvalidPhoneError, with: :signup_invalid_phone_error
    rescue_from SignupInvalidCaptchaError, with: :signup_invalid_captcha_error
    rescue_from RecordNotFoundError, with: :record_not_found_error
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from AuthError, with: :auth_error
    rescue_from AuthLockError, with: :auth_lock_error
    rescue_from FailSmsError, with: :fail_sms_error
    rescue_from UnauthorizedError, with: :unauthorized_error
    # rescue_from Workflow::NoTransitionAllowed, with: :workflow_no_transition_allowed
    # rescue_from Errors::EntityNotAccessed, with: :entityNotAccessed
    rescue_from RailsParam::Param::InvalidParameterError, with: :validation_errors

    rescue_from ActiveRecord::RecordInvalid, with: :show_errors
  end

  private

  def common_exceed_error(e)
    log_error(e)
    render json: { code: code, message: msg, error: e.class.name.underscore }
  end

  def invalid_app_error(e)
    log_error(e)
    render json: { code: ErrorCodes::INVALID_APP, message: e.message, error: e.class.name.underscore }
  end

  def user_authentication_error(e)
    log_error(e)
    render json: { code: ErrorCodes::INVALID_USER, message: e.message, error: e.class.name.underscore }
  end

  def validation_errors(e)
    log_error(e)
    render json: { code: ErrorCodes::INVALID_PARAMS, message: e.message, error: e.class.name.underscore }
  end

  def entity_validation_error(e)
    log_error(e)
    render json: { code: ErrorCodes::INVALID_PARAMS, message: e.message, error: e.class.name.underscore }
  end

  def signup_invalid_phone_error(e)
    log_error(e)
    render json: { code: ErrorCodes::INVALID_PHONE, message: e.message, error: e.class.name.underscore }
  end

  def signup_invalid_captcha_error(e)
    log_error(e)
    render json: { code: ErrorCodes::INVALID_CAPTCHA, message: e.message, error: e.class.name.underscore }
  end


  def record_not_found_error(e)
    log_error(e)
    render json: { code: ErrorCodes::RECORD_NOT_FOUND, message: e.message, error: e.class.name.underscore }
  end

  def record_not_found(e)
    log_error(e)
    render json: { code: ErrorCodes::RECORD_NOT_FOUND, message: '您没有权限查看该记录或该记录不存在。', error: e.class.name.underscore }
  end

  def auth_error(e)
    log_error(e)
    render json: { code: ErrorCodes::FAIL_AUTH, message: e.message, error: e.class.name.underscore }
  end

  def auth_lock_error(e)
    log_error(e)
    render json: { code: ErrorCodes::AUTH_LOCK, message: e.message, error: e.class.name.underscore }
  end

  def fail_sms_error(e)
    log_error(e)
    render json: { code: ErrorCodes::FAIL_SMS, message: e.message, error: e.class.name.underscore }
  end

  # def workflow_no_transition_allowed(e)
  #   log_error(e)
  #   render json: { code: ErrorCodes::INVALID_PARAMS, message: "当前帐号状态出现问题，请联系客户支持解决！", error: e.class.name.underscore }
  # end

  # def entityNotAccessed(e)
  #   log_error(e)
  #   render json: { code: ErrorCodes::ENTITY_NOT_ACCESSED, message: "亲~ 你所访问的资源目前不属于你！", error: e.class.name.underscore }
  # end

  def unauthorized_error(e)
    log_error(e)
    render json: { code: ErrorCodes::UNAUTHORIZED, message: e.message, error: e.class.name.underscore }
  end

  def show_errors(exception)
    exception.record.new_record? ? "": exception.record.errors.full_messages.join(", ")
  end

  def rescue_all(e)
    log_error(e)
    render json: { code: ErrorCodes::SERVER_ERROR, message: "抱歉~ 系统出错了，攻城狮们已经在修理了！", error: e.class.name.underscore, original_message: e.message }
  end

  def log_error(e)
    logger.error e.message
    e.backtrace.each do |message|
      logger.info message
    end
  end
end
