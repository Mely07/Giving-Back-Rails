class BusinessesController < ApplicationController
    def new 
        @business = Business.new
    end

    def create 
        @business = Business.create(business_params)
        session[:business_id] = @business.id
        redirect_to business_path(@business)
    end

    def show 
        if Business.find_by(id: session[:business_id]) && session[:business_id] #
            @business = Business.find_by(id: session[:business_id]) 
        else 
            redirect_to '/'
        end
    end

    private
    def business_params
        params.require(:business).permit(:name, :sector, :city, :state, :website, :email, :password)
    end
end
