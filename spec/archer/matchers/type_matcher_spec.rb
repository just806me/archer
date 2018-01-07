require 'spec_helper'

RSpec.describe Archer::Matchers::TypeMatcher do
  subject { described_class.new :type }

  describe '#match?' do
    context do
      let(:update) { double type: :wrong_type }

      it { expect(subject.match? update).to eq(false) }
    end

    context do
      let(:update) { double type: :type }

      it { expect(subject.match? update).to eq(true) }
    end
  end
end
