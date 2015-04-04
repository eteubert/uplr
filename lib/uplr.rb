require 'rubygems'
require 'bundler/setup'
require 'terminal-notifier'
require 'micro-optparse'

require 'uplr/scp_connection'
require 'uplr/uploader'
require 'uplr/upload_progress'
require 'uplr/upload_progress_notifier'
require 'uplr/upload_complete_notifier'
require 'uplr/upload_clipboard_handler'
require 'uplr/version'

parser = Parser.new do |p|
  p.banner = <<-BANNER
NAME
  uplr -- Upload Files via SCP

SYNOPSIS
  uplr [options] file

DESCRIPTION
  Uploads the specified file to the given server.
  Progress is shown via system notifications (disable with --no-progress).
  The final notification is clickable and opens the share URL in a web
  browser. The share URL is automatically copied to the system clipboard
  (disable with --no-clipboard).

OPTIONS
BANNER
  p.version = Uplr::VERSION
  p.option :file, "File to upload (or pass as last argument)", default: ARGV.last
  p.option :host, "Connection: host", default: 'example.com'
  p.option :user, "Connection: user", default: 'john'
  p.option :path, "Connection: path", default: '/srv/www/example.com/public_html/u/'
  p.option :base_url, "Upload URL directory", default: 'http://www.example.com/u/'
  p.option :progress, "Show upload progress notifications", default: true
  p.option :clipboard, "Copy final URL to clipboard", default: true
end

options = parser.process!

if !options[:file]
  parser.process!(["--help"])
  exit
end

if !File.exists?(options[:file])
  puts "Error: File \"#{options[:file]}\" does not exist\n\n"
  parser.process!(["--help"])
  exit
end

connection = Uplr::ScpConnection.new(
  host: options[:host],
  user: options[:user],
  path: options[:path],
  base_url: options[:base_url]
)

uploader = Uplr::Uploader.new(connection)
progress = Uplr::UploadProgress.new

if options[:clipboard]
  Uplr::UploadClipboardHandler.new(progress)
end

if options[:progress]
  Uplr::UploadProgressNotifier.new(progress)
end

Uplr::UploadCompleteNotifier.new(progress, options[:clipboard])

uploader.upload(options[:file], progress)
