module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_attibute
    rescue_from ActiveRecord::RecordNotFound, with: :register_not_found
  end

  private

  def invalid_attibute(error)
    render json: { errors: error }, status: :unprocessable_entity
  end

  def register_not_found(error)
    render json: { errors: error }, status: :not_found
  end

end
