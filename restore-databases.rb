# Restores the databases needed for Troll
# This is an imdepotent operation

backups_path = "/media/sf_shared/database_dumps"

Dir.glob(backups_path+"/*.sql") do |file|
	puts command = 'mysql -u root < '+file.to_s
	system(command)
end