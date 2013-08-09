class Hydra::ObjectViewer::Presenter
  attr_reader :model, :context, :container_model_context
  private :model, :context, :container_model_context
  def initialize(model, context, container_model_context = nil)
    @model = model
    @context = context
    @container_model_context = container_model_context
    @partial_template_name = "show"
  end

  attr_reader :partial_template_name
  private :partial_template_name

  delegate :title, :description, to: :model

  require 'morphine'
  include Morphine
  register :presenter_builder do
    require 'hydra/object_viewer/presenter_builder'
    lambda {|object, context|
      Hydra::ObjectViewer::PresenterBuilder.new(object, context)
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

  def render(template)
    template.render(partial: partial_template_name, locals: {presenter: self})
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
      "Define via Class.presents(:related_contents, &block)"
  end

end
