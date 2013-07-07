class AddIndexToIsbns < ActiveRecord::Migration
  def change
  	add_index :isbns, :number, unique: true
  end
end
