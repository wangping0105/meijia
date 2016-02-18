class Api::V1::AuthController < Api::V1::BaseController
  skip_before_action :authenticate!, only: [:login]


  def login

  end

  def logout

  end

  def ping
    render json: { code: 0, data: { message: "pong" } }
  end

end
