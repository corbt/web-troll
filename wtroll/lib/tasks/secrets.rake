require 'yaml'

namespace :secrets do
	task :generate do
		secrets = Rails.root.join('config','secrets.yml')
		if not File.exist? secrets
			key = SecureRandom.hex 50
			File.open(secrets, 'w') do |f|
				f.write({"session_key" => key}.to_yaml)
			end
			puts "secrets.yml generated"
		else
			puts "secrets.yml exists, nothing to do"
		end
	end
end