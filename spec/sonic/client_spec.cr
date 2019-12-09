require "./../spec_helper"

module Sonic
  describe Client do
    include_context_client

    subject { client }

    describe "#channel" do
      let(type) { :control }

      it "returns instance of channel" do
        expect(subject.channel(type)).to be_a(Sonic::Channels::Control)
      end

      context "when type is invalid" do
        let(type) { :invalid }

        it "raises error" do
          expect { subject.channel(type) }.to raise_error(ArgumentError)
        end
      end
    end
  end
end