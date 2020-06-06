class BeneficiariesController < ApplicationController
    def index
        @beneficiaries = Beneficiary.all
        @business = Business.find_by(id: session[:business_id])
    end

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

    def edit 
        @beneficiary = Beneficiary.find_by(id: params[:id])
    end

    def update 
        @beneficiary = Beneficiary.find_by(id: params[:id])
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


end
