def main [] {
  print "oops!"
}

let log = "~/.config/helix/log"

def "main height" [selection: string] {
  let count = $selection | lines | length
  $"counted ($count) lines\n" | save $log --append
  $count | pbcopy
}

def "main start" [file: any] {
  rm -f $log
  let file = if ($file | describe) != "string" {
    $env.PWD
  } else {
    $file
  }

  # Create pipe
  let temp = mktemp -p $env.TMPDIR
  rm $temp
  mkfifo $temp

  # Start yazi	
  $"starting zellij yazi for ($file) with pipe ($temp)\n" | save $log --append
  # FIXME: Update x, y, width, height to preferred size	
  # FIXME: /opt/homebrew/bin/nu may need to be updated to correct path	
  #        Try running `which nu`
  let height = try { (pbpaste | into int) + 1 } catch { "66%" }
  zellij run -f -c -x 1 -y 3 --width 50 --height $height -- /opt/homebrew/bin/nu ~/.config/helix/yazi.nu yazi $file $temp

  # Block until yazi writes to pipe	
  let result = cat $temp

  # Close yazi and emit result
  if $result != " " {
    zellij action close-pane
  }
  $result
}

def "main yazi" [file: string, pipe: string] {
  # Start yazi
  $"starting yazi for ($file) with pipe ($pipe)\n" | save $log --append
  # FIXME: /opt/homebrew/bin/yazi may need to be updated to correct path	
  #        Try running `which yazi`
  YAZI_PIPE=$pipe YAZI_CONFIG_HOME=~/.config/helix /opt/homebrew/bin/yazi $file

  # Pipe should be written to, if user quits without opening write " " to unblock `main start`
  " " | save -f $pipe

  # Delete temp pipe
  rm $pipe
}

def "main open" [file: string, pipe: string] {
  # Write filename to pipe	
  $"yazi opened ($file) with pipe ($pipe)\n" | save $log --append
  $file | save -f $pipe
  
  # Delete temp pipe	
  rm $pipe
}
