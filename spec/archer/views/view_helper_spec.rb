require 'spec_helper'

RSpec.describe Archer::Views::ViewHelper do
  subject { described_class }

  context do
    before { expect(Archer::CONFIG).to receive_message_chain(:telegram, :parse_mode).and_return(parse_mode) }

    describe '.bold' do
      context do
        let(:parse_mode) { :html }

        it { expect(subject.bold 'text').to eq '<b>text</b>' }
      end

      context do
        let(:parse_mode) { :markdown }

        it { expect(subject.bold 'text').to eq '*text*' }
      end
    end

    describe '.italic' do
      context do
        let(:parse_mode) { :html }

        it { expect(subject.italic 'text').to eq '<i>text</i>' }
      end

      context do
        let(:parse_mode) { :markdown }

        it { expect(subject.italic 'text').to eq '_text_' }
      end
    end

    describe '.fixed' do
      context do
        let(:parse_mode) { :html }

        it { expect(subject.fixed 'text').to eq '<code>text</code>' }
      end

      context do
        let(:parse_mode) { :markdown }

        it { expect(subject.fixed 'text').to eq '`text`' }
      end
    end

    describe '.block' do
      context do
        let(:parse_mode) { :html }

        it { expect(subject.block 'text').to eq '<pre>text</pre>' }
      end

      context do
        let(:parse_mode) { :markdown }

        it { expect(subject.block 'text').to eq '```text```' }
      end
    end

    describe '.link' do
      context do
        let(:parse_mode) { :html }

        it { expect(subject.link 'text', 'url').to eq '<a href="url">text</a>' }
      end

      context do
        let(:parse_mode) { :markdown }

        it { expect(subject.link 'text', 'url').to eq '[text](url)' }
      end
    end

    describe '.mention' do
      context do
        let(:parse_mode) { :html }

        it { expect(subject.mention 'name', 'id').to eq '<a href="tg://user?id=id">name</a>' }
      end

      context do
        let(:parse_mode) { :markdown }

        it { expect(subject.mention 'name', 'id').to eq '[name](tg://user?id=id)' }
      end
    end
  end

  describe '.get_binding' do
    before { expect(subject).to receive(:binding).and_return(:binding) }

    its(:get_binding) { should eq :binding }
  end
end
