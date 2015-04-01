require 'rubygems'
require 'bundler/setup'
require 'net/scp'
require 'securerandom'
require 'terminal-notifier'
require 'micro-optparse'

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
end.process!

remote_host = 'ericteubert.de'
remote_user = 'eric'
local_path  = options[:file]
remote_path = '/srv/www/ericteubert.de/public_html/u/'
upload_base_url = 'http://www.ericteubert.de/u/'

uuid = SecureRandom.urlsafe_base64(10)
file_extension = File.extname(local_path)
notification_group = "file_cloud_#{uuid}"

file_name   = uuid + file_extension
remote_file = remote_path + file_name
upload_url  = upload_base_url + file_name

last_message_time = 0
Net::SCP.upload!(remote_host, remote_user, local_path, remote_file) do |ch, name, sent, total| 
	progress = (sent.to_f/total * 100)

	if Time.now.to_ms - last_message_time > 800 || progress == 100
		TerminalNotifier.notify("%.2f%" % progress, title: "Upload…", open: upload_url, group: notification_group)
		last_message_time = Time.now.to_ms
	end
end

TerminalNotifier.notify(
	"URL copied to clipboard.", 
	title: "Upload Complete", open: upload_url, group: notification_group, subtitle: upload_url
)
pbcopy(upload_url)