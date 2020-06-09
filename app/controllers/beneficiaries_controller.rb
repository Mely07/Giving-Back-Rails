class BeneficiariesController < ApplicationController
    before_action :set_beneficiary, :logged_in

    def index
        if params[:business_id]
            @business= Business.find_by(id: params[:business_id])
            if !@business
                redirect_to businesses_path
            else
                @beneficiaries = @business.beneficiaries
            end
        else
            @beneficiaries = Beneficiary.all
        end
        @local = Beneficiary.local
    end


    def new 
        if params[:business_id] && !Business.exists?(params[:business_id])
            redirect_to 'businesses_path'
        else
            @beneficiary = Beneficiary.new
            @beneficiary.businesses << current_business
        end
    end
    
    def create 
        @beneficiary = Beneficiary.create(beneficiary_params)
        if @beneficiary.save
            redirect_to beneficiaries_path
        else 
            render :new
        end
    end

    def show 
    end

    def edit 
        if params[:business_id] && !Business.exists?(params[:business_id])
            redirect_to businesses_path
        else
            @business = current_business
            @beneficiary = @business.beneficiaries.find_by(id: params[:id])
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
        params.require(:beneficiary).permit(:recipient, :city, :state, philanthropic_initiative_attributes: [:name, :pledged_amount, :goal])
    end

    def set_beneficiary
        @beneficiary = Beneficiary.find_by(id: params[:id])
    end
end

