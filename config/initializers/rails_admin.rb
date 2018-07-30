RailsAdmin.config do |config|

  config.main_app_name = ["EMC2", "Admin"]

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.label_methods << :description

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except [Participant.to_s, Consent.to_s, HowToViewEvent.to_s,
              PageViewEvent.to_s, AssessmentQuestionResponse.to_s,
              FeedbackQuestionResponse.to_s, SentNotification.to_s]
    end
    export
    bulk_delete do
      except [Consent.to_s, HowToViewEvent.to_s, PageViewEvent.to_s,
              AssessmentQuestionResponse.to_s, FeedbackQuestionResponse.to_s,
              SentNotification.to_s]
    end
    show
    edit do
      except [Participant.to_s, Consent.to_s, HowToViewEvent.to_s,
              PageViewEvent.to_s, AssessmentQuestionResponse.to_s,
              FeedbackQuestionResponse.to_s,
              SentNotification.to_s]
    end
    delete do
      except [Consent.to_s, HowToViewEvent.to_s, PageViewEvent.to_s,
              AssessmentQuestionResponse.to_s, FeedbackQuestionResponse.to_s,
              SentNotification.to_s]
    end
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model AccessToken do
    edit do
      field :token do
        partial "access_tokens/edit"
      end
    end
  end

  config.model AssessmentAnswer do
    edit do
      field :assessment_question
      field :position
      field :title
      field :is_correct
      field :assessment_case
    end
  end

  config.model AssessmentCase do
    edit do
      field :position
      field :description
    end
  end

  config.model AssessmentQuestion do
    edit do
      field :position
      field :skill
      field :description
    end
  end

  config.model BaselineAssessmentCase do
    edit do
      field :position
      field :description
    end
  end

  config.model BaselineFeedbackQuestion do
    list do
      field :description
      field :response_options
    end

    edit do
      field :description
      field :response_options
    end
  end

  config.model FeedbackQuestion do
    list do
      field :description
      field :response_options
    end

    edit do
      field :description
      field :response_options
    end
  end

  config.model FinalAssessmentCase do
    edit do
      field :position
      field :description
    end
  end

  config.model FinalFeedbackQuestion do
    list do
      field :description
      field :response_options
    end

    edit do
      field :description
      field :response_options
    end
  end

  config.model ModuleFile do
    list do
      field :title
      field :description
      field :created_at
      field :updated_at
    end

    show do
      field :title
      field :description
      field :created_at
      field :updated_at
    end
  end

  config.model Participant do
    list do
      field :email
      field :first_name
      field :last_name
      field :affiliation
      field :training_status
      field :participant_data_export do
        pretty_value do
          bindings[:view].link_to "Generate Full Report", bindings[:view].main_app.report_generate_full_report_path
        end
      end
    end

    show do
      field :participant_data_export do
        formatted_value do
          bindings[:view].link_to "Generate Individual Report", bindings[:view].main_app.report_generate_report_path(participant_id: bindings[:object].id)
        end
      end
      field :email
      field :first_name
      field :last_name
      field :affiliation
      field :training_status
    end
  end

  config.model Skill do
    edit do
      field :title
    end
  end

  config.model Story do
    edit do
      field :file_name
      field :identifier
      field :skill
    end
  end

  config.model User do
    list do
      field :email
      field :sign_in_count
      field :last_sign_in_at
    end

    edit do
      field :email do
        required true
      end
    end
  end

end
