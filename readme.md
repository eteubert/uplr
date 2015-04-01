# FileCloud — Minimalistic File Upload for Mac OS X

Uploads Files via SSH to you own server and copies resulting URL to clipboard for easy sharing.

## Setup

```
git clone https://github.com/eteubert/file-cloud.git
cd file-cloud
bundle install
```

## Usage

```
ruby upload.rb --help

Upload Files via SCP
    -f, --file --help                File to upload
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

```
ruby upload.rb --host example.com --user john --path /srv/www/example.com/public_html/u/ --base-url http://www.example.com/u/ /path/to/file.png
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