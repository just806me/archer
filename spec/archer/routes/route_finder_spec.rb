require 'spec_helper'

RSpec.describe Archer::Routes::RouteFinder do
  subject { described_class }

  let(:update) { double type: :type }

  describe '.find_for' do
    before { Archer::ROUTES.clear }

    it { expect(subject.find_for update).to eq nil }

    context do
      let(:route) { double match?: true }

      before { Archer::ROUTES[:type] << route }

      before { expect(route).to receive(:for).with(update).and_return(route) }

      it { expect(subject.find_for update).to eq(route) }
    end
  end
end
