class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  concerning :CommonExceptionHandling do
    class Forbidden < ActionController::ActionControllerError; end
    class Locked < ActionController::ActionControllerError; end
    class InvalidParameter < ActionController::ActionControllerError; end
    class ServiceUnavailable < ActionController::ActionControllerError; end

    included do
      rescue_from Exception,                      with: :render_500
      rescue_from InvalidParameter,               with: :render_400
      rescue_from ActiveRecord::RecordNotFound,   with: :render_404
      rescue_from ActionController::RoutingError, with: :render_404
      rescue_from ActionView::MissingTemplate,    with: :render_404
    end

    def render_500(e = nil)
      if e
        logger.error "Rendering 500 with exception: #{e.message}"
        logger.error "#{e.backtrace[0]}" if e.backtrace.present? and e.backtrace.length > 0
      end
      render template: 'errors/error_500', status: 500, content_type: 'text/html'
    end

    def render_400(e = nil)
      if e
        logger.error "Rendering 400 with exception: #{e.message}"
        logger.error "#{e.backtrace[0]}" if e.backtrace.present? and e.backtrace.length > 0
      end
      render template: 'errors/error_400', status: 400, content_type: 'text/html'
    end

    def render_404(e = nil)
      if e
        logger.error "Rendering 404 with exception: #{e.message}"
        logger.error "#{e.backtrace[0]}" if e.backtrace.present? and e.backtrace.length > 0
      end
      render template: 'errors/error_404', status: 404, content_type: 'text/html'
    end
  end
end
