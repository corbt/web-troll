class CalculateLevel
	@@troll_dir = YAML.load_file('config/troll_dir.yml')[Rails.env]
	@queue = :calculate

	def self.perform book_id
		puts @@troll_dir
		puts Rails.env
		book = Book.find book_id
		result = `cd #{@@troll_dir} && java -classpath "bin:lib/*" execute.CommandLine #{book.isbn}`
		if /\d{10}|\d{13}/ =~ result
			reading_level = Float(result).round 1
			book.update_attributes 	reading_level: reading_level, 
															calculation_status: Book::CalculationStatus::COMPLETE
		else
			book.update_attributes 	calculation_status: Book::CalculationStatus::ERROR
		end
	end

end