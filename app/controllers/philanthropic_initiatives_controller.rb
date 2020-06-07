class PhilanthropicInitiativesController < ApplicationController
    def new 
        @philanthropic_initiative = PhilanthropicInitiative.new
    end
    
    def create 
        @philanthropic_initiative = PhilanthropicInitiative.create(philanthropic_initiative_params)

        redirect_to @philanthropic_initiative.business #philanthropic_initiative_path(@philanthropic_initiative)
    end

    private
    def philanthropic_initiative_params
      params.require(:philanthropic_initiative).permit(:name, :pledged_amount, :goal, :business_id, :philanthropic_initiative_id, beneficiary_attributes: [:recipient, :city, :state])
    end
end

