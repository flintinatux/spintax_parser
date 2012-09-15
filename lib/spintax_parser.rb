require "spintax_parser/version"

module SpintaxParser
  
  SPINTAX_PATTERN = /{([^{}]*)}/

  def unspin
    spun = clone.to_s
    while spun =~ SPINTAX_PATTERN
      spun.gsub!(SPINTAX_PATTERN) { $1.split('|').sample }
    end
    spun
  end

end # SpintaxParser