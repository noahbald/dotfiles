# Helpers for using your nushell environment in zsh.
#
# Keep your environment setup in one place!
#
# ```nu
# # Update your nu env file
# use ~/zshrc.nu
# ```
#
# ```sh
# # Update your .zshrc file
# eval $(nu zshrc env)
# ```

# Takes serialisable env variables and formats them as a sourcable zsh script
export def env []: nothing -> string {
  $env
    | transpose
    | each {
        if ($in.column1 | describe) == "list<string>" {
          { column0: $in.column0, column1: ($in.column1 | str join ":") }
        } else { $in }
      }
    | where { ($in.column1 | describe) == "string" }
    | each { [$in.column0, $"\"($in.column1)\""] | str join "=" }
    | str join "\n"
}

# View subcommands
export def main []: nothing -> string {
  help zshrc
}
