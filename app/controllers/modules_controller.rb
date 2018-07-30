# frozen_string_literal: true

# actions for modules which are read by participants
class ModulesController < ApplicationController
  DEFAULT_FILE = "/story_html5"

  def index
    @presenter = StoriesPresenter.new(current_participant)
    @report_card_presenter = ReportCard.new(
      participant: current_participant,
      assessment_cases: BaselineAssessmentCase.all
    )
  end

  def show
    @story_path = directory + DEFAULT_FILE

    respond_to do |format|
      format.js
    end
  end

  def download_zip_file
    temp_file = Tempfile.new(["module_files", ".zip"])
    if ZipFileGenerator.new(module_files_path, temp_file.path).write
      send_file temp_file.path,
                type: "application/zip",
                disposition: "attachment",
                x_sendfile: true
    else
      redirect_to modules_url,
                  alert: "Unable to find the file!"
    end
  end

  private

  def directory
    Story
      .find_by!(file_name: params[:id])
      .file_name
  end

  def module_files_path
    Rails.root.join("public", "system", "module_files")
  end
end
