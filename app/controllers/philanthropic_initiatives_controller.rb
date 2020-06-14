class PhilanthropicInitiativesController < ApplicationController
    before_action :set_philanthropic_initiative, :logged_in
    before_action :correct_business, only: [:new, :edit]
    before_action :correct_business_post, only: [:create, :update]

    def index
        @philanthropic_initiatives = PhilanthropicInitiative.all
    end

    def new 
        @philanthropic_initiative = PhilanthropicInitiative.new(business_id: params[:business_id])
        @philanthropic_initiative.build_beneficiary
    end

    def create
        @philanthropic_initiative = PhilanthropicInitiative.create(philanthropic_initiative_params)
        if @philanthropic_initiative.save
            redirect_to philanthropic_initiative_path(@philanthropic_initiative)
        else 
            render 'new'
        end
    end

    def show 
        @business = @philanthropic_initiative.business
    end

    def edit 
    end

    def update 
        @philanthropic_initiative.update(philanthropic_initiative_params)
        if @philanthropic_initiative.save
            redirect_to philanthropic_initiative_path(@philanthropic_initiative)
        else 
            render 'edit'
        end
    end

    def destroy
        if current_business.id == @philanthropic_initiative.business_id
            @beneficiary = @philanthropic_initiative.beneficiary 
            @philanthropic_initiative.delete
            @beneficiary.delete
            redirect_to business_path(current_business)
        else
            flash[:danger] = "Unauthorized access!"
            redirect_to business_path(current_business)
        end
    end
    
    private
    def philanthropic_initiative_params
        params.require(:philanthropic_initiative).permit(:name, :pledged_amount, :goal, :business_id, beneficiary_attributes: [:id, :recipient, :city, :state])
    end

    def set_philanthropic_initiative
        @philanthropic_initiative = PhilanthropicInitiative.find_by(id: params[:id]) 
    end

    def correct_business
        if current_business.id != params[:business_id].to_i
            flash[:danger] = "Unauthorized access!"
            redirect_to business_path(current_business)
        end
    end

    def correct_business_post
        if current_business.id != params[:philanthropic_initiative][:business_id].to_i
            flash[:danger] = "Unauthorized request!"
            redirect_to business_path(current_business)
        end
    end
end

    
