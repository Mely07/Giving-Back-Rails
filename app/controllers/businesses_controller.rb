class BusinessesController < ApplicationController
    before_action :set_business, :logged_in, only: [:index, :show, :edit, :update, :destroy]

    def index 
        @businesses = Business.all
        @in_tech = Business.in_tech
    end

    def new 
        @business = Business.new
        @business.philanthropic_initiatives.build 
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
        @philanthropic_initiatives = @business.philanthropic_initiatives
    end
   
    def edit 
        # if current_business.id != params[:id].to_i
        #     flash[:danger] = "Invalid request!"
        #     redirect_to root_path
        # end
        correct_business
    end

    def update 
        if !correct_business
        #if current_business.id == params[:id].to_i
            @business.update(business_params)
            if @business.save 
                redirect_to business_path(@business)
            else
                render 'edit'
            end
        end

        # else 
        #     redirect_to root_path
        # end
    end

    private
    def business_params
        params.require(:business).permit(:name, :sector, :city, :state, :website, :email, :password, philanthropic_initiatives_attributes: [:name, :pledged_amount, :goal, beneficiary_attributes: [:recipient, :city, :state]] )
    end

    def set_business 
        @business = Business.find_by(id: params[:id])
    end

    def correct_business
        if current_business.id != params[:id].to_i
            flash[:danger] = "Unauthorized access!"
            redirect_to root_path
        end
    end
end

