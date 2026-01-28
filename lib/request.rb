class Request
  def initialize(env)
    @env = env
  end

  def method
    @env["REQUEST_METHOD"]
  end

  def path
    @env["PATH_INFO"]
  end

  def params
    @params ||= query_params.merge(body_params)
  end

  private

  def query_params
    raw = @env["QUERY_STRING"]
    return {} if raw.nil? || raw.empty?

    URI.decode_www_form(raw).to_h
  end

  def body_params
    return {} unless form_urlencoded?
    return {} if raw_body.empty?

    URI.decode_www_form(raw_body).to_h
  end

  def raw_body
    @raw_body ||= begin
        input = @env["rack.input"]
        input.read.to_s
      end
  end

  def form_urlencoded?
    @env["CONTENT_TYPE"] == "application/x-www-form-urlencoded"
  end
end
