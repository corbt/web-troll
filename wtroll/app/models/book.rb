class Book < ActiveRecord::Base
  attr_accessible :author, :reading_level, :title
end
