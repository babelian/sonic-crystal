require "./../../spec_helper"

module Sonic
  module Channels
    describe Control do
      include_examples_channel #rb include_examples 'channel'

      subject { client.channel(:control) }

      it "is a Control" do
        expect(subject).to be_a(Control)
      end

      describe "#trigger" do
        let(action) { "consolidate" }

        it "returns true" do
          expect(subject.trigger(action)).to eq(true)
        end

        context "when action is invalid" do
          let(action) { "invalid" }

          it "raises error" do
            expect { subject.trigger(action) }.to raise_error(ServerError)
          end
        end
      end
    end
  end
end

