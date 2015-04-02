require 'rubygems'
require 'bundler/setup'
require 'terminal-notifier'
require 'micro-optparse'

require_relative 'lib/scp_connection'
require_relative 'lib/uploader'
require_relative 'lib/upload_progress'
require_relative 'lib/upload_progress_notifier'
require_relative 'lib/upload_complete_notifier'
require_relative 'lib/upload_clipboard_handler'

options = Parser.new do |p|
	p.banner = <<-BANNER
NAME
	upload -- Upload Files via SCP

SYNOPSIS
	upload [options] file

DESCRIPTION
	Uploads the specified file to the given server.
	Progress is shown via system notifications (disable with --no-progress). 
	The final notification is clickable and opens the share URL in a web 
	browser. The share URL is automatically copied to the system clipboard 
	(disable with --no-clipboard).

OPTIONS
BANNER
	p.version = "1.0"
	p.option :file, "File to upload (or pass as last argument)", default: ARGV.last
	p.option :host, "Connection: host", default: 'example.com'
	p.option :user, "Connection: user", default: 'john'
	p.option :path, "Connection: path", default: '/srv/www/example.com/public_html/u/'
	p.option :base_url, "Upload URL directory", default: 'http://www.example.com/u/'
	p.option :progress, "Show upload progress notifications", default: true
	p.option :clipboard, "Copy final URL to clipboard", default: true
end.process!

connection = ScpConnection.new(
	host: options[:host],
	user: options[:user],
	path: options[:path],
	base_url: options[:base_url]
)

uploader = Uploader.new(connection)
progress = UploadProgress.new

if options[:clipboard]
	UploadClipboardHandler.new(progress)
end

if options[:progress]
	UploadProgressNotifier.new(progress)
end

UploadCompleteNotifier.new(progress, options[:clipboard])

uploader.upload(options[:file], progress)
