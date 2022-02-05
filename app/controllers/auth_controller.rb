# Контроллер для регистрации, авторизации и восстановления доступа пользователей
class AuthController < ApplicationController
  before_action except: :logout do
    redirect_to root_path if session[:user_id]
  end

  def register
    if request.get?
      @user = User.new
      return render :register
    end

    @user = User.new(user_params)

    if @user.save
      redirect_to login_path
    else
      render :register, status: :unprocessable_entity
    end
  end

  def login
    return render :login if request.get?

    user = User.find_or_initialize_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      render :login, status: :unprocessable_entity
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end
end
