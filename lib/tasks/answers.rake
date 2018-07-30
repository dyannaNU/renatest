# frozen_string_literal: true

# rubocop:disable BlockLength
namespace :answers do
  desc "seed the database with correct baseline answers"
  task seed_baseline_correct: :environment do
    questions = [
      "Pressure Inversion Point",
      "Hiatal Hernia",
      "Integrated Relaxation Pressure",
      "Distal Contractile Integral",
      "Distal Latency",
      "Peristaltic Integrity",
      "Pressurization Pattern",
      "Esophageal Motility Diagnosis"
    ].map { |skill| AssessmentQuestion.find_by(skill: skill) }
    {
      "1": [
        "Yes",
        "No",
        "Yes",
        "> 8000 mmHg·s·cm",
        "> 4.5 seconds",
        "Normal",
        "No pressurization",
        "Hypercontractile esophagus"
      ],
      "2": [
        "Yes",
        "No",
        "Yes",
        "< 450 mmHg·s·cm",
        "Unable to determine",
        "Unable to determine",
        "No pressurization",
        "Type I achalasia"
      ],
      "3": [
        "Yes",
        "No",
        "No",
        "< 450 mmHg·s·cm",
        "Unable to determine",
        "Unable to determine",
        "No pressurization",
        "Absent contractility"
      ],
      "4": [
        "Yes",
        "Yes",
        "No",
        "450-8000 mmHg·s·cm",
        "> 4.5 seconds",
        "Normal",
        "No pressurization",
        "Normal esophageal motility"
      ],
      "5": [
        "Yes",
        "No",
        "Yes",
        "450-8000 mmHg·s·cm",
        "> 4.5 seconds",
        "Normal",
        "Compartmentalized (either esophageal or EGJ) pressurization",
        "EGJ outflow obstruction"
      ],
      "6": [
        "Yes",
        "Yes",
        "No",
        "< 450 mmHg·s·cm",
        "Unable to determine",
        "Unable to determine",
        "No pressurization",
        "Ineffective esophageal motility"
      ],
      "7": [
        "Yes",
        "No",
        "No",
        "450-8000 mmHg·s·cm",
        "< 4.5 seconds",
        "Normal",
        "No pressurization",
        "Distal esophageal spasm"
      ],
      "8": [
        "Yes",
        "No",
        "Yes",
        "< 450 mmHg·s·cm",
        "Unable to determine",
        "Unable to determine",
        "No pressurization",
        "Type II achalasia"
      ],
      "9": [
        "Yes",
        "No",
        "Yes",
        "450-8000 mmHg·s·cm",
        "< 4.5 seconds",
        "Fragmented",
        "No pressurization",
        "Type III achalasia"
      ],
      "10": [
        "Yes",
        "No",
        "No",
        "450-8000 mmHg·s·cm",
        "> 4.5 seconds",
        "Normal",
        "No pressurization",
        "Normal esophageal motility"
      ]
    }.each do |baseline_case_position, correct_answers|
      baseline_case = BaselineAssessmentCase.find_by(
        position: baseline_case_position.to_s
      )
      correct_answers.each_with_index do |correct_answer, index|
        AssessmentAnswer.find_by(
          assessment_case: baseline_case,
          assessment_question: questions[index],
          title: correct_answer
        ).update(is_correct: true)
      end
    end
  end
end
