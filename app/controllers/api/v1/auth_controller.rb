class Api::V1::AuthController < Api::V1::BaseController
  skip_before_action :authenticate!, only: [:login]

  def login
    login_field = params[:login].include?("@") ? :email : :phone
    @user = User.with_database_authentication(login_field => params[:login]).first
    if @user && @user.authenticate(params[:password])
      @user.update_authentication_token

    else
      render json: { code: -1, data: { message: "帐号或者密码错误" } }
    end
  end

  def logout

  end

  def ping
    render json: { code: 0, data: { message: "pong" } }
  end

end
