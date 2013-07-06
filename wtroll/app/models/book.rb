class Book < ActiveRecord::Base
  has_many :isbns, dependent: :destroy
  accepts_nested_attributes_for :isbns

  include CalculationStatus

  def to_hash
  	hash = {}
  	hash[:author]					= self.author
  	hash[:title]					= self.title
  	hash[:url]						= self.url
  	hash[:author_url] 		= self.author_url
  	hash[:reading_level]	= self.reading_level
  	hash[:isbn]						= self.isbn
    hash[:id]							= self.id
  	hash
  end

  def self.from_isbn isbn
    client = Openlibrary::Client.new
    book_data = client.search isbn: isbn
    test = book_data[0] ? from_openlibrary(book_data[0]) : nil
    Rails.logger.info "TEST "+test.to_s
    test
  end

  def self.from_openlibrary book_obj
    book = self.new
    book.title          = book_obj.title
    book.author         = book_obj.author_name[0] if book_obj.author_name
    book.author_url     = "http://openlibrary.org/authors/#{book_obj.author_key[0]}" if book_obj.author_key
    book.url            = "http://openlibrary.org/works/#{book_obj.key!}"
    
    book_obj.isbn.each do |x|
      book.add_isbn x
    end
    book
  end

  def calculate_reading_level
    update_attributes calculation_status: CalculationStatus::IN_PROGRESS
    Resque.enqueue CalculateLevel, id
  end

  def isbn
    @isbn ||= isbns.first.number
  end

  def add_isbn (number)
    isbns.new(number: number)
  end
  alias_method :isbn=, :add_isbn

end
