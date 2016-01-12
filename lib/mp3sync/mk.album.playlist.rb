# Easiest to run from music_root

require_relative './file.system'

class PlaylistCreator
  def initialize(dir)
    @dir = dir
    normalize_dir
  end

  def normalize_dir
    unless File.exist?(@dir)
      abs_dir = File.join(music_root, @dir)
      if File.exist?(abs_dir)
        @dir = abs_dir
      else
        raise "Cannot find #{@dir}"
      end
    end
  end

  def execute
    dest_dir = music_root
    album_name = File.basename(@dir)
    m3u_fn = File.join(dest_dir, "#{album_name}.m3u")
    m3u = File.open(m3u_fn, 'w')
    m3u.puts '#EXTM3U'

    Dir["#{@dir}/**/*mp3"].each { |src_fn| m3u.puts src_fn.squeeze(File::SEPARATOR) }

    puts "#{m3u_fn} created"
  end
end
