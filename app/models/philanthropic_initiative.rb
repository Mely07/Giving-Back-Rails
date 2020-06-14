class PhilanthropicInitiative < ApplicationRecord
    belongs_to :business
    belongs_to :beneficiary

    before_save :titleize
    validates_presence_of :name, :goal 
    validates :pledged_amount, numericality: { only_integer: true }

    validates :goal, length: {minimum: 15}
    
    accepts_nested_attributes_for :beneficiary, :allow_destroy => true

    private 
    def titleize
        self.goal[0] = self.goal[0].capitalize
        self.name = self.name.split.map(&:capitalize).join(' ')
    end
end

