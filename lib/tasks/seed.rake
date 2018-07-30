# frozen_string_literal: true

require "factory_girl"

# rubocop:disable BlockLength
namespace :seed do
  desc "seed the database with development data"
  task data: :environment do
    FactoryGirl.create(:user)

    BaselineFeedbackQuestion.create!(
      description: "Question 1 for the baseline",
      response_options: %w[foo bar baz]
    )
    BaselineFeedbackQuestion.create!(
      description: "Question 2 for the baseline",
      response_options: %w[foo bar baz]
    )
    FinalFeedbackQuestion.create!(
      description: "Question 1 for the final",
      response_options: %w[foo bar baz]
    )
    FinalFeedbackQuestion.create!(
      description: "Question 2 for the final",
      response_options: %w[foo bar baz]
    )
    FactoryGirl.create(:benchmark_score,
                       skill: Skill.find_by(title: "Pressure Inversion Point"),
                       percentage: 80)
    FactoryGirl.create(:benchmark_score,
                       training_status: TrainingStatus.find_by(title: "master"),
                       skill: Skill.find_by(title: "Pressure Inversion Point"),
                       percentage: 95)
    FactoryGirl.create(:benchmark_score,
                       training_status:
                         TrainingStatus.find_by(title: "unsupervised practice"),
                       skill: Skill.find_by(title: "Pressure Inversion Point"),
                       percentage: 90)
    FactoryGirl.create(:benchmark_score,
                       skill: Skill.find_by(title: "Hiatal Hernia"),
                       percentage: 80)
    FactoryGirl.create(:benchmark_score,
                       training_status: TrainingStatus.find_by(title: "master"),
                       skill: Skill.find_by(title: "Hiatal Hernia"),
                       percentage: 95)
    FactoryGirl.create(:benchmark_score,
                       training_status:
                         TrainingStatus.find_by(title: "unsupervised practice"),
                       skill: Skill.find_by(title: "Hiatal Hernia"),
                       percentage: 90)
    AssessmentQuestion.create!(
      [
        {
          position: 1,
          skill: Skill.find_by(title: "Pressure Inversion Point"),
          description: "In the overall study, is a pressure"\
                       " inversion point (PIP) present?"
        },
        {
          position: 2,
          skill: Skill.find_by(title: "Hiatal Hernia"),
          description: "In the overall study, is a hiatal hernia of 3cm or " \
                       "greater present?"
        }
      ]
    )
    AssessmentCase.find_each do |ac|
      AssessmentQuestion.find_each do |aq|
        FactoryGirl.create(:assessment_answer,
                           assessment_case: ac,
                           assessment_question: aq)
        FactoryGirl.create(:assessment_answer,
                           assessment_case: ac,
                           assessment_question: aq,
                           title: "AnotherAnswer",
                           position: "9",
                           is_correct: true)
      end
    end

    Story.create!(
      [
        {
          file_name: "PIP",
          identifier: "6PuBOzflYsU",
          skill: Skill.find_by(title: "Pressure Inversion Point")
        },
        {
          file_name: "EGJ",
          identifier: "632KTa63Lhm",
          skill: Skill.find_by(title: "Hiatal Hernia")
        }
      ]
    )

    create_unstarted_participant
    create_baseline_completed_participant
    create_completed_participant
  end

  def create_unstarted_participant
    FactoryGirl.create(:participant, email: "unstarted_participant@example.com")
  end

  def create_baseline_completed_participant
    baseline_completed_participant = FactoryGirl.create(
      :participant,
      email: "baseline_completed_participant@example.com"
    )
    FactoryGirl.create(:consent, participant: baseline_completed_participant)
    create_baseline_responses_for baseline_completed_participant
  end

  def create_completed_participant
    completed_participant = FactoryGirl.create(
      :participant,
      email: "completed_participant@example.com"
    )
    FactoryGirl.create(:consent, participant: completed_participant)
    create_baseline_responses_for completed_participant
    create_story_events_for completed_participant
    create_final_responses_for completed_participant
  end

  def create_baseline_responses_for(participant)
    BaselineAssessmentCase.find_each do |baseline_case|
      AssessmentQuestion.find_each do |question|
        participant.assessment_question_responses.create!(
          assessment_case: baseline_case,
          assessment_question: question,
          assessment_answer: question.assessment_answers.sample
        )
      end
    end
  end

  def create_final_responses_for(participant)
    FinalAssessmentCase.find_each do |final_case|
      AssessmentQuestion.find_each do |question|
        participant.assessment_question_responses.create!(
          assessment_case: final_case,
          assessment_question: question,
          assessment_answer: question.assessment_answers.sample
        )
      end
    end
  end

  def create_story_events_for(participant)
    Story.find_each do |story|
      participant.story_events.create!(
        completed_at: Time.zone.now,
        story: story
      )
    end
  end
end
# rubocop:enable BlockLength
