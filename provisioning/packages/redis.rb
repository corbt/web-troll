package :redis do
	apt 'redis-server', sudo: true

	verify { has_apt 'redis-server' }
end