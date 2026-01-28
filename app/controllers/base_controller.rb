require_relative "../../lib/response"
require_relative "../../lib/view_renderer"

class BaseController
  def initialize(request)
    @request = request
    @response = Response.new
  end

  def response
    @response
  end

  def params
    @request.params
  end

  def render(template, assigns = {})
    html = ViewRenderer.new(template, assigns.merge(params: params)).render
    response.write(html)
  end
end
