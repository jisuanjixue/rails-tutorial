class UsersController < ApplicationController
  # before_action :correct_user,  only: [:edit, :update]
  # before_action :logged_in_user, only: [:edit, :update]

  def index
    @users = User.all  
  end

  def new
    @user = User.new
  end
  
  def show
     @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      #注册的过程中自动登入用户,调用 log_in 方法
    log_in @user 
    flash[:success] = "create successful"
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
    if @user.update_attributes(user_params) # 处理更新成功的情况
      flash[:success] = "Profile updated" 
      redirect_to @user
     else render 'edit'    
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,:image)
  end

  # def logged_in_user
  #   unless logged_in? flash[:danger] = "Please log in." 
  #     redirect_to login_url 
  #   end    
  # end

  # def correct_user
  #   @user = User.find(params[:id]) 
  #   redirect_to(root_url) 
  #    unless @user == current_user    
  #   end
  # end
end
