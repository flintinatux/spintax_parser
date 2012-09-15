require 'spintax_parser'

describe String do

  let(:plaintext) { 'Hello world.' }
  let(:spintext) { 'Find this. {Hello|Hi} to the {{world|worlds} out there|planet}{!|.|?} Cool.' }
  let(:spintax_pattern) { /{[^{}]*}/ }

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

  describe "calling unspin!" do
    
    describe "on plaintext" do
      
      it "should not change the plaintext" do
        expect { plaintext.unspin! }.not_to change { plaintext }
      end

      let(:result) { plaintext.unspin! }
      it "should return nil" do
        result.should be nil
      end
    end

    describe "on spintext" do
      
      let!(:original) { spintext.dup }
      before { spintext.unspin! }
      subject { spintext }
      it { should_not == original }
      it { should_not =~ spintax_pattern }
    end
  end
end