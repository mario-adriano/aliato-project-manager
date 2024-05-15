class Company < Client
  validates :company_name, presence: true
end
