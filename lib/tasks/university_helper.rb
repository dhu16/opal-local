module UniversityHelper
    def university_options
      response = UniversityService.get_all_universities
      #Rails.logger.debug("Response Class: #{response.class}")
      #Rails.logger.debug("Full Response: #{response.inspect}")
  
      if response.present?
        begin
          universities = response
          university_names = universities&.map { |u| u['school.name'] } || []
          #Rails.logger.debug("University Options: #{university_names.inspect}")
          university_names
        rescue JSON::ParserError => e
          Rails.logger.error("Failed to parse JSON: #{e.message}")
          []
        end
      else
        Rails.logger.error("Failed to fetch universities: #{response.code} - #{response.parsed_response}")
        []
      end
    rescue StandardError => e
      Rails.logger.error("An error occurred while fetching universities: #{e.message}")
      []
    end
  end
  