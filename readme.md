# FileCloud — Minimalistic File Upload for Mac OS X

Uploads Files via SSH to you own server and copies resulting URL to clipboard for easy sharing.

## Setup

```
git clone https://github.com/eteubert/file-cloud.git
cd file-cloud
bundle install
# edit paths in upload.rb ... or wait until I convert these into options
```

## Usage

```
ruby upload.rb upload.rb /path/to/file
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