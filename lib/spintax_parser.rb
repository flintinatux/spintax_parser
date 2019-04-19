require 'spintax_parser/version'
require 'backports/1.9.1/array/sample' if RUBY_VERSION < '1.9.1'

module SpintaxParser

  SPINTAX_PATTERN = /\{([^{}]*)\}/

  def unspin(options={})
    spun = dup.to_s
    while spun =~ SPINTAX_PATTERN
      parse_the_spintax_in spun, options
    end
    spun
  end

  def count_spintax_variations
    spun = dup.to_s
    while spun =~ /([\{\|])([\|\}])/
      spun.gsub! /([\{\|])([\|\}])/, '\11\2'
    end
    spun.gsub! /[^{|}]+/, '1'
    spun.gsub! /\{/, '('
    spun.gsub! /\|/, '+'
    spun.gsub! /\}/, ')'
    spun.gsub! /\)\(/, ')*('
    spun.gsub! /\)1/, ')*1'
    spun.gsub! /1\(/, '1*('
    begin
      eval spun
    rescue SyntaxError
      nil
    end
  end

  private

    if RUBY_VERSION >= '1.9.3'
      def parse_the_spintax_in(spun, options={})
        spun.gsub!(SPINTAX_PATTERN) { $1.split('|',-1).sample options.dup }
      end
    else
      def parse_the_spintax_in(spun, options={})
        spun.gsub!(SPINTAX_PATTERN) { $1.split('|',-1).sample }
      end
    end
end
