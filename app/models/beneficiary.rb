class Beneficiary < ApplicationRecord
    has_many :philanthropic_initiatives
    has_many :businesses, through: :philanthropic_initiatives

    validates_presence_of :recipient, :city, :state

    scope :local, -> { where(state: "NY") } 

    accepts_nested_attributes_for :businesses
    accepts_nested_attributes_for :philanthropic_initiatives
end


