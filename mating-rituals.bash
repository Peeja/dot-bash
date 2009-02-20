alias matep="mate ~/.bash_profile"

# Mating rituals.
mateall() { mate `locate $1`; }
mateone() { select file in `locate $1`; do mate $file; break; done; }
materb() { mate `gemwhich $1`; }
mategem() {
  local gem=`gem which $1 | sed -Ee 's%^(.*/gems/[^/]+).*$%\1%'`
  if [[ $gem != Can\'t\ find\ * ]]
    then mate $gem
    else echo $gem
  fi
}
materel() { echo 'tell application "TextMate" to reload bundles' |  osascript; }
