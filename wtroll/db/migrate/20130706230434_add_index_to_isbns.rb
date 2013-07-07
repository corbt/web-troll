class AddIndexToIsbns < ActiveRecord::Migration
  def change
  	add_index :isbns, :number
  end
end
