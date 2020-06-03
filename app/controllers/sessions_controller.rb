class SessionsController < ApplicationController
    def new 
       @businesses = Business.all
    end

    def create 
        @business = Business.find_by(username: params[:username])
        if @business.authenticate(params[:password])
            session[:business_id] = @business.id
            redirect_to business_path(@business)
        else
            redirect to '/signin'
        end
    end

end