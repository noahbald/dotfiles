export def main [] {
  mut session: list<string> = []
  try {
    let token = security find-generic-password -a $env.USER -s raycast-bitwarden -w
    echo $token
    $session = [--session $token]
  }

  try {
    bw unlock --check ...$session
  } catch  { |error|
    echo $error
    error make -u { msg: "Vault is locked. Use the 'Log In' or 'Unlock' commands to enable searching." }
  }
  return $session
}
