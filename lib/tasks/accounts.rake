# frozen_string_literal: true

namespace :accounts do
  desc "Create an admin account for the provided email address e.g. " \
       "rake accounts:create_admin[foo@bar.com]"
  task :create_admin, [:email] => [:environment] do |_t, args|
    password = SecureRandom.uuid
    User.create!(
      email: args[:email],
      password: password,
      password_confirmation: password
    )
  end
end
