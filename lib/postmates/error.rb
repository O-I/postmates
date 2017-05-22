module Postmates
  class Error       < StandardError; end # custom Postmates error class
  class BadRequest          < Error; end # 400
  class Unauthorized        < Error; end # 401
  class CustomerSuspended   < Error; end # 402
  class Forbidden           < Error; end # 403
  class NotFound            < Error; end # 404
  class InternalServerError < Error; end # 500
  class ServiceUnavailable  < Error; end # 503
end
