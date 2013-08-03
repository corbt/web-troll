package :unicorn, provides: :appserver do 
	requires :fs, :nginx
	transfer "templates/nginx_troll", "/etc/nginx/sites-available", sudo: true
	runner "ln -s /etc/nginx/sites-available/nginx_troll /etc/nginx/sites-enabled", sudo: true
	runner "rm /etc/nginx/default", sudo: true
	runner "service nginx restart", sudo: true

	verify{ has_symlink "/etc/nginx/sites-enabled/nginx_troll","/etc/nginx/sites-available/nginx_troll" }
end

