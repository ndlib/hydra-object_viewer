class Hydra::ObjectViewer::Presenter
  attr_reader :model, :context
  def initialize(model, context)
    @model, @context = model, context
  end

  delegate :title, :description, to: :model
  def classification
    model.classification
  rescue NoMethodError
    model.class.name.demodulize
  end

  def related_contents
    raise NotImplementedError,
      "Method #related_contents should be overriden in child classes"
  end

  def metadata_attributes
    raise NotImplementedError,
      "Method #metadata_attributes should be overriden in child classes"
  end

end
