# frozen_string_literal: true

module Pages
  module Users
    class EditTokenAccess < Page
      def goto(id)
        visit "/admin/access_token/#{id}/edit"

        self
      end

      def update_text(text)
        fill_in "Token", with: text

        self
      end

      def click_save
        click_on "Save"

        self
      end
    end
  end
end
