require 'spec_helper'

RSpec.describe Archer::Controller do
  subject { described_class.new :update }

  it { should delegate_method(:helper_methods).to(:class) }

  describe '#binding' do
    context do
      before { subject.instance_variable_set :@binding, :binding }

      its(:binding) { should eq :binding }
    end

    context do
      before { subject.instance_variable_set :@binding, nil }

      before { expect(subject).to receive_message_chain(:binding_module, :get_binding).and_return(:binding) }

      its(:binding) { should eq :binding }
    end
  end

  describe '#binding_module' do
    context do
      before { subject.instance_variable_set :@binding_module, :binding_module }

      its(:binding_module) { should eq :binding_module }
    end

    context do
      let(:binding_module) { subject.send :binding_module }

      before { subject.helper_methods << :a_helper_method }

      it { expect(binding_module.instance_variable_get :@controller).to eq(subject) }

      it { expect(binding_module.singleton_methods).to include(:a_helper_method) }

      it { expect(binding_module).to be_a(Archer::Views::ViewHelper) }

      context do
        before { subject.class.define_method(:a_helper_method) {} }

        it { expect(subject).to receive(:a_helper_method) }

        after { binding_module.a_helper_method }
      end
    end
  end

  context do
    subject { described_class }

    describe '.helper_methods' do
      context do
        before { subject.instance_variable_set :@helper_methods, [] }

        its(:helper_methods) { should eq [] }
      end

      context do
        before { subject.instance_variable_set :@helper_methods, nil }

        its(:helper_methods) { should eq [] }
      end
    end

    describe '.helper_method' do
      it { expect { subject.helper_method :method }.to change { subject.helper_methods }.by([:method]) }
    end
  end
end
