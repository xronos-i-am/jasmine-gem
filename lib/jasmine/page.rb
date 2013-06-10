module Jasmine
  class Page
    def initialize(context)
      @context = context
    end

    def render(template)
      ERB.new(::Jasmine.runner_template(@context, template)).result(@context.instance_eval { binding })
    end
  end
end
