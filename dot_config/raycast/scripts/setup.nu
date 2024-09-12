source $nu.env-path

if (which bw | is-empty) {
  error make -u { msg: "The Bitwarden CLI is not installed." }
}
