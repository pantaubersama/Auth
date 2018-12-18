module API
  module V1
    module ExceptionHandlers
      def self.included(base)
        base.instance_eval do
          rescue_from :all do |e|
            # When required params are missing or validation fails
            if e.class.name == 'Grape::Exceptions::ValidationErrors'
              code    = 406
              message = e.message
              # Bad token
            elsif (e.class.name == 'RuntimeError' && e.message == 'Invalid base64 string')
              code    = 401
              message = '401 Unauthorized'
              # Record not found
            elsif e.is_a?(ActiveRecord::RecordNotFound)
              code    = 404
              model   = e.model.constantize.model_name.human(locale: :id).downcase
              message = I18n.t(:'activerecord.errors.messages.record_not_found', model: model, locale: :id)
            elsif e.is_a?(ActiveRecord::RecordInvalid) || e.is_a?(ActiveRecord::RecordNotDestroyed)
              code    = 422
              message = e.message
            else
              code    = 500
              message = e.message
            end

            Rails.logger.error Rails.backtrace_cleaner.clean(e.backtrace).join("\n") if ENV['API_DEBUGGING'] == 'true'

            results = {
              error: {
                code:   code,
                errors: [message]
              }
            }
            Rack::Response.new(results.to_json, code, {"content-type" => "application/json; charset=UTF-8"}).finish
          end
        end
      end
    end
  end
end
