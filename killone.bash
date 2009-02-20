killone () {
	local O=$IFS
	IFS=$'\n'
	select proc in `ps ax | grep ${!#} | grep -v grep`
	do 
		IFS=" "
		local opts=($@)
		unset opts[$#-1]
		local words=($proc)
		kill "${opts[@]}" ${words[0]}
		break
	done
	IFS=$O
}