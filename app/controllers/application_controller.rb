require 'rack-flash'

class ApplicationController < ActionController::Base
protect_from_forgery with: :exception
    
    configure do
        use Rack::Flash, :sweep => true
    end

    helper_method :current_business, :is_logged_in?

    def current_business
        current_business = Business.find_by(id: session[:business_id])
    end

    def is_logged_in?
        current_business != nil
    end
end
