class CalculateLevel
	@@troll_dir = YAML.load_file('config/troll_dir.yml')[Rails.env]
	@queue = :calculate

	def self.perform book_id
		puts @@troll_dir
		puts Rails.env
		book = Book.find book_id

		reading_level = nil

		samples = book.isbns.sample(4)
		Rails.logger.debug samples.map &:number

		samples.each do |isbn|
			sanitized_number = isbn.number.gsub /[^[:alnum:]]/,""
			result = `cd #{@@troll_dir} && java -classpath "bin:lib/*" execute.CommandLine #{sanitized_number}`
			Rails.logger.debug result
			if /\d{10}|\d{13}/ =~ result
				if reading_level == nil || Float(result) > reading_level
					reading_level = Float(result).round 1
				end
			end
		end
		if reading_level
			book.update_attributes 	reading_level: reading_level, 
															calculation_status: Book::CalculationStatus::COMPLETE
		else
			book.update_attributes 	calculation_status: Book::CalculationStatus::ERROR
		end
	end

end