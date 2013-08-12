require 'spec_helper'

class Creator
  attr_reader :name
  def initialize(name)
    @name = name
  end
  def to_s
    name
  end
  def presenter_name
    'CreatorValuePresenter'
  end
end
module Hydra::ObjectViewer::Presenters
  class CreatorValuePresenter < Hydra::ObjectViewer::ValuePresenter
  end
  class WatchPresenter < Hydra::ObjectViewer::Presenter
    def classification
      "Things That Tick"
    end
    def description
      "<p class='line'>#{model.description}</p>".html_safe
    end

    presents :metadata_attributes do
      [Creator.new('Johnny Switchblade')]
    end
  end
end

describe 'Render A Presenter' do
  let(:object) { Watch.create! {|w| w.title = "My Title"; w.description = "My Description" } }
  let(:engine_mount_point) {
    # This may very well change and could be very fragile. In our use case
    # I am not as concerned.
    #
    # https://github.com/rails/rails/issues/4940
    Hydra::ObjectViewer::Engine.routes._generate_prefix({})
  }
  let(:path_to_object) {
    File.join(engine_mount_point, object.to_param)
  }
  it do
    visit path_to_object
    expect(page).to have_tag(".object-viewer#watch_#{object.id}") do
      with_tag('.primary-content') do
        with_tag('.title', text: object.title )
        with_tag('.classification', text: "Things That Tick" )
        with_tag('.description .line', text: object.description)

        with_tag('.metadata') do
          with_tag('.creator.label', with_text: 'Creator')
          with_tag('.creator.value', with_text: 'Johnny Switchblade')
        end
      end
      with_tag('.related')
    end
  end
end