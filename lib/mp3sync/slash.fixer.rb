require 'fileutils'

class String
  def winpath
    self.gsub(/\//, "\\")
  end
  
  def rbpath
    self.gsub(/\\/, '/')
  end
end

def fix_list(playlist_fn, meth=:rbpath)
  text = File.read(playlist_fn) 
  text = text.send(meth)
  File.open(playlist_fn, 'w') { |f| f.print text }
end

if __FILE__ == $0
  playlist_glob = '{' + ARGV.join(',') + '}'
  playlist_glob = "*#{playlist_glob}*{m3u,}*"
  hits = Dir[playlist_glob]
  hits.delete_if { |hit| !hit.include?('m3u') }
  hits.uniq!
  puts "Fix these playlists?"
  puts hits
  print "Continue? (y/N) "
  ARGV.clear
  exit if gets.chomp !~ /y/i
  hits.each do |playlist_fn|
    puts "Fixing #{playlist_fn}..."

    fix_list(playlist_fn)
  end  
end
