package :mysql, provides: :database do
	apt 'mysql-server libmysql-ruby libmysqlclient-dev', sudo: true

	verify do
		has_apt 'mysql-server'
		has_apt 'libmysql-ruby'
		has_apt 'libmysqlclient-dev'
	end
end