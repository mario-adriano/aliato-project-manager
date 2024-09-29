FactoryBot.define do
  factory :client, class: 'Individual' do
    name { "Client Name" }

    address { "123 Main St" }
    city { "City" }
    company_name { "Company Name" }
    complement { "Apt 101" }
    email { "client@example.com" }
    neighborhood { "Downtown" }
    phone { "123456789" }
    state { "State" }
    zip_code { "12345-678" }
    rg { "1234567" }
    document_number { "67915809172" }

    deleted_at { nil }
  end
end
