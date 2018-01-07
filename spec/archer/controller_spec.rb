require 'spec_helper'

RSpec.describe Archer::Controller do
  subject { described_class.new :update, :path, :action }

  it { expect(Archer::Controller.views).to eq Hash.new }

  it { should delegate_method(:views).to(:class) }

  describe '#respond' do
    it do
      #
      # subject.view.request_for(:update).send
      #
      expect(subject).to receive_message_chain(:view, :request_for).with(:update) do
        double.tap { |a| expect(a).to receive(:send) }
      end
    end

    after { subject.send :respond }
  end

  describe '#method_missing' do
    it { expect(subject).to receive(:respond) }

    after { subject.a_missing_method }
  end

  describe '#respond_to_missing?' do
    it { expect(subject.respond_to? :a_missing_method).to eq(true) }
  end

  describe '#view' do
    context do
      before { subject.views[:action] = :view }

      its(:view) { should eq :view }
    end

    context do
      before { subject.views[:action] = nil }

      before do
        #
        # Archer::Views::ViewFinder.new(subject, :action).find -> :view
        #
        expect(Archer::Views::ViewFinder).to receive(:new).with(:path, :action) do
          double.tap { |a| expect(a).to receive(:find).and_return(:view) }
        end
      end

      its(:view) { should eq :view }
    end
  end
end
