FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname { Faker::Name.initials }
    email { Faker::Internet.free_email }
    password { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name { person.first.kanji }
    first_name { person.last.kanji }
    last_name_kana { person.first.katakana }
    first_name_kana { person.last.katakana }
    birth_date { Faker::Date.backward }
  end
end
