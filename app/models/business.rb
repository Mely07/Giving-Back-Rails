class Business < ApplicationRecord
    has_many :philanthropic_initiatives
    has_many :beneficiaries, through: :philanthropic_initiatives

    has_secure_password

    before_save :titleize
    validate  :website_format
    validates_presence_of :name, :sector, :city, :email, :password
    validates_uniqueness_of :name, :email
    validates :state, length: { is: 2 }
    validates :password, length: { in: 6..10 }
    
    accepts_nested_attributes_for :beneficiaries
    accepts_nested_attributes_for :philanthropic_initiatives
    
    
    scope :in_tech, -> { where(sector: "Technology") }

    private
    def website_format
        unless website && website.match(
            /^((?!-))(xn--)?[a-z0-9][a-z0-9-_]{0,61}[a-z0-9]{0,1}\.(xn--)?([a-z0-9\-]{1,61}|[a-z0-9-]{1,30}\.[a-z]{2,})$/)
            errors.add(:website, "must be in a valid format, for example: 123.abc")
        end
    end

    def titleize
        self.state = self.state.upcase 
        self.name = self.name.split.map(&:capitalize).join(' ')
        self.city = self.city.split.map(&:capitalize).join(' ')
    end

end


