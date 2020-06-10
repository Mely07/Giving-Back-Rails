class BeneficiariesController < ApplicationController
    before_action :set_beneficiary, :logged_in

    def index
        @beneficiaries = Beneficiary.all
        @business = current_business
        @local = Beneficiary.local
    end

    # def new 
    #     @beneficiary = Beneficiary.new
    # end

    # def create 
    #     @beneficiary = Beneficiary.create(beneficiary_params)
    #     if @beneficiary.valid?
    #         redirect_to beneficiary_path(@beneficiary)
    #     else 
    #         render :new
    #     end
    # end

    def show 
    end

   
    # def edit 
    #     if current_business.id != params[:id].to_i
    #         redirect_to root_path
    #     end
    # end

    def update 
            @beneficiary.update(beneficiary_params)
            if @beneficiary.save 
                redirect_to beneficiary_path(@beneficiary)
            else
                render 'edit'
            end
    end
#delete edit & update (test) should only be allowed to edit beneficiary thru initiative! 

    private 
    def beneficiary_params
        params.require(:beneficiary).permit(:recipient, :city, :state)
    end

    def set_beneficiary
        @beneficiary = Beneficiary.find_by(id: params[:id])
    end


end



