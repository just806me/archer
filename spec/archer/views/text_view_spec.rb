require 'spec_helper'

RSpec.describe Archer::Views::TextView do
  subject { described_class.new :path }

  describe '#request_for' do
    before { expect(Archer::Telegram::Request).to receive(:new).with(method: method, params: params).and_return(:request) }

    context do
      let(:update) { OpenStruct.new type: :text_message, message: OpenStruct.new(chat: OpenStruct.new(id: :chat_id)) }

      let(:method) { :send_message }

      let(:params) { { chat_id: :chat_id, text: :content, parse_mode: :markdown } }

      before { expect(Archer::CONFIG).to receive_message_chain(:telegram, :parse_mode).and_return(:markdown) }

      before { expect(subject).to receive(:content).and_return(:content) }

      it { expect(subject.request_for update).to eq(:request) }
    end
  end

  describe '#content' do
    context do
      before { subject.instance_variable_set :@content, :content }

      its(:content) { should eq :content }
    end

    context do
      before { subject.instance_variable_set :@content, nil }

      before { expect(File).to receive(:read).with(:path).and_return(:content) }

      its(:content) { should eq :content }
    end
  end
end
