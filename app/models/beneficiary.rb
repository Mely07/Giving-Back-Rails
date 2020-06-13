class Beneficiary < ApplicationRecord
    has_many :philanthropic_initiatives
    has_many :businesses, through: :philanthropic_initiatives

    before_save :titleize
    validates_presence_of :recipient, :city, :state
    validates :state, length: { is: 2 }
    
    scope :local, -> { where(state: "NY") } 

    accepts_nested_attributes_for :businesses
    accepts_nested_attributes_for :philanthropic_initiatives
    

    private
    def titleize
        self.state = self.state.upcase 
        self.city = self.city.split.map(&:capitalize).join(' ')
    end
end


