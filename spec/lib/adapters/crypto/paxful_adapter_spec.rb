require "spec_helper"

RSpec.describe CurrencyRate::PaxfulAdapter do
  before(:all) do
    @data, @normalized = data_for :paxful
  end

  let(:adapter) { described_class.instance }

  describe "#normalize" do
    it "brings data to cannonical form" do
      expect(adapter.normalize(@data)).to eq(@normalized)
    end
  end
end
