class BeneficiariesController < ApplicationController

    def new
        @beneficiary = Beneficiary.new
    end

    def create 
        @beneficiary = Beneficiary.create(beneficiary_params)
        redirect_to beneficiary_path(@beneficiary)
    end

    def show 
        @beneficiary = Beneficiary.find_by(id: params[:id])
    end


    private 
    def beneficiary_params
        params.require(:beneficiary).permit(:recipient, :city, :state)
    end


end
