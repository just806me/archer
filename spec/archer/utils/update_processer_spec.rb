require 'spec_helper'

RSpec.describe Archer::Utils::UpdateProcesser do
  subject { described_class.new :update }

  it { should delegate_method(:controller).to(:route) }

  it { should delegate_method(:view).to(:route) }

  it { should delegate_method(:action).to(:route) }

  describe '#process' do
    let(:controller) { double binding: :binding, action: :action }

    let(:view) { double }

    before { allow(subject).to receive(:controller).and_return(controller) }

    before { allow(subject).to receive(:view).and_return(view) }

    before { allow(subject).to receive(:action).and_return(:action) }

    before { expect(subject).to receive(:decorate_update!) }

    before { expect(view).to receive(:render_for).with(:binding).and_return(:content) }

    before { expect(subject).to receive_message_chain(:request, :send) }

    after { expect(subject.instance_variable_get :@content).to eq(:content) }

    context do
      before { expect(controller).to receive(:respond_to?).with(:action).and_return(true) }

      before { expect(controller).to receive(:action) }

      it { expect { subject.process }.to_not raise_error }
    end

    context do
      before { expect(controller).to receive(:respond_to?).with(:action).and_return(false) }

      before { expect(controller).to_not receive(:action) }

      it { expect { subject.process }.to_not raise_error }
    end
  end

  describe '#decorate_update!' do
    it { expect(Archer::Utils::UpdateDecorator).to receive(:decorate!).with(:update) }

    after { subject.send :decorate_update! }
  end

  describe '#route' do
    context do
      before { subject.instance_variable_set :@route, :route }

      its(:route) { should eq :route }
    end

    context do
      before { subject.instance_variable_set :@route, nil }

      before { expect(Archer::Routes::RouteFinder).to receive(:find_for).with(:update).and_return(:route) }

      its(:route) { should eq :route }
    end
  end

  describe '#request' do
    before { subject.instance_variable_set :@content, :content }

    before { subject.instance_variable_set :@update, update }

    before { expect(Archer::Telegram::Request).to receive(:new).with(method, params).and_return(:request) }

    context do
      before { expect(Archer::CONFIG).to receive_message_chain(:telegram, :parse_mode).and_return(:parse_mode) }

      let(:update) { double type: :text_message, message: double(chat: double(id: :chat_id)) }

      let(:method) { :send_message }

      let(:params) { { chat_id: :chat_id, text: :content, parse_mode: :parse_mode } }

      its(:request) { should eq :request }
    end
  end

  describe '.process' do
    it do
      expect(described_class).to receive(:new).with(:update) do
        double.tap { |a| expect(a).to receive(:process) }
      end
    end

    after { described_class.process :update }
  end
end
