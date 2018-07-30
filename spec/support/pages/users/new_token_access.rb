# frozen_string_literal: true

module Pages
  module Users
    class NewTokenAccess < Page
      def click_save
        click_on "Save"

        self
      end

      def url
        "/admin/access_token/new"
      end
    end
  end
end
