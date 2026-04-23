const recipes = {
  command: {
    rg: [
			"--disabled",
			"--ansi",
			"--multi",
			"--bind",
			"start:reload:rg --column --color=always --smart-case {q}",
			"--bind",
			"change:reload:rg --column --color=always --smart-case {q}",
			"--delimiter",
			":",
    ]
  },
  preview: {
    bat: [
			"--preview",
			"bat -n --color=always {}",
    ],
    bat_line: [
			"--preview",
			"bat --color=always --highlight-line {2} {1}",
			"--preview-window",
			"~4,+{2}+4/3,<80(up)",
    ]
  }
}

def main [] {
  error make --unspanned { msg: "No arguments provided"}
}

def "main start" [$name?: string = "files"] {
  # Create pipe
  let temp = mktemp -p $env.TMPDIR
  rm $temp
  mkfifo $temp

  zellij run -f -c -n $name -- env $"FZF_DEFAULT_OPTS=($env.FZF_DEFAULT_OPTS)" nu ~/.config/helix/fzf.nu fzf $temp $name

  # Block until fzf writes to pipe	
  let result = cat $temp

  $result
}

def "main fzf" [pipe: string, name: string] {
  # Start fzf
  try {
    let result = if $name == "files" {
      run files
    } else if $name == "grep" {
      run grep
    } else {
      error make {}
    }
    $result | save -f $pipe
  } catch {
    " " | save -f $pipe
  }

  # Delete temp pipe
  rm $pipe
}

def "run files" [] {
  fzf ...$recipes.preview.bat
}

def "run grep" [] {
  ($env.PWD | path join (fzf ...$recipes.preview.bat_line ...$recipes.command.rg))
    | split row ":"
    | slice 0..-2
    | str join ":"
}
