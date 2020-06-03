class Business < ApplicationRecord
    has_many :philanthropic_initiatives
    has_many :beneficiaries, through: :philanthropic_initiatives
end
