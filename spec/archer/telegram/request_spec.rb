require 'spec_helper'

RSpec.describe Archer::Telegram::Request do
  subject { described_class.new method: :method, params: :params }

  it { should delegate_method(:base_url).to(:class) }

  describe '.base_url' do
    subject { described_class }

    context do
      before { subject.instance_variable_set :@base_url, :base_url }

      its(:base_url) { should eq :base_url }
    end

    context do
      before { subject.instance_variable_set :@base_url, nil }

      before { expect(Archer::CONFIG).to receive_message_chain(:telegram, :token).and_return(:token) }

      its(:base_url) { should eq 'https://api.telegram.org/bottoken/' }
    end
  end

  describe '#params' do
    its(:params) { should eq :params }

    context do
      subject { described_class.new method: :method }

      its(:params) { should eq Hash.new }
    end
  end

  describe '#send' do
    before { expect(subject).to receive(:url).and_return(:url) }

    it { expect(Net::HTTP).to receive(:post_form).with(:url, :params) }

    after { subject.send }
  end

  describe '#url' do
    context do
      before { subject.instance_variable_set :@url, :url }

      its(:url) { should eq :url }
    end

    context do
      before { expect(subject).to receive(:base_url).and_return('https://api.telegram.org/bottoken/') }

      its(:url) { should eq URI('https://api.telegram.org/bottoken/method') }
    end
  end
end
