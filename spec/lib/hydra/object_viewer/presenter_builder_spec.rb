require 'spec_helper'
require 'hydra/object_viewer/presenter_builder'

module Hydra::ObjectViewer

  describe PresenterBuilder do
    let(:presented_object) { double }
    let(:the_context) { double }
    subject {PresenterBuilder.call(presented_object, the_context)}

    it { should be_a_kind_of Presenter }

    module Presenters
      class TestPresenter < Hydra::ObjectViewer::Presenter
      end
      class ExplicitlyNamedPresenter < Hydra::ObjectViewer::Presenter
      end
    end

    it 'finds the presenter by interogating the object' do
      klass = double(name: 'Test')
      presented_object.should_receive(:class).and_return(klass)

      expect(subject).to be_kind_of(Hydra::ObjectViewer::Presenters::TestPresenter)
    end

    it 'finds the presenter by interogating the object' do
      presented_object.should_receive(:presenter_name).and_return('ExplicitlyNamedPresenter')
      expect(subject).to be_kind_of(Hydra::ObjectViewer::Presenters::ExplicitlyNamedPresenter)
    end
  end


end
