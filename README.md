# SpintaxParser  [![Build Status](https://secure.travis-ci.org/flintinatux/spintax_parser.png)](http://travis-ci.org/flintinatux/spintax_parser)  [![Dependency Status](https://gemnasium.com/flintinatux/spintax_parser.png)](https://gemnasium.com/flintinatux/spintax_parser)  [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/flintinatux/spintax_parser)

A mixin to parse "spintax", a text format used for automated article generation. Can handle nested spintax.

## Installation

Add this line to your application's Gemfile:

    gem 'spintax_parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spintax_parser

## Usage

Perhaps the simplest way to use it is to mix SpintaxParser directly into the global String class, like this:

    require 'spintax_parser'

    class String
      include SpintaxParser
    end

Then you can safely call `unspin` on any string in your application:

    spintext = "{Hello|Hi} {{world|worlds}|planet}{!|.|?}"
    10.times do
      puts spintext.unspin
    end

Run the code above, and you will end up with several random variations of the same text, such as:

    Hi worlds.
    Hi planet?
    Hello world?
    Hi planet?
    Hi world?
    Hi world!
    Hi world.
    Hello world.
    Hello world!
    Hello worlds.

And don't worry: calling `unspin` on a string with no spintax will safely return an unaffected copy of the string.

Also, note that the `unspin` method doesn't really care if the class you mix it into is a descendant of String or not, as long as its `to_s` method returns a string written in spintax.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
