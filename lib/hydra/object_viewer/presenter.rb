class Hydra::ObjectViewer::Presenter
  attr_reader :model, :context, :container_model_context
  def initialize(model, context, container_model_context = nil)
    @model = model
    @context = context
    @container_model_context = container_model_context
  end

  delegate :title, :description, to: :model

  def classification
    model.classification
  rescue NoMethodError
    model.class.name.demodulize
  end

  require 'morphine'
  include Morphine
  register :presenter_builder do
    require 'hydra/object_viewer/presenter_builder'
    lambda {|object, context|
      Hydra::ObjectViewer::PresenterBuilder.new(object, context)
    }
  end

  def self.related_contents(method_name)
    define_method(:related_contents) do
      send(method_name).collect {|object|
        presenter_builder.call(object, context)
      }
    end
  end

  def related_contents
    raise NotImplementedError,
      "Define via Class.related_contents(:method_name)"
  end

  def metadata_attributes
    raise NotImplementedError,
      "Define via Class.metadata_attributes(:method_name)"
  end

end
