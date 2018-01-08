require 'spec_helper'

RSpec.describe Archer::Routes::Route do
  let(:param) { }

  subject { described_class.new param, type: :type, to: 'some/path/to/test#action' }

  describe '#controller' do
    before { subject.instance_variable_set :@controller, :controller }

    its(:controller) { should eq :controller }
  end

  describe '#view' do
    context do
      before { subject.instance_variable_set :@view, :view }

      its(:view) { should eq :view }
    end

    context do
      before { subject.instance_variable_set :@view, nil }

      before { expect(Archer::Views::ViewFinder).to receive(:find_for).with('some/path/to/test', :action).and_return(:view) }

      its(:view) { should eq :view }
    end
  end

  describe '#for' do
    before do
      expect(subject).to receive_message_chain(:controller_klass, :new).with(:update).and_return(:controller)
    end

    it { expect(subject.for :update).to eq(subject) }

    after { expect(subject.controller).to eq :controller }
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
