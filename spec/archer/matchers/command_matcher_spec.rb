require 'spec_helper'

RSpec.describe Archer::Matchers::CommandMatcher do
  subject { described_class.new :command, :type }

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
      let(:update) { double type: :type, data: '/command' }

      it { expect(subject.match? update).to eq(true) }
    end
  end

  describe '#command_regex' do
    context do
      before { subject.instance_variable_set :@command_regex, :command_regex }

      its(:command_regex) { should eq :command_regex }
    end

    context do
      before { subject.instance_variable_set :@command_regex, nil }

      its(:command_regex) { should eq /\A\/command/ }
    end
  end
end
