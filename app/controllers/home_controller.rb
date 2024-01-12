class HomeController < ApplicationController
  helper ApplicationHelper
  def index
    check_authentication
    @recent_films = filter_films_by_school(Film.order(created_at: :desc))

    if params[:school].present?
      @school = School.find_by(name: params[:school]).name
    else
      @school = ""
    end
  end

  private

  def filter_films_by_school(films)
    if params[:school].present?
      films.joins(user: :school).where(schools: { name: params[:school] })
    else
      films
    end
  end
end
