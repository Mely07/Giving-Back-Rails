class BusinessesController < ApplicationController
    def new 
        @business = Business.new
    end

    def create 
        @business = Business.create(business_params)

    end

    private
    def business_params
        params.require(:business).permit(:name, :sector, :city, :state, :website, :username, :password)
    end
end
