include lighttpd

define lighttpd::vhost($config={}, $aliases=[], $rules=[]) {

    File {
        mode => 640
    }

    file { "/etc/lighttpd/conf-available/${title}.conf":
        ensure => file,
        content => template("lighttpd/vhost.erb"),
    } ->

    file { "/etc/lighttpd/conf-enabled/${title}.conf":
        ensure => link,
        target => "/etc/lighttpd/conf-available/${title}.conf",
    }
}
