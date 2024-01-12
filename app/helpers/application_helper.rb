module ApplicationHelper
    def university_options
        # Fetch all school names from the Schools table
        school_names = School.pluck(:name).sort
    end

    def university_options_with_films
        # Fetch all school names from the Schools table that have films
        school_names = School.joins(users: :films).distinct.pluck(:name).sort
    end
end
