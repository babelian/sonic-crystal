macro include_examples_channel
  include_context_client

  describe "#ping" do
    it "pongs" do
      expect(subject.ping).to eq("PONG")
    end
  end

  describe "#quit" do
    it "closes connection" do
      subject.quit
      expect { subject.connection.read }.to raise_error(Exception) #rb IOError
    end
  end
end