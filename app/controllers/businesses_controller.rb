class BusinessesController < ApplicationController
    before_action :set_business 

    def index 
        @businesses= Business.all
        @in_tech = Business.in_tech
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
        if is_logged_in? #current_business && 
            @business = current_business
        else 
            redirect_to '/'
        end
    end

    def edit 
    end

    def update 
        @business.update(business_params)
        if @business.save 
            redirect_to business_path(@business)
        else
            render 'edit'
        end
    end

    private
    def business_params
        params.require(:business).permit(:name, :sector, :city, :state, :website, :email, :password, philanthropic_initiatives_attributes: [:name, :pledged_amount, :goal, beneficiary_attributes: [:recipient, :city, :state]] )
    end

    def set_business 
        @business = Business.find_by(id: params[:id])
    end
end
