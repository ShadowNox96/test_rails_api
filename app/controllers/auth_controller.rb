class AuthController < ApplicationController
  skip_before_filter :authenticate!

  def create
    email = params[:email]
    password = params[:password]
    @user = User.find_by_email(email)

    puts '=======================USER============='
    puts @user.password_digest
    if @user && Digest::SHA1.hexdigest(password)== @user.password_digest
      time = Time.now + 24.hours.to_i
      token = JsonWebToken.encode({ user_id: @user.id }, time)
      render json: { token: token, exp: time.strftime('%d-%m-%Y %H:%M'),
                     email: @user.email }
    else
      render json: { error: 'unauthorized' }, status: :forbidden
    end
  end

  private

  
end
