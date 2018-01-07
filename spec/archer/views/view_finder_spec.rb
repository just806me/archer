require 'spec_helper'

RSpec.describe Archer::Views::ViewFinder do
  subject { described_class.new 'controller_path', :action }

  describe '#find' do
    context do
      before { expect(subject).to receive(:find_rendered_view).and_return(:rendered_view) }

      its(:find) { should eq :rendered_view }
    end

    context do
      before { expect(subject).to receive(:find_rendered_view).and_return(nil) }

      before { expect(subject).to receive(:find_text_view).and_return(:text_view) }

      its(:find) { should eq :text_view }
    end
  end

  describe '#path' do
    context do
      before { subject.instance_variable_set :@path, :path }

      its(:path) { should eq :path }
    end

    context do
      before { expect(Archer::CONFIG).to receive(:root_dir).and_return('root_dir') }

      its(:path) { should eq 'root_dir/app/views/controller_path' }
    end
  end

  describe '#find_rendered_view' do
    before { expect(subject).to receive(:path).and_return('path') }

    context do
      before { expect(File).to receive(:exists?).with('path/action.txt.erb').and_return(true) }

      before { expect(Archer::Views::RenderedView).to receive(:new).with('path/action.txt.erb').and_return(:view) }

      its(:find_rendered_view) { should eq :view }
    end

    context do
      before { expect(File).to receive(:exists?).with('path/action.txt.erb').and_return(false) }

      its(:find_rendered_view) { should be_nil }
    end
  end

  describe '#find_text_view' do
    before { expect(subject).to receive(:path).and_return('path') }

    context do
      before { expect(File).to receive(:exists?).with('path/action.txt').and_return(true) }

      before { expect(Archer::Views::TextView).to receive(:new).with('path/action.txt').and_return(:view) }

      its(:find_text_view) { should eq :view }
    end

    context do
      before { expect(File).to receive(:exists?).with('path/action.txt').and_return(false) }

      its(:find_text_view) { should be_nil }
    end
  end
end
