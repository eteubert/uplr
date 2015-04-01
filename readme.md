# FileCloud — Upload & Share Files Quickly

Uploads Files via SSH to you own server and copies resulting URL to clipboard for easy sharing.

## Requirements

* Ruby
* Mac OS X 10.8+
* Web Server with [SSH Private Key Authentication][2] to store files

## Setup

```
git clone https://github.com/eteubert/file-cloud.git
cd file-cloud
bundle install
```

## Help

```
ruby upload.rb --help

NAME
    ruby upload.rb -- Upload Files via SCP

SYNOPSIS
    ruby upload.rb [options] file

DESCRIPTION
    Uploads the specified file to the given server.
    Progress is shown via system notifications (disable with --no-progress). 
    The final notification is clickable and opens the share URL in a web 
    browser. The share URL is automatically copied to the system clipboard 
    (disable with --no-clipboard).

OPTIONS
    -f, --file --help                File to upload (or pass as last argument)
    -h, --host example.com           Connection: host
    -u, --user john                  Connection: user
    -p /srv/www/example.com/public_html/u/,
        --path                       Connection: path
    -b http://www.example.com/u/,    Upload URL directory
        --base-url
    -r, --[no-]progress              Show upload progress notifications
    -c, --[no-]clipboard             Copy final URL to clipboard
        --help                       Show this message
    -v, --version                    Print version
```

## Example

```shell
ruby upload.rb --host example.com \
    --user john \
    --path /srv/www/example.com/public_html/u/ \
    --base-url http://www.example.com/u/ \
    /path/to/file.png
```

## Recommendation

To maximize joy, pair with [Hazel][1].

1. Create "Uploads" folder
2. Drag "Uploads" folder into Dock
3. Create new rule in Hazel for "Uploads" folder, choose "Run Shell Script", "embedded script", "/bin/bash" and paste/adjust the following:

```
ruby ~/FileCloud/upload.rb "$1"
```

Note that depending on your ruby setup it might be necessary to provide the full path to the binary, for example `~/.rbenv/shims/ruby` for rbenv.

Now you just have to drag&drop a file to the dock folder and seconds later there is a shareable link in your clipboard. Awesome!

[1]: http://www.noodlesoft.com/hazel.php
[2]: https://help.ubuntu.com/community/SSH/OpenSSH/Keys