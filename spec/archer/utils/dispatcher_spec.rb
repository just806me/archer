require 'spec_helper'

RSpec.describe Archer::Utils::Dispatcher do
  describe '.start' do
    subject { described_class }

    it { should delegate_method(:start).to(:new) }
  end

  describe '#start' do
    before { expect(subject).to receive(:loop).and_yield }

    before { expect(subject).to receive(:fetch_updates) }

    before { expect(subject).to receive(:process_updates) }

    it { expect { subject.start }.to_not raise_error  }
  end

  describe '#request' do
    context do
      before { subject.instance_variable_set :@request, :request }

      its(:request) { should eq :request }
    end

    context do
      before { subject.instance_variable_set :@request, nil }

      before { expect(Archer::Telegram::Request).to receive(:new).with(:get_updates).and_return(:request) }

      its(:request) { should eq :request }
    end
  end

  describe '#fetch_updates' do
    before { expect(subject).to receive_message_chain(:request, :send, :body).and_return(JSON.dump response_body) }

    context do
      let(:response_body) { { ok: true, result: :updates } }

      its(:fetch_updates) { should eq 'updates' }

      after { expect(subject.instance_variable_get :@updates).to eq('updates') }
    end

    context do
      let(:response_body) { { ok: false } }

      its(:fetch_updates) { should eq [] }

      after { expect(subject.instance_variable_get :@updates).to eq([]) }
    end
  end

  describe '#process_updates' do
    let(:call) { -> { subject.send :process_updates } }

    let(:params) { { offset: :offset } }

    before { expect(subject).to receive_message_chain(:request, :params).and_return(params) }

    context do
      before { subject.instance_variable_set :@updates, nil }

      it { expect(&call).to change { params[:offset] }.from(:offset).to(nil) }
    end

    context do
      let(:update) { double update_id: 1 }

      before { subject.instance_variable_set :@updates, [update] }

      before { expect(Archer::Utils::UpdateProcesser).to receive(:process) }

      it { expect(&call).to change { params[:offset] }.from(:offset).to(update.update_id + 1) }
    end
  end
end
