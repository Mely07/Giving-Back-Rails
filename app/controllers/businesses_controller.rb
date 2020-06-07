class BusinessesController < ApplicationController
    def index 
        @businesses= Business.all
    end
    
    def new 
        @business = Business.new
        @business.philanthropic_initiatives.build
    end

    def create 
        @business = Business.create(business_params)
        if @business.valid?
            session[:business_id] = @business.id
            redirect_to business_path(@business)
        else 
            render :new
        end
    end

    def show 
        if Business.find_by(id: session[:business_id]) && session[:business_id] 
            @business = Business.find_by(id: session[:business_id]) 
        else 
            redirect_to '/'
        end
    end

    private
    def business_params
        params.require(:business).permit(:name, :sector, :city, :state, :website, :email, :password, philanthropic_initiatives_attributes: [:name, :pledged_amount, :goal, beneficiary_attributes: [:recipient, :city, :state]] )
    end
end
