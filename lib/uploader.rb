require 'securerandom'

class Uploader

	def initialize(connection)
		@connection = connection
	end

	def upload(local_file, progress = nil)
		file_extension = File.extname(local_file)
		filename = uuid + file_extension

		url = @connection.upload(local_file, filename, progress)

		{ url: url }
	end

	private def uuid
		SecureRandom.urlsafe_base64(10)
	end

end