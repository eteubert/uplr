require 'net/scp'
require "pp"

module Uplr
  class ScpConnection

    def initialize(args)
      @host = args[:host]
      @user = args[:user]
      @path = args[:path]
      @path << '/' unless @path.end_with?('/')
      @base_url = args[:base_url]
    end

    def upload(local_file, filename, progress = nil)

      url = @base_url + filename

      Net::SCP.upload!(@host, @user, local_file, @path + filename) do |ch, name, sent, total|
        progress.update(sent, total, url) if progress
      end

      url
    end

  end
end