require 'spec_helper'

RSpec.describe Archer::Routes::RouteDrawer do
  describe '.route' do
    before { Archer::ROUTES.clear }
    
    context do
      let(:call) { -> { described_class.route :param, type: :type, to: :to } }

      before { expect(Archer::Routes::Route).to receive(:new).with(:param, type: :type, to: :to).and_return(:route) }

      it { expect(&call).to change { Archer::ROUTES[:type] }.by([:route]) }
    end

    context do
      let(:call) { -> { described_class.route type: :type, to: :to } }

      before { expect(Archer::Routes::Route).to receive(:new).with(nil, type: :type, to: :to).and_return(:route) }

      it { expect(&call).to change { Archer::ROUTES[:type] }.by([:route]) }
    end
  end
end
