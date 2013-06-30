class ChangeReadingLevelDecimal < ActiveRecord::Migration
  def change
  	change_column :books, :reading_level, :decimal, precision: 4, scale: 1
  end
end
