class BeneficiariesController < ApplicationController
    before_action :set_beneficiary, :logged_in

    def index
        @beneficiaries = Beneficiary.all
        @business = current_business
        locals 
    end

    def show 
        if !@beneficiary
            redirect_to root_path
        end
    end

    def update 
        @beneficiary.update(beneficiary_params)
        if @beneficiary.save 
            redirect_to beneficiary_path(@beneficiary)
        else
            render 'edit'
        end
    end

    private 
    def beneficiary_params
        params.require(:beneficiary).permit(:recipient, :city, :state)
    end

    def set_beneficiary
        @beneficiary = Beneficiary.find_by(id: params[:id])
    end

    def locals
        @locals = Beneficiary.where(state: current_business.state) 
    end
end



