class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :mail
      t.string :password
      t.string :ddi_phone
      t.string :ddd_phone
      t.string :phone
      t.datetime :last_login
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
