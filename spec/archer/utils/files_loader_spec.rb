require 'spec_helper'

RSpec.describe Archer::Utils::FilesLoader do
  describe '.load' do
    before { expect(Dir).to receive(:glob).with(:path).and_yield(:file) }

    before { expect(described_class).to receive(:require).with(:file) }

    it { expect { described_class.load :path }.to_not raise_error }
  end
end
