class Business < ApplicationRecord
    has_many :philanthropic_initiatives
    has_many :beneficiaries, through: :philanthropic_initiatives

    has_secure_password

    validates_presence_of :name, :sector, :city, :state, :email, :password
    validates_uniqueness_of :name, :email

    accepts_nested_attributes_for :beneficiaries
    accepts_nested_attributes_for :philanthropic_initiatives
    
    
    scope :in_tech, -> { where(sector: "Technology") }
end

