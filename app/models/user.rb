# frozen_string_literal: true

# Person with access to the dashboard.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :lockable, :confirmable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :set_password, on: :create

  private

  def set_password
    random_string = SecureRandom.hex(64)
    self.password = random_string
    self.password_confirmation = random_string
  end
end
