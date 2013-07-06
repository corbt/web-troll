class CalculateLevel
	@queue = :calculate

	def work book_id
		book = Book.find book_id
		troll_dir = '/media/sf_shared/troll'
		result = `cd #{troll_dir} && java -classpath "bin:lib/*" execute.CommandLine #{isbn}`
		if /\d{10}|\d{13}/ =~ result
			reading_level = Float(result).round 1
			book.update_attributes 	reading_level: reading_level, 
															calculation_status: Book::CalculationStatus::COMPLETE
		else
			book.update_attributes 	calculation_status: Book::CalculationStatus::ERROR
		end
	end

end