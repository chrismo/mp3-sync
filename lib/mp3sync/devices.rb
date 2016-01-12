$devices_filename = File.expand_path('~/.mp3sync/devices.rb')
require $devices_filename if File.exists?($devices_filename)
