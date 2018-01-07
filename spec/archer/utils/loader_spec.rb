require 'spec_helper'

RSpec.describe Archer::Utils::Loader do
  subject { described_class }

  before { expect(Archer::CONFIG).to receive(:root_dir).and_return('root_dir') }

  describe '.load_app' do
    it { expect(Archer::Utils::FilesLoader).to receive(:load).with('root_dir/app/**/*.rb') }

    after { subject.load_app }
  end

  describe '.load_config' do
    it { expect(Archer::Utils::FilesLoader).to receive(:load).with('root_dir/config/*.rb') }

    after { subject.load_config }
  end

  its(:app_path) { should eq 'root_dir/app/**/*.rb' }

  its(:config_path) { should eq 'root_dir/config/*.rb' }
end
