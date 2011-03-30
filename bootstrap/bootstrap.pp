file { "/etc/puppet":
    ensure => directory,
}

ssh_authorized_key { "stockrt@gmail.com":
    ensure  => present,
    key     => "AAAAB3NzaC1yc2EAAAABIwAAAQEAtUWjLdiYFMss/2mlC2/bBIaEN6ZgfNA9f2j3m+hQPcJd4TRuxzKv4JHFA0LvrC4XAU8yCDi/FLS4j5N/qc5fdX8pD9gVB4DOTUj8bbhAQCH74zfOoydnzJC3KX+vZWDYnyC5mmyLTCF6m4yMIoWSqmSu6ljvyIJ9a3tPkP5pVbxFDObQKmnbhavea1opoEfHYAbjkJWUiex1CJ4JEnNT5pdRlFsyoWA3lOKZH1Ty1KxuW6Cx6Rq9Z0yOaPfAZOEKrezIxA2u+YwfU86Ns3m/lGkED0gx7k0zVVRl3NGvmoMl7mU9tN9S5b99q2F4jvHF4xI2+uDrqW6eQsZ0FVxboQ==",
    type    => rsa,
    user    => "root",
}
