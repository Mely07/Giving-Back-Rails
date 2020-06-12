class PhilanthropicInitiative < ApplicationRecord
    belongs_to :business
    belongs_to :beneficiary

    validates_presence_of :name, :goal

    validates :goal, length: {minimum: 15}
    
    accepts_nested_attributes_for :beneficiary
end

