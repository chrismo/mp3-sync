require 'fileutils'

require_relative './abs.path.stripper'
require_relative './devices'
require_relative './file.system'
require_relative './gather.lists'
require_relative './slash.fixer'

class PlaylistCopier
  include GatherLists

  def initialize(playlist_glob)
    @playlist_glob = playlist_glob
  end

  def execute(device)
    Dir.chdir(music_root) do
      gather_lists(@playlist_glob).each do |playlist_fn|
        puts "Starting #{playlist_fn}..."

        AbsPathStripper.new(playlist_fn).execute

        dst_root = device[:dst_root]
        rsync_args = device[:rsync_args]
        parse_list(playlist_fn).each do |item|
          src = item
          dst = dst_root

          rsync src, dst, rsync_args
        end

        rsync playlist_fn.gsub(music_root, ''), dst_root, rsync_args
        #path_style_method = (ENV['DEVICE_PATH_STYLE'] || 'rbpath').to_sym
        #fix_list(dst, path_style_method)
      end
    end
  end

  def rsync(src, dst, args='')
    dst = dst.gsub(' ', "\\ ")
    # Using the -R rsync flag helps with dir creation on dst
    cmd = %Q(rsync -R #{args} --progress "#{src}" "#{dst}")
    puts cmd
    system cmd
  end

  def parse_list(list)
    songs = []
    File.open(list, 'r:utf-8') do |f|
      songs = f.readlines
    end
    raise "no lines found in #{list}" if songs.empty?
    songs.delete_if { |ln| ln =~ /#EXT/ }
    raise "no songs found in #{list}" if songs.empty?
    songs.collect { |song| song.rbpath.strip }
  end
end
