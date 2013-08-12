require 'spec_helper'

describe 'hydra/object_viewer/application/_description' do
  let(:the_presenter) { double }

  before(:each) do
    view.stub(:presenter).and_return(the_presenter)
  end

  it 'renders the non-HTML Safe description' do
    the_presenter.should_receive(:description).and_return(%(<p class="hello-world">Hello World</p>))
    render
    rendered.should have_tag('.description', with_text: %(&lt;p class=&quot;hello-world&quot;&gt;Hello World&lt;/p&gt;))
  end

  it 'renders html for a description that is marked html_safe' do
    the_presenter.should_receive(:description).and_return(%(<p class="hello-world">Hello World</p>).html_safe)
    render
    rendered.should have_tag('.description') do
      with_tag("p.hello-world", text: "Hello World")
    end
  end

end
