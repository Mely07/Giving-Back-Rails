class PhilanthropicInitiative < ApplicationRecord
    belongs_to :business
    belongs_to :beneficiary

    validates_presence_of :name, :goal
end
