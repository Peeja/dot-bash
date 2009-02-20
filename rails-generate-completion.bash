_generate()
{
  local cur

  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}

  if [ ! -d "$PWD/script" ]; then
    return 0
  fi

  if [ $COMP_CWORD == 1 ] && [[ "$cur" == -* ]]; then
    COMPREPLY=( $( compgen -W '-h -v\
      --help --version'\
      -- $cur ))
    return 0
  fi

  if [ $COMP_CWORD == 2 ] && [[ "$cur" == -* ]]; then
    COMPREPLY=( $( compgen -W '-p -f -s -q -t -c\
      --pretend --force --skip --quiet --backtrace --svn'\
      -- $cur ))
    return 0
  fi

  COMPREPLY=( $(script/generate --help | \
    awk -F ': ' \
      'BEGIN { generators = "" }; \
      /^  (Plugins|Rubygems|Builtin):/ { gsub(/, */, "n", $2); print $2 }' | \
    command grep "^$cur" \
  ))
}

complete -F _generate $default generate
