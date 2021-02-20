class ApplicationController < ActionController::Base
  include AuthControl

  def render_401(error_message = nil)
    logger.info "Rendering 401 with exception: #{error_message}" if error_message

    if request.xhr?
      render json: { error: '401 error', message: error_message }, status: :unauthorized
    else
      format = params[:format] == :json ? :json : :html
      render template: 'errors/error_401', formats: format,
             status: :unauthorized, layout: 'application', content_type: 'text/html'
    end
  end

  def render_404(error_message = nil)
    logger.info "Rendering 404 with exception: #{error_message}" if error_message

    if request.xhr?
      render json: { error: '404 error' }, status: :not_found
    else
      format = params[:format] == :json ? :json : :html
      render template: 'errors/error_404', formats: format,
             status: :not_found, layout: 'application', content_type: 'text/html'
    end
  end

  def render_500(error_message = nil)
    logger.info "Rendering 500 with exception: #{error_message}" if error_message

    if request.xhr?
      render json: { error: '500 error' }, status: :internal_server_error
    else
      format = params[:format] == :json ? :json : :html
      render template: 'errors/error_500', formats: format, status: :internal_server_error,
             layout: 'application', content_type: 'text/html'
    end
  end
end
