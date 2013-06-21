class CreateIsbns < ActiveRecord::Migration
  def change
    create_table :isbns do |t|
      t.string :number
      t.references :book

      t.timestamps
    end
  end
end
