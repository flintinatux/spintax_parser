require 'spintax_parser'

class String
  include SpintaxParser
end

describe SpintaxParser do

  let(:plaintext) { 'Hello world. Please do not spin this.' }
  let(:spintext) { 'Find this. {Hello|Hi} to the {{world|worlds} out there|planet}{!|.|?} Cool.' }
  let(:spintax_pattern) { SpintaxParser::SPINTAX_PATTERN }

  describe "calling unspin" do

    context "on plaintext" do
      it "does not change the plaintext" do
        expect { plaintext.unspin }.not_to change { plaintext }
      end

      let(:result) { plaintext.unspin }
      it "returns the same plaintext" do
        result.should == plaintext
      end
    end

    context "on spintext" do
      it "does not change the spintext" do
        expect { spintext.unspin }.not_to change { spintext }
      end

      let(:result) { spintext.unspin }
      subject { result }
      it { should_not == spintext }
      it { should_not =~ spintax_pattern }
    end

    if RUBY_VERSION >= '1.9.3'
      context "with the same rng supplied" do
        it "produces the same unspun version each time" do
          seed = Random.new_seed
          unspun1 = spintext.unspin :random => Random.new(seed)
          unspun2 = spintext.unspin :random => Random.new(seed)
          unspun1.should eq unspun2
        end
      end
    end
  end

  it "should count spun variations correctly" do
    'one {two|three} four'.count_spintax_variations.should eq 2
    '{one|two {three|four}} five'.count_spintax_variations.should eq 3
    '{one|two} three {four|five}'.count_spintax_variations.should eq 4
    'one {{two|three} four|five {six|seven}} eight {nine|ten}'.count_spintax_variations.should eq 8
    '{Hello|Hi} {{world|worlds}|planet}{!|.|?}'.count_spintax_variations.should eq 18
    '{one|two|}'.count_spintax_variations.should eq 3
    "{Can't|count|this one".count_spintax_variations.should eq nil
  end
end
