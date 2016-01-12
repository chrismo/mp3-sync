# Mp3Sync

A small collection of scripts that I keep dinking with over time to
assist with me easily dumping mp3s and auto-generated playlists to my
various devices. Because they grew from nothing and they've been
practically tested with actual usage, they have no automated tests.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mp3sync'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mp3sync

## Usage

Setup a ~/.mp3sync/devices.rb file that looks like this:

```ruby
DEVICES = {
  mine: {
    dst_root: 'root@192.168.1.16:/sdcard/media/audio/music/',
    rsync_args: '-e "ssh -p 2222"',
    style: :rbpath
  },
  yours: {
    dst_root: '/Volumes/TOTESMP3/MUSIC',
    style: :winpath
  }
}
```

Run `mp3sync` to see a list of commands. Get help on any
command by running `mp3sync help [command]`

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake
install`. To release a new version, update the version number in
`version.rb`, and then run `bundle exec rake release`, which will create
a git tag for the version, push git commits and tags, and push the
`.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/chrismo/mp3sync.


## License

The gem is available as open source under the terms of the 
[MIT License](http://opensource.org/licenses/MIT).

