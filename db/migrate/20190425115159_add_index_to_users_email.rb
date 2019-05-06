class AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
  def change
    # 为email增加索引,指定字段唯一性
    add_index :users, :email, unique: true
  end
end
