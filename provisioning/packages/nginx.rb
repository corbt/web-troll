package :nginx, provides: :server do
	requires :nginx_dependencies
	runner "add-apt-repository --yes ppa:nginx/stable", sudo: true
	runner "apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 00A6F0A3C300EE8C", sudo: true
	runner "apt-get update", sudo: true
	apt "nginx", sudo: true
	runner "service nginx start", sudo: true

	verify { has_apt "nginx" }
end

package :nginx_dependencies do
	apt "python-software-properties software-properties-common", sudo: true

	verify { has_executable "add-apt-repository" }
end