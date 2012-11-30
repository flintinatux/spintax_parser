require "spintax_parser/version"
require "backports" if RUBY_VERSION < "1.9"

module SpintaxParser
  
  SPINTAX_PATTERN = %r/\{([^{}]*)\}/

  def unspin
    spun = dup.to_s
    while spun =~ SPINTAX_PATTERN
      spun.gsub!(SPINTAX_PATTERN) { $1.split('|').sample }
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

end # SpintaxParser