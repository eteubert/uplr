# copy url to clipboard when upload finishes
class UploadClipboardHandler
	def initialize(progress)
		progress.add_observer(self)
	end

	def update(progress)
		if progress.complete?
			notify(progress.url)
		end
	end

	private

	def notify(url)
		pbcopy(url)
	end

	def pbcopy(input)
		str = input.to_s
		IO.popen('pbcopy', 'w') { |f| f << str }
		str
	end
end
