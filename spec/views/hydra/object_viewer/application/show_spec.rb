require 'spec_helper'

describe 'hydra/object_viewer/application/show' do
  def content_factory(options = {})
    options.reverse_merge!(
      description: %(<p id="lorem-id">Lorem Ipsum</p>).html_safe,
      title: %(Hello World),
      classification: "Collection"
    )
    double(options)
  end
  def related_content_factory
    double(
      subject: content_factory,
      annotation: content_factory
    )
  end

  let(:primary_content) {
    content_factory(related_contents: related_contents)
  }

  before(:each) do
    view.stub(:presenter).and_return(primary_content)
  end

  describe 'with related contents' do
    let(:related_contents) { [related_content_factory, related_content_factory] }
    it 'renders the show page' do
      render
      rendered.should have_tag('.object-viewer') do
        with_tag('.primary-content') do
          with_tag('.title', text: primary_content.title)
          with_tag('.classification', text: primary_content.classification)
          with_tag('.description p#lorem-id')
        end

        with_tag('.related .related-content', count: related_contents.count)
      end
    end
  end

  describe 'with related contents' do
    let(:related_contents) { [] }
    it 'renders the show page' do
      render
      rendered.should have_tag('.object-viewer') do
        with_tag('.primary-content') do
          with_tag('.title', text: primary_content.title)
          with_tag('.classification', text: primary_content.classification)
          with_tag('.description p#lorem-id')
        end

        without_tag('.related')
      end
    end
  end
end
