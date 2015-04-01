require "observer"

class UploadProgress
	include Observable

	attr_reader :sent, :total, :url

	def initialize
		@sent  = 0
		@total = 0
	end

	def update(sent, total, url)
		@sent  = sent
		@total = total
		@url   = url
		changed
		notify_observers(self)
	end

	def percent
		@sent.to_f / @total * 100
	end

	def complete?
		@sent > 0 && @sent == @total
	end

	def started?
		@sent > 0 && @total > 0
	end
end