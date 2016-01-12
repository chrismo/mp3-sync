require 'boson/runner'
require 'text-table'
require_relative 'copyplaylst'
require_relative 'devices'
require_relative 'mk.album.playlist'

module Mp3Sync
  class Console < Boson::Runner
    desc 'List configured devices'

    def devices
      puts $devices_filename
      (DEVICES || {}).each do |name, settings|
        t = Text::Table.new
        t.head = [{value: name, colspan: 2, align: :center}]
        settings.each do |key, value|
          t.rows << [key, value]
        end
        puts t
      end
    end

    option :glob, type: :string, default: '*'
    option :device, type: :string
    desc 'Sync one or more playlists from current directory to device'

    def sync(options={})
      device_settings = options[:device] ? DEVICES[options[:device].to_sym] : DEVICES.first.last
      device_settings ||= DEVICES.first.last
      puts "Sync to #{device_settings}"
      PlaylistCopier.new(options[:glob]).execute(device_settings)
    end

    option :path, type: :string, required: true
    desc 'Create playlist from mp3s in a folder'

    def create(options={})
      PlaylistCreator.new(options[:path]).execute
    end
  end
end

