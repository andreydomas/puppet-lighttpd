class lighttpd {

    File {
        ensure => directory,
        mode => 750,
        owner => 0,
        group => 0
    }

    package { lighttpd: } ->

    file { [
        "/etc/lighttpd",
        "/etc/lighttpd/conf-available",
        "/etc/lighttpd/conf-enabled"
    ]: } ->

    Lighttpd::Vhost<||> ~>

    service { lighttpd:
        ensure => running
    }

}
