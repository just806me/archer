require 'spec_helper'

RSpec.describe Archer::Routes::Route do
  let(:param) { }

  subject { described_class.new param, type: :type, to: 'some/path/to/test#action' }

  describe '#process' do
    it do
      #
      # subject.controller_klass.new(:update, :action).send(:action)
      #
      expect(subject).to receive_message_chain(:controller_klass, :new).with(:update, 'some/path/to/test', :action) do
        double.tap { |a| expect(a).to receive(:send).with(:action) }
      end
    end

    after { subject.process :update }
  end

  describe '#matcher' do
    context do
      before { subject.instance_variable_set :@matcher, :matcher }

      its(:matcher) { should eq :matcher }
    end

    context do
      let(:param) { /regexp/ }

      before { expect(Archer::Matchers::RegexpMatcher).to receive(:new).with(param, :type).and_return(:matcher) }

      its(:matcher) { should eq :matcher }
    end

    context do
      let(:param) { :command }

      before { expect(Archer::Matchers::CommandMatcher).to receive(:new).with(param, :type).and_return(:matcher) }

      its(:matcher) { should eq :matcher }
    end

    context do
      let(:param) { Class.new }

      before { expect(param).to receive(:new).and_return(:matcher) }

      its(:matcher) { should eq :matcher }
    end

    context do
      before { expect(Archer::Matchers::TypeMatcher).to receive(:new).with(:type).and_return(:matcher) }

      its(:matcher) { should eq :matcher }
    end
  end

  describe '#controller_klass' do
    before do
      module Some
        module Path
          module To
            class TestController; end
          end
        end
      end
    end

    its(:controller_klass) { should eq Some::Path::To::TestController }
  end
end
