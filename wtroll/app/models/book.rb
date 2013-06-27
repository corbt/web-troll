class Book < ActiveRecord::Base
  attr_accessible :author, :reading_level, :title, :url, :author_url

  has_many :isbns
end
