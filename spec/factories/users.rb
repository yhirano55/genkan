FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }

    trait(:accepted) do
      accepted_at { Time.current }
    end

    trait(:not_accepted) do
      accepted_at nil
    end

    trait(:banned) do
      banned_at { Time.current }
    end

    trait(:not_banned) do
      banned_at nil
    end

    trait(:active) do
      accepted_at { Time.current }
      banned_at nil
    end
  end
end
