class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_validation_failed

    private

    def render_not_found(exception)
        render json: { error: exception.message }, status: :not_found
    end

    def render_invalid(exception)
        render json: exception.record.errors, status: :unprocessable_entity
    end

    def render_validation_failed(exception)
        render json: { error: exception.message }, status: :validation_failed
    end
end

