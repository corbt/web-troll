package :troll do 
	requires :fs, :java, :troll_dbs

	# rsync -v -r -e ssh /media/sf_shared/troll deploy@troll:/data/apps/troll
	transfer '/media/sf_shared/troll', '/data/apps', recursive: true

	verify { has_directory "/data/apps/troll" }
end

package :troll_dbs do
	requires :mysql, :tmp

	transfer '/media/sf_shared/database_dumps/large_stemmed_headings_upper_bound.sql', '~/tmp', recursive: true
	

end

package :tmp do
	runner "mkdir ~/tmp"
	verify { has_directory "~/tmp" }
end