class BusinessesController < ApplicationController
    before_action :set_business, :logged_in, only: [:show, :edit, :update]

    def index 
        @businesses= Business.all
        @in_tech = Business.in_tech
    end
    
    def new 
        @business = Business.new
        @business.beneficiaries.build
    end

    def create 
        @business = Business.create(business_params)
        if @business.save
            session[:business_id] = @business.id
            redirect_to business_path(@business)
        else 
            render :new
        end
    end

    def show 
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
        params.require(:business).permit(:name, :sector, :city, :state, :website, :email, :password, beneficiaries_attributes: [:recipient, :city, :state, philanthropic_initiative_attributes: [:name, :pledged_amount, :goal]] )
    end

    def set_business 
        @business = Business.find_by(id: params[:id])
    end
end
