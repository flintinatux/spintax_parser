require 'spintax_parser'

class String
  include SpintaxParser
end

describe SpintaxParser do

  let(:plaintext) { 'Hello world.' }
  let(:spintext) { 'Find this. {Hello|Hi} to the {{world|worlds} out there|planet}{!|.|?} Cool.' }
  let(:spintax_pattern) { /\{[^{}]*\}/ }

  describe "calling unspin" do
    
    describe "on plaintext" do
      
      it "should not change the plaintext" do
        expect { plaintext.unspin }.not_to change { plaintext }
      end

      let(:result) { plaintext.unspin }
      it "should return the same plaintext" do
        result.should == plaintext
      end
    end

    describe "on spintext" do
      
      it "should not change the spintext" do
        expect { spintext.unspin }.not_to change { spintext }
      end

      let(:result) { spintext.unspin }
      subject { result }
      it { should_not == spintext }
      it { should_not =~ spintax_pattern }
    end
  end

  it "should count spun variations correctly" do
    'one {two|three} four'.count_spintax_variations.should eq 2
    '{one|two {three|four}} five'.count_spintax_variations.should eq 3
    '{one|two} three {four|five}'.count_spintax_variations.should eq 4
    'one {{two|three} four|five {six|seven}} eight {nine|ten}'.count_spintax_variations.should eq 8
    '{Hello|Hi} {{world|worlds}|planet}{!|.|?}'.count_spintax_variations.should eq 18
  end
end