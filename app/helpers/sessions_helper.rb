module SessionsHelper
  # 登入指定的用户,session 方法协助,session 视作一个哈希进行赋值，
  # 用户的浏览器中创建一个临时 cookie，内容是加密后的用户 ID。在后续的请求中，可以使用 session[:user_id] 取回这个 ID，浏览器关闭后立即失效，
  # 想在多个不同的地方使用这个登录方式，所以在这里辅助方法模块中定义一个名为 log_in 的方法。
  # session 方法创建的临时 cookie 会自动加密，攻击者无法使用会话中的信息以该用户的身份登录，但这只是针对临时 cookie。
  def log_in(user)
    session[:user_id] = user.id
  end

  # 在持久登陆中记住用户，在浏览器中存储了有效的记忆令牌
  def remember(user)
    user.remember 
    cookies.permanent.signed[:user_id] = user.id 
    cookies.permanent[:remember_token] = user.remember_token  
  end

   #忘记登陆
  def forget(user)
    user.forget 
    cookies.delete(:user_id) 
    cookies.delete(:remember_token)  
  end

   # 退出当前用户
   # log_out 方法放在辅助方法模块中
  def log_out
    forget(current_user) 
    session.delete(:user_id) 
    @current_user = nil
  end
  
  #如果用户 ID 不存在，find 方法会抛出异常。在用户的资料页面可以使用这种表现，因为必须有相应的用户才能显示他的信息。
  #但 session[:user_id] 的值经常是 nil（表示用户未登录),所以通过 id 查找用户
  #把 User.find_by 的结果存储在实例变量中，只在第一次调用时查询数据库，后续再调用直接返回实例变量中存储的值
  # ||=（或等）赋值操作符，如果变量的值为 nil 则给它赋值，否则就不改变这个变量的值
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
      elsif (user_id = cookies.signed[:user_id]) 
        user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # 如果用户已登录，返回 true，否则返回 false
  # 检测有没有当前用户要使用“非”操作符 !
  def logged_in?
    !current_user.nil?
  end
    
end