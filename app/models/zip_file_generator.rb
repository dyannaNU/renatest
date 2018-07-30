# frozen_string_literal: true

require "zip"

# create zip file from folder recursively
# taken directly from https://github.com/rubyzip/rubyzip/blob/master/README.md
class ZipFileGenerator
  def initialize(input_directory, output_file)
    @input_directory = input_directory
    @output_file = output_file
  end

  def write
    entries = Dir.entries(@input_directory) - %w[. ..]
    io = Zip::File.open(@output_file, Zip::File::CREATE)
    write_entries(entries, "", io)
    io.close

    true
  rescue Errno::ENOENT
    false
  end

  private

  def write_entries(entries, path, io)
    entries.each do |entry|
      zip_file_path = path == "" ? entry : File.join(path, entry)
      disk_file_path = File.join(@input_directory, zip_file_path)

      if File.directory?(disk_file_path)
        recursively_deflate_directory(disk_file_path, zip_file_path, io)
      else
        put_into_archive(disk_file_path, zip_file_path, io)
      end
    end
  end

  def recursively_deflate_directory(disk_file_path, zip_file_path, io)
    io.mkdir(zip_file_path)
    subdir = Dir.entries(disk_file_path) - %w[. ..]
    write_entries(subdir, zip_file_path, io)
  end

  def put_into_archive(disk_file_path, zip_file_path, io)
    io.get_output_stream(zip_file_path) do |file|
      file.puts(File.open(disk_file_path, "rb").read)
    end
  end
end
