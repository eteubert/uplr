module Uplr
  class UploadProgressBar

    def initialize(progress)
      progress.add_observer(self)
      @progressbar = ProgressBar.create(
        :format         => '%a %bᗧ%i %p%% %t',
        :progress_mark  => ' ',
        :remainder_mark => '･',
        :total          => 100
      )
    end

    def update(progress)
      @progressbar.progress = progress.percent
    end

  end
end