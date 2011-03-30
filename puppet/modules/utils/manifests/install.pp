class utils::install {

    package {
        "curl":
            ensure => present;
        "telnet":
            ensure => present;
        "nc":
            ensure => present;
        "bind-utils":
            ensure => present;
    }

}
