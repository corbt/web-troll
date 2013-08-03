package :mysql, provides: :database do
	apt 'mysql-server', sudo: true

	verify { has_apt 'mysql-server' }
end