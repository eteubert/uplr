module Uplr
	class UploadProgressNotifier

		def initialize(progress)
			@prev_message_time = 0
			progress.add_observer(self)
		end

		def update(progress)
			if progress.started? && !progress.complete?
				if current_time - @prev_message_time >= 1000
					notify_progress(progress.url, progress.percent)
				end
			end
		end

		private

		def notify_progress(url, percent)
			TerminalNotifier.notify("%.2f%" % percent, title: "Upload…", group: url)
			@prev_message_time = current_time
		end

		def current_time
			(Time.now.to_f * 1000.0).to_i
		end
	end
end