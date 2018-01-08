require 'spec_helper'

RSpec.describe Archer::Views::RenderedView do
  subject { described_class.new :path }

  describe '#render_for' do
    before { expect(subject).to receive_message_chain(:renderer, :result).with(:binding).and_return(:content) }

    it { expect(subject.render_for :binding).to eq(:content) }
  end

  describe '#renderer' do
    context do
      before { subject.instance_variable_set :@renderer, :renderer }

      its(:renderer) { should eq :renderer }
    end

    context do
      before { subject.instance_variable_set :@renderer, nil }

      before { expect(File).to receive(:read).with(:path).and_return(:file) }

      before { expect(ERB).to receive(:new).with(:file).and_return(:renderer) }

      its(:renderer) { should eq :renderer }
    end
  end
end
