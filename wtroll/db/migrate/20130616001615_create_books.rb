class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.string :title
      t.decimal :reading_level

      t.timestamps
    end
  end
end
