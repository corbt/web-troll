namespace :troll do 
	task :copy do 
		pipe = IO.popen("rsync -v -r -e ssh /media/sf_shared/troll deploy@troll.cs.byu.edu:/data/apps/troll")
		while (line = pipe.gets)
			puts line
		end
	end
end