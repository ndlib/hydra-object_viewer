module Hydra::ObjectViewer
  class ValuePresenter
    attr_reader :attribute, :context
    private :attribute, :context
    def initialize(attribute, context)
      @attribute = attribute
      @context = context
    end

    def render(template)
      template.render( partial: template_name, locals: {presenter: self})
    end

    def dom_class
      self.name.underscore.dasherize
    end

    def name
      self.class.name.demodulize.sub(/ValuePresenter\Z/,'')
    end

    def value
      attribute
    end

    protected
    def template_name
      'attribute'
    end
  end
end
