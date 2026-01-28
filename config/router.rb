require_relative "../lib/request"

class Router
  HTTP_VERBS = %w[GET POST PUT PATCH DELETE OPTIONS HEAD]

  def initialize
    @routes = []
  end

  HTTP_VERBS.each do |verb|
    define_method(verb.downcase) do |path, to:|
      add_route(verb, path, to)
    end
  end

  def call(env)
    request = Request.new(env)

    route = find_route(request.method, request.path)

    return not_found unless route

    dispatch(route, request)
  end

  private

  def add_route(verb, path, to)
    controller, action = to.split("#")

    @routes << {
      verb: verb,
      path: path,
      controller: controller,
      action: action,
    }
  end

  def find_route(verb, path)
    @routes.find do |route|
      route[:verb] == verb && route[:path] == path
    end
  end

  def dispatch(route, request)
    controller_class = Object.const_get("#{camelize(route[:controller])}Controller")

    controller = controller_class.new(request)
    controller.public_send(route[:action])

    controller.response.to_rack
  end

  def not_found
    [404, { "content-type" => "text/plain; charset=utf-8" }, ["Not Found\n"]]
  end

  def camelize(str)
    str.split("_").map(&:capitalize).join
  end
end
