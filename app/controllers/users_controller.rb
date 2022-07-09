class UsersController < ApplicationController
  skip_before_filter :authenticate!, only: :create

  def index
    users = User.all
    render json: users.as_json(json_options)
  end

  def create
    user = User.new
    user.email = params[:email]
    user.password_digest = Digest::SHA1.hexdigest(params[:password])
    if user.save
      render json: user.as_json(json_options)
    else
      render json: { status: :bad, errors: user.errors.messages }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    render json: {
      message: 'User deleted from DB'
    }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def json_options
    { except: %i[created_at updated_at password_digest] }
  end
end
