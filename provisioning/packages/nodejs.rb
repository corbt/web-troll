package :nodejs do
	requires :nodejs_dependencies
	runner "add-apt-repository --yes ppa:chris-lea/node.js", sudo: true
	runner "apt-get update", sudo: true
	apt "nodejs", sudo: true
	verify { has_executable "node" }
end

package :nodejs_dependencies do
	apt "python-software-properties python g++ make", sudo: true
end