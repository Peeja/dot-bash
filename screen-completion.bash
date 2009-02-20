_screen ()
{
	local cur="${COMP_WORDS[COMP_CWORD]}"
	if [ $3 == '-r' ]
		then COMPREPLY=($(screen -ls | ruby <<-RUBY
		# ruby <<-RUBY
			IO.popen("screen -ls") do |screen|
				screen.each do |line|
					if line =~ /\t\d+\.($cur[^\t]+)/
						puts \$1
					end
				end
			end
		RUBY
		))
	fi
}

complete -o default -o nospace -F _screen screen
