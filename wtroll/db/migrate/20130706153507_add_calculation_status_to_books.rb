class AddCalculationStatusToBooks < ActiveRecord::Migration
  def change
    add_column :books, :calculation_status, :integer
  end
end
