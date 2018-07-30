# frozen_string_literal: true

module Concerns
  # Validates a participant's token on registration
  class TokenValidator
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def valid?
      valid_token
    rescue NoMethodError
      false
    end

    private

    def valid_token
      AccessToken.find_by(token: token).present?
    end
  end
end
