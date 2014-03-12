namespace :troll do 
	task :copy do 
		pipe = IO.popen("rsync -ravh -e ssh /media/sf_workspace/troll deploy@troll.cs.byu.edu:/data/apps")
		while (line = pipe.gets)
			puts line
		end
	end
end