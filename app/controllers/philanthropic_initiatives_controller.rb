class PhilanthropicInitiativesController < ApplicationController
    def index
        @philanthropic_initiatives= PhilanthropicInitiative.all
    end
        
    def new 
        @philanthropic_initiative = PhilanthropicInitiative.new(business_id: params[:business_id])
    end
    
    def create 
        @philanthropic_initiative = PhilanthropicInitiative.create(philanthropic_initiative_params)
        redirect_to philanthropic_initiatives_path
    end

    private
    def philanthropic_initiative_params
      params.require(:philanthropic_initiative).permit(:name, :pledged_amount, :goal, :business_id, beneficiary_attributes: [:recipient, :city, :state])
    end
end


