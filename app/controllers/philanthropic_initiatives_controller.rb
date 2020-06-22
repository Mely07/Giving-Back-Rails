class PhilanthropicInitiativesController < ApplicationController
    before_action :set_philanthropic_initiative, :logged_in
    before_action :correct_business, only: [:new, :edit]
    before_action :correct_business_post, only: [:create, :update]

    def index
        if params[:business_id] 
            if Business.find_by(id: params[:business_id])
                @philanthropic_initiatives = Business.find(params[:business_id]).philanthropic_initiatives
            else
              flash[:alert] = "Business not found."
              redirect_to businesses_path
            end
        else
            @philanthropic_initiatives = PhilanthropicInitiative.all
        end
    end

    def new 
        @philanthropic_initiative = PhilanthropicInitiative.new(business_id: params[:business_id])
        @philanthropic_initiative.build_beneficiary
        # def new
        #     if params[:business_id] && !Business.exists?(params[:business_id])
        #       redirect_to businesses_path, alert: "Business not found."
        #     else
        #       @philanthropic_initiative = PhilanthropicInitiative.new(business_id: params[:business_id])
        #     end
        # end   
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
        if !@philanthropic_initiative
            redirect_to philanthropic_initiatives_path, alert: "Initiative not found"
        else 
            @business = @philanthropic_initiative.business
        end
        # if params[:business_id]
        #     @business = Business.find_by(id: params[:business_id])
        #     philanthropic_initiative = @business.philanthropic_initiatives.find_by(id: params[:id])
        #     if @philanthropic_initiative.nil?
        #         redirect_to business_philanthropic_initiatives_path(@business), alert: "Initiative not found"
        #     end
        # end
    end

    def edit 
        if params[:business_id]
            @business = Business.find_by(id: params[:business_id])
            philanthropic_initiative = @business.philanthropic_initiatives.find_by(id: params[:id])
            if @philanthropic_initiative.nil?
                redirect_to business_philanthropic_initiatives_path(@business), alert: "Initiative not found"
            elsif !philanthropic_initiative
                flash[:danger] = "Unauthorized request!"
                redirect_to  business_path(@business)
            end
        end
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

    
