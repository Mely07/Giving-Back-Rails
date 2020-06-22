class Beneficiary < ApplicationRecord
    has_many :philanthropic_initiatives
    has_many :businesses, through: :philanthropic_initiatives

    before_save :titleize
    validates_presence_of :recipient, :city, :state
    validates :state, length: { is: 2 }
    
    private
    def titleize
        self.state = self.state.upcase 
        self.city = self.city.split.map(&:capitalize).join(' ')
    end

end


