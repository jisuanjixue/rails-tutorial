class SessionsController < ApplicationController
  def new
  end

  #登入用户
  def create
    # 提交表单后会生成 params 个嵌套哈希，电子邮件地址和密码都在 :session 键中
    # Active Record 提供的 User.find_by方法和 has_secure_password 提供的 authenticate 方法,
    # 如果认证失败，authenticate 方法会返回 false
    # 电子邮件地址都是以小写字母形式保存的，所以这里调用了 downcase 方法
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user 
      remember user #登录并记住登录状态
      redirect_to user #用户登录成功就使用该方法记住该用户,然后重定向到用户的资料页面
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end 
  end
  
  # 退出登陆
  def destroy
    log_out if logged_in? 
    redirect_to root_url
  end
end
