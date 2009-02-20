# Show git branch in prompt.  Green for clean tree, yellow for changes.
__git_color_ps1() {
	local color
	if (git status | grep "working directory clean") >/dev/null 2>&1 
		then color=2
		else color=1
	fi
	__git_ps1 "\e[3${color}m%s\e[0m:"
}
