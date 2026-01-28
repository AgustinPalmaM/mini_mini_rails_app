class Response
  attr_accessor :status, :headers, :body

  NO_CONTENT_STATUSES = [204, 304]

  def initialize
    @status = 200
    @headers = {}
    @body = []
  end

  def write(content)
    ensure_content_type!
    @body << content.to_s
  end

  def to_rack
    finalize_headers!
    [status, headers, body]
  end

  private

  def ensure_content_type!
    return if headers.key?("content-type")
    headers["content-type"] = "text/html; charset=utf-8"
  end

  def finalize_headers!
    if NO_CONTENT_STATUSES.include?(status)
      headers.delete("content-type")
      body.clear
    end
  end
end
