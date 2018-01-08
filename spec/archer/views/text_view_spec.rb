require 'spec_helper'

RSpec.describe Archer::Views::TextView do
  subject { described_class.new :path }

  describe '#render_for' do
    context do
      before { subject.instance_variable_set :@content, :content }

      it { expect(subject.render_for :binding).to eq(:content) }
    end

    context do
      before { subject.instance_variable_set :@content, nil }

      before { expect(File).to receive(:read).with(:path).and_return(:content) }

      it { expect(subject.render_for :binding).to eq(:content) }
    end
  end
end
