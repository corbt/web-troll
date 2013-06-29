class Book < ActiveRecord::Base
  has_many :isbns, dependent: :destroy
  accepts_nested_attributes_for :isbns

  def to_hash
  	hash = {}
  	hash[:author]					= self.author
  	hash[:title]					= self.title
  	hash[:url]						= self.url
  	hash[:author_url] 		= self.author_url
  	hash[:reading_level]	= self.reading_level
  	hash[:isbn]						= self.isbns.first.number
  	hash
  end

  def populate_from_wtroll
    attributes = Book.find(1).attributes
  end

  def isbn
    @isbn ||= isbns.first.number
  end

  def add_isbn (number)
    isbns.new(number: number)
  end
  alias_method :isbn=, :add_isbn
  
end
