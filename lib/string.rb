# String
#
# Monkey patches two new string methods to unspin text written in
# spintax for automated article generation. Can handle nested spintax.
#
# spintext = "{Hello|Hi} {{world|worlds}|planet}{!|.|?}"
# 10.times do
#   puts spintext.unspin
# end

class String
  
  SPINTAX_PATTERN = /{([^{}]*)}/

  def unspin
    spun = clone
    while spun =~ SPINTAX_PATTERN
      spun.gsub!(SPINTAX_PATTERN) { $1.split('|').sample }
    end
    spun
  end

  def unspin!
    return nil if self !~ SPINTAX_PATTERN
    replace unspin
  end

end