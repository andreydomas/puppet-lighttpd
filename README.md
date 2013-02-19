Example
===============
```puppet
lighttpd::vhost { "example":

           name => "(www\.)?example.com",

           config => {
                "server.document-root" => "/var/www/example.com",
                "dir-listing.activate" => "disable",
                "index-file.names" => [ "index.html" ],
                "compress.filetype" => [ "text/html", "text/plain", "text/xml",
                                         "text/css", "application/x-javascript" ],
                "alias.url" => {
                    "/images"  => "/var/lib/images",
                    "/vendor"  => "/usr/share/vendor",
                },
            },

            rules => [
                {
                  match => "\$HTTP[\"url\"] =~ \"^/dists($|/)\"",
                  then => {  "dir-listing.activate" => "enable" }
                },
            ]

        }
```
will produce file `/etc/lighttpd/conf-available/example.conf`
```javascript
$HTTP["host"] =~ "(www\.)?example.com" {

    server.document-root = "/var/www/example.com"

    dir-listing.activate = "disable"

    index-file.names = ( "index.html" )

    compress.filetype = ( "text/html", "text/plain", "text/xml", "text/css", "application/x-javascript" )

    alias.url = ( "/images"  => "/var/lib/images", "/vendor"  => "/usr/share/vendor" )

    $HTTP["url"] =~ "^/dists($|/)" {
        dir-listing.activate = "enable"
    }

}
```
and make symlink `/etc/lighttpd/conf-enabled/example.conf` to it.
