class PhilanthropicInitiativesController < ApplicationController
    before_action :set_philanthropic_initiative, :logged_in

    def index
        @philanthropic_initiatives = PhilanthropicInitiative.all
    end

    def new 
        if !correct_business
        # if current_business.id == params[:philanthropic_initiative][:business_id].to_i
            @philanthropic_initiative = PhilanthropicInitiative.new(business_id: params[:business_id])
        # else
        #     redirect_to root_path
        # end
        end
    end

    def create 
        if !correct_business
         #if current_business.id == params[:philanthropic_initiative][:business_id].to_i
            @philanthropic_initiative = PhilanthropicInitiative.create(philanthropic_initiative_params)
            redirect_to philanthropic_initiatives_path
        # else
        #     redirect_to root_path
        # end
        end
    end

    def show 
    end

    def edit 
        # if current_business.id != params[:philanthropic_initiative][:business_id].to_i
        #     redirect_to root_path
        # end
        correct_business
    end

    def update 
        if !correct_business 
        # if current_business.id == params[:philanthropic_initiative][:business_id].to_i
            @philanthropic_initiative.update(philanthropic_initiative_params)
            redirect_to philanthropic_initiative_path(@philanthropic_initiative)
        # else 
        #     redirect_to root_path
        # end
        end
    end
    
    private
    def philanthropic_initiative_params
        params.require(:philanthropic_initiative).permit(:name, :pledged_amount, :goal, :business_id, beneficiary_attributes: [:recipient, :city, :state])
    end

    def set_philanthropic_initiative
        @philanthropic_initiative = PhilanthropicInitiative.find_by(id: params[:id]) 
    end

    def correct_business
        if current_business.id != params[:business_id].to_i
            redirect_to root_path
        end
    end
end

    
