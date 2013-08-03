package :java do
	apt 'openjdk-7-jre', sudo: :true
	verify { has_apt 'openjdk-7-jre' }
end