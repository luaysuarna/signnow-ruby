require "spec_helper"

describe Signnow::Base do
  describe "#parse_timestamps" do
    context "given #created is present" do
      it "creates a Time object" do
        base = Signnow::Base.new(created: 1358300444)
        base.created.class.should eql(Time)
      end
    end
  end
end
