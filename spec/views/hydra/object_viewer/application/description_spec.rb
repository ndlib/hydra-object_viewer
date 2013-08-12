require 'spec_helper'

describe 'hydra/object_viewer/application/_description' do
  let(:the_presenter) {
    double(
      description: %(<p class="hello-world">Hello World</p>),
      dom_id: rand(1000)
    )
  }

  before(:each) do
    view.stub(:presenter).and_return(the_presenter)
  end

  it 'renders the non-HTML Safe description' do
    render
    rendered.should have_tag('.description', with_text: %(&lt;p class=&quot;hello-world&quot;&gt;Hello World&lt;/p&gt;))
  end

end
