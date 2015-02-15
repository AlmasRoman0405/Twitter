class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
    def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
  
    def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save == true
      flash[:success] = "Мы вас поздравляем. Регистрация прошла успешно!"
      redirect_to @user
    
    else 
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:success] = "Редактирование прошло успешно!"
    redirect_to @user
  else 
    render 'edit'
  end 
end

  def destroy
  end 
  
      def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
   def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  private
     
  def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
    def signed_in_user
      if not signed_in? 
      redirect_to signin_url, notice: "Please sign in." 
    end
end

  def correct_user
    if current_user.id != params[:id].to_i
      redirect_to root_url, notice: "У вас нет прав доступа"
    end
  end
end