require_relative './file.system'

module GatherLists
  def gather_lists(glob)
    ARGV.clear
    playlist_glob = "{#{glob}}"
    playlist_glob = File.join(music_root, "*#{playlist_glob}*{m3u,}*")
    puts "Searching #{playlist_glob}..."
    hits = Dir[playlist_glob]
    hits = hits.select { |hit| hit.include?('m3u') }.uniq
    puts 'These playlists?'
    puts hits
    print 'Continue? (y/N) '
    gets.chomp =~ /y/i ? hits : []
  end
end
