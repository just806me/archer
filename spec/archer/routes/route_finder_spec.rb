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

      it { expect(subject.find_for update).to eq route }
    end
  end

  describe '.find_and_process' do
    before { expect(subject).to receive(:find_for).with(update).and_return(route) }

    after { subject.find_and_process update }

    context do
      let (:route) { nil }

      it { expect(route).to_not receive(:process) }
    end

    context do
      let (:route) { double }

      it { expect(route).to receive(:process).with(update) }
    end
  end
end
