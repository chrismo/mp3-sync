require_relative './file.system'
require_relative './gather.lists'

class AbsPathStripper
  include GatherLists

  def initialize(playlist_fn)
    @playlist_fn = playlist_fn
  end

  def execute
    lines = nil
    File.open(@playlist_fn, 'r:utf-8') { |f| lines = f.readlines }
    lines.map! {|ln| ln.gsub(/#{Regexp.escape(music_root)}/, '') }
    lines.map! {|ln| ln.gsub(/\A\//, '') }
    File.open(@playlist_fn, 'w:utf-8') { |f| f.puts lines }
  end
end

class AbsPathStripBatch
  include GatherLists

  def initialize(glob)
    gather_lists(glob).each do |playlist_fn|
      puts "Processing #{playlist_fn}"
      AbsPathStripper.new(playlist_fn).execute
    end
  end
end

if __FILE__ == $0
  AbsPathStripBatch.new(ARGV.join(','))
end
