class AddUrlsToBooks < ActiveRecord::Migration
  def change
  	change_table :books do |t|
  		t.string :url
  		t.string :author_url
  	end
  end
end
