class Isbn < ActiveRecord::Base
  attr_accessible :number, :references
end
