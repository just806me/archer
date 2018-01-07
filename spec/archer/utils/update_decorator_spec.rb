require 'spec_helper'

RSpec.describe Archer::Utils::UpdateDecorator do
  let(:subject) { described_class.new update }

  let(:update) { OpenStruct.new }

  describe '#decorate!' do
    subject { OpenStruct.new }

    let(:decorator) { described_class.new subject }

    before { expect(decorator).to receive(:update_type).and_return(:update_type) }

    before { expect(decorator).to receive(:update_data).and_return(:update_data) }

    before { decorator.decorate! }

    its(:type) { should eq :update_type }

    its(:data) { should eq :update_data }
  end

  describe '#update_type' do
    its(:update_type) { should be_nil }

    context do
      let(:update) { OpenStruct.new message: OpenStruct.new(text: :text) }

      its(:update_type) { should eq :text_message }
    end

    context do
      let(:update) { OpenStruct.new inline_query: :inline_query }

      its(:update_type) { should eq :inline_query }
    end

    context do
      let(:update) { OpenStruct.new callback_query: :callback_query }

      its(:update_type) { should eq :callback_query }
    end
  end

  describe '#update_data' do
    its(:update_data) { should be_nil }

    context do
      let(:update) { OpenStruct.new message: OpenStruct.new(text: :text) }

      its(:update_data) { should eq :text }
    end

    context do
      let(:update) { OpenStruct.new inline_query: OpenStruct.new(query: :query) }

      its(:update_data) { should eq :query }
    end

    context do
      let(:update) { OpenStruct.new callback_query: OpenStruct.new(data: :data) }

      its(:update_data) { should eq :data }
    end
  end

  describe '.decorate!' do
    it do
      #
      # described_class.new(:update).decorate!
      #
      expect(described_class).to receive(:new).with(:update) do
        double.tap { |a| expect(a).to receive(:decorate!) }
      end
    end

    after { described_class.decorate! :update }
  end
end
