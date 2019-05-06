class User < ApplicationRecord
  #挂上 image uploader
mount_uploader :image, ImageUploader
attr_accessor :remember_token
before_save { self.email = email.downcase }

 # 用户名不能为空， 长度至少为4
 validates :name, presence: true, length: { minimum: 4 }
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

# (验证邮箱是否存在，长度，格式，唯一性，不区分大小写)
 validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
 
 has_secure_password
 # 密码不能为空，是含有小写字母、大写字母、数字、特殊符号，长度至少为8,更新时允许密码为空
 validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

# 返回指定字符串的哈希摘要
def User.digest(string)
  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
  BCrypt::Password.create(string, cost: cost)
end

 #记住用户的登录状态要创建一个记忆令牌，并且在数据库中存储这个令牌的摘要, 返回一个随机令牌
def User.new_token
  SecureRandom.urlsafe_base64  
end

 # 为了持久会话，在数据库中记住用户
def remember
  self.remember_token = User.new_token 
  update_attribute(:remember_digest, User.digest(remember_token))  
end

 # 如果指定的令牌和摘要匹配，返回 true
def authenticated?(remember_token)
  return false if remember_digest.nil? 
  BCrypt::Password.new(remember_digest).is_password?(remember_token)  
end

 # 忘记用户
def forget
  update_attribute(:remember_digest, nil)  
end

end
