module RubyRainmaker
  # Custom error class for rescuing from all Rainmaker errors
  class Error < StandardError
    attr_reader :http_headers

    def initialize(message, http_headers)
      @http_headers = Hash[http_headers]
      super message
    end

    def retry_after
      [(ratelimit_reset - Time.now).ceil, 0].max
    end
  end

  # Raised when Rainmaker returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Rainmaker returns the HTTP status code 401
  class Unauthorized < Error; end

  # Raised when Rainmaker returns the HTTP status code 403
  class Forbidden < Error; end

  # Raised when Rainmaker returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Rainmaker returns the HTTP status code 422
  class Invalid < Error; end

  # Raised when Rainmaker returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when Rainmaker returns the HTTP status code 502
  class BadGateway < Error; end

  # Raised when Rainmaker returns the HTTP status code 503
  class ServiceUnavailable < Error; end
end
