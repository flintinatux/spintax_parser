# SpintaxParser

Monkey patches two new string methods to unspin text written in spintax for automated article generation. Can handle nested spintax.

## Installation

Add this line to your application's Gemfile:

    gem 'spintax_parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spintax_parser

## Usage

    spintext = "{Hello|Hi} {{world|worlds}|planet}{!|.|?}"
    10.times do
      puts spintext.unspin
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
