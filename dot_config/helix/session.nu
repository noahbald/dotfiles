def main [] {
  error make --unspanned { msg: "No arguments provided"}
}

def "main reset" [] {
  let file = $"~/.config/helix/session/($env.PWD | url encode -a)"
  $"reset ($file)" | save -f -a ~/.config/helix/log
  "" | save -f $file
  $file
}
def "main push" [buffer: string] {
  let file = $"~/.config/helix/session/($env.PWD | url encode -a)"
  $"push ($file)" | save -f -a ~/.config/helix/log
  $"($buffer)\n" | save -f -a $file
  $file
}
