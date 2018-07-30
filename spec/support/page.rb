# frozen_string_literal: true

# Creates page object that removes different levels of abstraction
class Page
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  def goto
    visit url

    self
  end

  def loaded?
    current_path == url
  end
end
