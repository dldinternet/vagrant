site :opscode

@debug = 9

def dependencies(path)
	if File.directory?(path)
  		berks = "#{path}/Berksfile.rb"
  		instance_eval(File.read(berks)) if File.exists?(berks)
  	end
end

book = '/Users/christo/Dropbox/DLDInternet/ws/zmbackup/cookbooks'

Dir.glob("#{book}/*").each do |path|
	puts "glob #{path}" if @debug > 0
	if File.directory?(path)
		puts "dir #{path}" if @debug > 0
		dependencies path
		puts "dependencies #{path}" if @debug > 0
		if File.exists?("#{path}/metadata.rb") and not File.exists?("#{path}/.berksfile.rb.ignore") 
			printf "cookbook %s, :path => %s\n", File.basename(path), path if @debug > 0
			cookbook File.basename(path), :path => path 
			puts "cookbook #{path}" if @debug > 0
		end
	end
end
puts "Done!" if @debug > 0

cookbook 'apache2', '= 1.6.8', :github => 'dldinternet/apache2', :protocol => 'https'
cookbook "build-essential", ">= 1.4.0"
cookbook "chef_handler", ">= 1.1.4"
cookbook 'selinux'
cookbook 'vim'
cookbook 'cron'
