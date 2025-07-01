# This Puppet manifest configures SSH client to use private key authentication and disable password auth
file_line { 'Turn off passwd auth':
  path  => '/etc/ssh/ssh_config',
  line  => '    PasswordAuthentication no',
  match => '^[#]*PasswordAuthentication',
}
file_line { 'Declare identity file':
  path  => '/etc/ssh/ssh_config',
  line  => '    IdentityFile ~/.ssh/school',
  match => '^[#]*IdentityFile ~/.ssh/school',
}