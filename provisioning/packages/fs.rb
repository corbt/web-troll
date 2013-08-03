directory = Site::CONFIG[:app_dir]
package :fs do 
	runner "mkdir -p #{directory}", sudo: true
	runner "chown deploy:deploy #{directory}", sudo: true
	verify { has_directory directory }	
end