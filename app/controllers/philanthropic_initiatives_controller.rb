class PhilanthropicInitiativesController < ApplicationController
    def create 
        @business = Business.find_by(id: session[:business_id])
        @beneficiary = Beneficiary.find_by(id: params[:beneficiary_id])
        
        @philanthropic_initiative = PhilanthropicInitiative.new(business: @business, beneficiary: @beneficiary)
    end
end
