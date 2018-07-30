# frozen_string_literal: true

module Forms
  # Used to provide more streamline error messages
  class ErrorsHelper < ActionView::Helpers::FormBuilder
    FORM_GROUP_CSS_CLASS = "has-danger"
    FIELD_CSS_CLASS = "form-control-danger"
    FEEDBACK_CSS_CLASS = "form-control-feedback"

    def feedback_error(attribute, css_class = FEEDBACK_CSS_CLASS)
      return unless error_on?(attribute)

      ActionController::Base.helpers.content_tag :div, class: css_class do
        object.errors[attribute].uniq.to_sentence
      end
    end

    def field_error(attribute, css_class = FIELD_CSS_CLASS)
      css_class if error_on?(attribute)
    end

    def group_error(attribute, css_class = FORM_GROUP_CSS_CLASS)
      css_class if error_on?(attribute)
    end

    private

    def error_on?(attribute)
      object.errors && object.errors[attribute].present?
    end
  end
end
