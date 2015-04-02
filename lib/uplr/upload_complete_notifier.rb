module Uplr
	class UploadCompleteNotifier

		def initialize(progress, clipboard)
			@clipboard = clipboard
			progress.add_observer(self)
		end

		def update(progress)
			if progress.complete?
				notify_complete(progress.url)
			end
		end

		private

		def notify_complete(url)
			args = {title: "Upload Complete", open: url, group: url}

			if @clipboard
				args[:subtitle] = "URL copied to clipboard."
			end

			TerminalNotifier.notify url, args
		end
	end
end