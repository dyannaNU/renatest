Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  devise_for :participants,
             controllers: { registrations: 'participants/registrations' }

  resource :home, only: :show
  resources :consents, only: [:new, :create]
  resource :how_to_guide, only: :show
  resources :assessment_cases, only: :show
  resources :assessment_question_responses, only: [] do
    put :update_responses, on: :collection
  end
  resource :feedback_questionnaire, only: :show
  resources :feedback_question_responses, only: :create
  resources :modules, only: [:index, :show] do
    get :download_zip_file, on: :collection
  end
  resource :baseline_report_card, only: :show
  resource :final_report_card, only: :show
  get "final_report_card/attach", to: "final_report_cards#attach"
  resources :story_events, only: :create
  resource :baseline_congratulations, only: :show
  resource :final_congratulations, only: :show
  resource :introduction, only: [:show, :update]
  resource :past_access, only: :show

  authenticated :user do
    root to: "rails_admin/main#dashboard"
    get "report/generate_report", to: "reports#generate_single_participant_report"
    get "report/generate_full_report", to: "reports#generate_full_report"
  end

  root to: "consents#new"

  if Rails.env == "development"
    get "quick_sign_in", to: "quick_sign_ins#new", as: "quick_sign_in"
  end

  resource :version, only: :show

  # catch all for unrecognized routes
  get "(*unknown)", to: redirect("/")
  post "(*unknown)", to: redirect("/")
  match "(*unknown)", to: -> (hash) { [200, {}, [""]] }, via: :options
end
