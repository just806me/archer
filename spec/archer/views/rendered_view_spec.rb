require 'spec_helper'

RSpec.describe Archer::Views::RenderedView do
  subject { described_class.new :path }

  it { should be_a Archer::Views::TextView }

  describe '#content' do
    before { expect(subject).to receive(:binding).and_return(:binding) }

    before { expect(subject).to receive_message_chain(:renderer, :result).with(:binding).and_return(:content) }

    its(:content) { should eq :content }
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

  describe '#binding' do
    context do
      before { subject.instance_variable_set :@binding, :binding }

      its(:binding) { should eq :binding }
    end

    context do
      before { subject.instance_variable_set :@binding, nil }

      before { expect(Archer::Views::ViewHelper).to receive(:get_binding).and_return(:binding) }

      its(:binding) { should eq :binding }
    end
  end
end
