package :java do
	apt 'openjdk-7-jre openjdk-7-jdk', sudo: :true
	verify { has_apt 'openjdk-7-jre' }
end