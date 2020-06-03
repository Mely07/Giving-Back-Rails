class Beneficiary < ApplicationRecord
    has_many :philanthropic_initiatives
    has_many :businesses, through: :philanthropic_initiatives
end
