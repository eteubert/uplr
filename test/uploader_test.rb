require 'test/helper.rb'

require "lib/scp_connection"
require "lib/uploader"

class UploaderTest < Minitest::Test 

	def setup
		@connection = ScpConnection.new(
			host: 'ericteubert.de',
			user: 'eric',
			path: '/srv/www/ericteubert.de/public_html/u/',
			base_url: 'http://www.ericteubert.de/u/'
		)

		Net::SCP.stubs(:upload!).returns(true)
	end

	def test_something
		uploader = Uploader.new(@connection)
		uploader.stubs(:uuid).returns('ASDQWE')
		
		result = uploader.upload('/test/file.png')

		assert_equal(result[:url], 'http://www.ericteubert.de/u/ASDQWE.png')
	end

end