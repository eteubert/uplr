require 'net/scp'

class ScpConnection

	def initialize(args)
		@host = args[:host]
		@user = args[:user]
		@path = args[:path]
		@base_url = args[:base_url]

		@path << '/' unless @path.end_with?('/')
	end

	def upload(local_file, filename)
		Net::SCP.upload!(@host, @user, local_file, @path + filename) do |ch, name, sent, total| 
			# track progress
		end

		@base_url + filename
	end

end