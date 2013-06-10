module Rack
  module Jasmine

    class Runner
      def initialize(config)
        @config = config
      end

      def call(env)
        @path = env["PATH_INFO"]
        current_template = find_template( @path )
        return not_found if current_template.nil?
        [
          200,
          { 'Content-Type' => 'text/html'},
          [::Jasmine::Page.new(@config).render(current_template)]
        ]
      end

      def not_found
        [404, {"Content-Type" => "text/plain",
               "X-Cascade" => "pass"},
               ["File not found: #{@path}\n"]]
      end

      def find_template( path )
        return 'default' if path == '/'
        return $1 if path =~ /^\/page\/(.*)/
      end
    end

  end
end
