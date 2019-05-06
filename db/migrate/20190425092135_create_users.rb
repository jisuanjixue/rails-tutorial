class CreateUsers < ActiveRecord::Migration[5.0]
  # 迁移文件中有一个名为 change 的方法，定义要对数据库做什么操作。
  # change 方法使用 Rails 提供的 create_table 方法在数据库中新建一个表，用来存储用户。
  # create_table 方法可以接受一个块，块中有一个块变量 t（“table”）。在块中，create_table 方法通过 t 对象创建 name 和 email 两个列，均为 string 类型。
  # t.timestamps 是个特殊的方法，它会自动创建两个列，created_at 和 updated_at，这两个列分别记录创建用户的时间戳和更新用户数据的时间戳。
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
