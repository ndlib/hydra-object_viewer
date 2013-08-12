class Hydra::ObjectViewer::Presenter
  attr_reader :model, :context, :container_model_context
  private :model, :context, :container_model_context
  def initialize(model, context, container_model_context = nil)
    @model = model
    @context = context
    @container_model_context = container_model_context
  end

  delegate :title, :description, to: :model

  require 'morphine'
  include Morphine
  register :presenter_builder do
    require 'hydra/object_viewer/presenter_builder'
    lambda {|object, context|
      Hydra::ObjectViewer::PresenterBuilder.call(object, context)
    }
  end

  def self.presents(presented_method, method_name = nil, &collector)
    define_method(presented_method) do
      # Moved this internally as I want to be able to declare presents before
      # the method is declared
      function = method_name ? method(method_name) : collector
      instance_exec(&function).collect {|object|
        presenter_builder.call(object, context)
      }
    end
  end

  def render_primary_content(template)
    template.render(partial: primary_content_template_name, locals: {presenter: self})
  end

  def render_related_content(template)
    return '' unless related_contents.present?
    template.render(
      partial: related_content_template_name,
      locals: {presenter: self, related_contents: related_contents}
    )
  rescue NotImplementedError => e
    ""
  end

  def dom_id
    context.dom_id(model)
  end

  def classification
    model.classification
  rescue NoMethodError
    model.class.name.demodulize
  end

  def related_contents
    raise NotImplementedError,
      "Define via Class.presents(:related_contents, &block)"
  end

  def metadata_attributes
    raise NotImplementedError,
      "Define via Class.presents(:metadata_attributes, &block)"
  end

  private

  def primary_content_template_name
    'primary_content'
  end
  def related_content_template_name
    'related_content'
  end
end
