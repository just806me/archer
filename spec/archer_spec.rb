require 'spec_helper'

RSpec.describe Archer do
  describe '::CONFIG' do
    let(:default_config) { OpenStruct.new telegram: OpenStruct.new(parse_mode: :markdown, token: nil), root_dir: nil }

    it { expect(Archer::CONFIG).to eq(default_config) }
  end

  describe '::ROUTES' do
    it { expect(Archer::ROUTES).to be_a(Hash) }

    it { expect(Archer::ROUTES[:a_missing_key]).to eq([]) }
  end

  describe '.configure' do
    let(:config) { described_class.configure { |c| return c } }

    it { expect(config).to eq(Archer::CONFIG) }
  end

  describe '.draw_routes' do
    let(:drawer) { described_class.draw_routes { |d| return d } }

    it { expect(drawer).to eq(Archer::Routes::RouteDrawer) }
  end
end
