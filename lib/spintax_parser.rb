require "spintax_parser/version"
require "backports" if RUBY_VERSION < "1.9"

module SpintaxParser
  
  SPINTAX_PATTERN = %r/\{([^{}]*)\}/

  def unspin
    spun = clone.to_s
    while spun =~ SPINTAX_PATTERN
      spun.gsub!(SPINTAX_PATTERN) { $1.split('|').sample }
    end
    spun
  end

end # SpintaxParser