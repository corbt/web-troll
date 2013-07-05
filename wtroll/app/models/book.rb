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
  	hash[:isbn]						= self.isbn
    hash[:id]							= self.id
  	hash
  end

  def from_isbn isbn
    client = Openlibrary::Client.new
    book_data = client.search isbn: isbn
    from_openlibrary book_data[0]
  end

  def from_openlibrary book_obj
    self.title          = book_obj.title
    self.author         = book_obj.author_name[0]
    self.author_url     = "http://openlibrary.org/authors/#{book_obj.author_key[0]}"
    self.url            = "http://openlibrary.org/works/#{book_obj.key!}"
    
    book_obj.isbn.each do |x|
      add_isbn x
    end
  end

  def calculate_reading_level
    troll_dir = '/media/sf_shared/troll'
    result = `cd #{troll_dir} && java -classpath "bin:lib/*" execute.CommandLine #{isbn}`
    self.reading_level = Float(result).round 1
  end

  def isbn
    @isbn ||= isbns.first.number
  end

  def add_isbn (number)
    isbns.new(number: number)
  end
  alias_method :isbn=, :add_isbn

end
