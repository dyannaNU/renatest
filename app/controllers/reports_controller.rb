# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize

# Aggregates exportable data about participants
class ReportsController < ActionController::Base
  def generate_single_participant_report
    @participant = Participant.find(participant_id)
    retrieve_content

    respond_to do |format|
      format.html do
        send_data single_participant_report,
                  filename: "participant-report-#{participant_id}.csv"
      end
    end
  end

  def generate_full_report
    respond_to do |format|
      format.html do
        send_data full_report,
                  filename: "full-participant-report.csv"
      end
    end
  end

  private

  def full_report
    CSV.generate(headers: true) do |csv|
      csv << construct_attributes_header
      Participant.all.each do |participant|
        @participant = participant
        retrieve_content
        csv << @data
      end
    end
  end

  def single_participant_report
    CSV.generate(headers: true) do |csv|
      csv << construct_attributes_header
      csv << @data
    end
  end

  def construct_attributes_header
    attributes = %w[Name PID User_Type Institution]
    (1..number_of_baseline_cases).each do |i|
      (1..number_of_questions).each do |j|
        attributes << "Baseline" + i.to_s + "." + j.to_s + " "
      end
    end
    Skill.all.each do |skill|
      attributes << "Baseline " + skill.title + " %"
      attributes << skill.title + " passed?"
    end
    (1..number_of_final_cases).each do |i|
      (1..number_of_questions).each do |j|
        attributes << "Final" + i.to_s + "." + j.to_s + " "
      end
    end
    Skill.all.each do |skill|
      attributes << "Final " + skill.title + " %"
      attributes << skill.title + " passed?"
    end
    Story.all.each do |story|
      attributes << "Module " + story.skill.title + " completed?"
    end
    Story.all.each do |story|
      attributes << "Time " + story.skill.title + " module completed"
    end
    attributes << "Total time"
    attributes
  end

  def total_time
    start_time = Time.zone.now
    @participant.page_view_events.each do |event|
      next unless event.is_a?(BaselineAssessmentCaseViewEvent)
      start_time = event.created_at if event.created_at < start_time
    end
    end_time = start_time
    @participant.page_view_events.each do |event|
      if event.is_a?(FinalAssessmentCaseViewEvent) &&
         (event.created_at > end_time)
        end_time = event.created_at
      end
    end
    time = end_time - start_time
    @data << Time.at(time).utc.strftime("%H:%M:%S")
  end

  def module_timestamps
    Story.all.each do |story|
      @data << if @participant.story_events.exists?(story_id: story.id)
                 @participant.story_events.find_by(story_id: story.id)
                             .completed_at
               else
                 "-"
               end
    end
  end

  def module_completion
    Story.all.each do |story|
      @data << if @participant.story_events.exists?(story_id: story.id)
                 "Y"
               else
                 "N"
               end
    end
  end

  def number_of_baseline_cases
    BaselineAssessmentCase.all.count
  end

  def number_of_final_cases
    FinalAssessmentCase.all.count
  end

  def number_of_questions
    AssessmentQuestion.all.count
  end

  def final_performance
    report_card = ReportCard.new(
      participant: @participant,
      assessment_cases: FinalAssessmentCase.all
    )
    Skill.all.each do |skill|
      question = AssessmentQuestion.find_by(skill: skill)
      percent_correct = report_card.percent_correct(question)
      @data << percent_correct.to_s + "%"
      benchmark = BenchmarkScore.find_by(
        training_status: @participant.training_status,
        skill: skill
      )
      @data << if benchmark.nil?
                 "-"
               elsif percent_correct >= benchmark.percentage
                 "Y"
               else
                 "N"
               end
    end
  end

  def final_scores
    FinalAssessmentCase.all.each do |assessment_case|
      AssessmentQuestion.all.each do |question|
        responses = @participant.assessment_question_responses.where(
          assessment_question: question,
          assessment_case: assessment_case
        )
        @data << "N/A" if responses.empty?
        responses.each do |response|
          @data << if response.assessment_answer.nil? ||
                      !response.assessment_answer.is_correct
                     "N"
                   else
                     "Y"
                   end
        end
      end
    end
  end

  def baseline_performance
    report_card = ReportCard.new(
      participant: @participant,
      assessment_cases: BaselineAssessmentCase.all
    )
    Skill.all.each do |skill|
      question = AssessmentQuestion.find_by(skill: skill)
      percent_correct = report_card.percent_correct(question)
      @data << percent_correct.to_s + "%"
      benchmark = BenchmarkScore.find_by(
        training_status: @participant.training_status,
        skill: skill
      )
      @data << if benchmark.nil?
                 "-"
               elsif percent_correct >= benchmark.percentage
                 "Y"
               else
                 "N"
               end
    end
  end

  def baseline_scores
    BaselineAssessmentCase.all.each do |assessment_case|
      AssessmentQuestion.all.each do |question|
        responses = @participant.assessment_question_responses.where(
          assessment_question: question,
          assessment_case: assessment_case
        )
        @data << "N/A" if responses.empty?
        responses.each do |response|
          @data << if response.assessment_answer.nil? ||
                      !response.assessment_answer.is_correct
                     "N"
                   else
                     "Y"
                   end
        end
      end
    end
  end

  def participant_info
    @data = ["#{@participant.first_name} #{@participant.last_name}",
             participant_id,
             @participant.training_status.title,
             @participant.affiliation]
  end

  def participant_id
    params[:participant_id]
  end

  def retrieve_content
    participant_info
    baseline_scores
    baseline_performance
    final_scores
    final_performance
    module_completion
    module_timestamps
    total_time
  end
end
# rubocop:enable Metrics/ClassLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
