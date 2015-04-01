require 'rubygems'
require 'bundler/setup'
require 'terminal-notifier'
require 'micro-optparse'

require_relative 'lib/scp_connection'
require_relative 'lib/uploader'

class Time
	def to_ms
		(self.to_f * 1000.0).to_i
	end
end

# copy input to os clipboard
def pbcopy(input)
	str = input.to_s
	IO.popen('pbcopy', 'w') { |f| f << str }
	str
end

options = Parser.new do |p|
	p.banner = "Upload Files via SCP"
	p.version = "1.0"
	p.option :file, "File to upload", short: "f", default: ARGV[0]
	p.option :host, "Connection: host", default: 'ericteubert.de'
	p.option :user, "Connection: user", default: 'eric'
	p.option :path, "Connection: path", default: '/srv/www/ericteubert.de/public_html/u/'
	p.option :base_url, "Upload URL directory", default: 'http://www.ericteubert.de/u/'
end.process!


connection = ScpConnection.new(
	host: options[:host],
	user: options[:user],
	path: options[:path],
	base_url: options[:base_url]
)

uploader = Uploader.new(connection)
result = uploader.upload(options[:file])

# last_message_time = 0
# Net::SCP.upload!(remote_host, remote_user, local_path, remote_file) do |ch, name, sent, total| 
# 	progress = (sent.to_f/total * 100)

# 	if Time.now.to_ms - last_message_time > 800 || progress == 100
# 		TerminalNotifier.notify("%.2f%" % progress, title: "Upload…", open: upload_url, group: notification_group)
# 		last_message_time = Time.now.to_ms
# 	end
# end

TerminalNotifier.notify(
	"URL copied to clipboard.", 
	title: "Upload Complete", open: result[:url], group: 'asd', subtitle: result[:url]
)
pbcopy(result[:url])