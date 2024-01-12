require_relative 'university_helper'

task :populate_schools => :environment do
  include UniversityHelper

  schools_data = university_options
  # Process schools_data and populate the schools table
  schools_data.each do |school_name|
    # Check if the school already exists
    existing_school = School.find_by(name: school_name)

    unless existing_school
      # Create a new record only if the school doesn't exist
      School.create(name: school_name)
    end
  end
end
