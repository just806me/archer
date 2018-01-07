require 'spec_helper'

RSpec.describe Archer::Matchers::RegexpMatcher do
  subject { described_class.new /regexp/, :type }

  describe '#match?' do
    context do
      let(:update) { double type: :wrong_type }

      it { expect(subject.match? update).to eq(false) }
    end

    context do
      let(:update) { double type: :type, data: :wrong_data }

      it { expect(subject.match? update).to eq(false) }
    end

    context do
      let(:update) { double type: :type, data: :regexp }

      it { expect(subject.match? update).to eq(true) }
    end
  end
end
