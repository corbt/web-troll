class Isbn < ActiveRecord::Base
	belongs_to :book

	validates_uniqueness_of :number
end
