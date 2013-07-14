class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :api_key, unique: true

      t.timestamps
    end
    add_index :users, :api_key
  end
end
