class UniversityService
  include HTTParty
  base_uri 'https://api.data.gov/ed/collegescorecard/v1/schools'

  def self.get_all_universities
    key = 'KI1mUFGCwxcdnd0YhVastxoYn2VUg6zCFov571Pv'
    per_page = 100
    max_pages = 20
    page = 1
    universities = []

    while page <= max_pages
      options = {
        query: {
          'school.degrees_awarded.predominant' => 3,
          'fields' => 'school.name',
          'per_page' => per_page,
          'page' => page,
          'api_key' => key
        }
      }

      response = get('', options)
      break unless response.success?

      universities.concat(response['results'])
      page += 1
    end

    universities
  end
end
