class SessionsController < ApplicationController
    def new 
       @businesses = Business.all
    end

    def create 
        @business = Business.find_by(email: params[:email])  
        if @business.authenticate(params[:password])
            session[:business_id] = @business.id
            redirect_to business_path(@business)
        else
            redirect to '/signin'
        end
    end

    def googleAuth
        @business = Business.find_or_create_by(email: auth['info']['email'])
         if @business.id == nil 
            render 'businesses/edit' 
         else
            session[:business_id] = @business.id
            redirect_to business_path(@business)
         end
    end


      
    private
    def auth
        request.env['omniauth.auth']
    end

end