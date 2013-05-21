require 'spintax_parser/version'
require 'backports/1.9.1/array/sample' if RUBY_VERSION < '1.9.1'

module SpintaxParser
  
  SPINTAX_PATTERN = %r/\{([^{}]*)\}/

  def unspin(options={})
    spun = dup.to_s
    while spun =~ SPINTAX_PATTERN
      parse_the_spintax_in spun, options
    end
    spun
  end

  def count_spintax_variations
    spun = dup.to_s
    spun.gsub! %r/[^{|}]+/, '1'
    spun.gsub! %r/\{/, '('
    spun.gsub! %r/\|/, '+'
    spun.gsub! %r/\}/, ')'
    spun.gsub! %r/\)\(/, ')*('
    spun.gsub! %r/\)1/, ')*1'
    spun.gsub! %r/1\(/, '1*('
    eval spun
  end

  private

    if RUBY_VERSION >= '1.9.3'
      def parse_the_spintax_in(spun, options={})
        spun.gsub!(SPINTAX_PATTERN) { $1.split('|').sample(options) }
      end
    else
      def parse_the_spintax_in(spun, options={})
        spun.gsub!(SPINTAX_PATTERN) { $1.split('|').sample }
      end
    end
end
