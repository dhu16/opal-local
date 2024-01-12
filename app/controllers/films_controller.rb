class FilmsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_authentication, only: [:new, :create, :show]
  def new
    render 'upload-form'
  end

  def create
    check_authentication
    return unless @user

    title = params[:title]
    description = params[:description]
    video_file = params[:video]
    thumbnail_file = params[:thumbnail]

    if !title || !video_file || !description || !thumbnail_file
      flash[:notice] = "Missing required fields"
      redirect_to '/upload_video'
      return
    end

    valid_video_formats = ['application/mp4', 'video/mp4', 'application/mpeg', 'video/mpeg']
    unless valid_video_formats.include?(video_file.content_type)
      flash[:notice] = "Invalid video filetype. Accepted types are mp4 and mpeg"
      redirect_to '/upload_video'
      return
    end

    valid_thumbnail_formats = ['image/png', 'image/jpeg']
    unless valid_thumbnail_formats.include?(thumbnail_file.content_type)
      flash[:notice] = "Invalid thumbnail filetype. Accepted types are png and jpeg"
      redirect_to '/upload_video'
      return
    end

    film = Film.new(
      title: title,
      description: description,
      user: current_user
    ) # TODO add link to director when we have login data

    film.video.attach(params[:video])
    film.thumbnail.attach(params[:thumbnail])

    film.save

    flash[:notice] = "#{title} is live!"
    puts film.film_url
    puts film.thumbnail_url

    redirect_to @user.profile_path
  end

  def delete_from_s3(item) #TODO change to use stuff from aws.rb and move to aws.rb
    s3 = Aws::S3::Resource.new
    obj = s3.bucket(ENV['S3_BUCKET']).object(item.key) 

    begin
      obj.delete
    rescue Aws::S3::Errors::NoSuchKey, Aws::S3::Errors::ServiceError => e
      Rails.logger.error("Error deleting from S3: #{e.message}")
    end
  end

  def destroy
    check_authentication

    @film = Film.find(params[:id])
    delete_from_s3(@film.video)
    delete_from_s3(@film.thumbnail)
    @film.destroy

    flash[:notice] = "Film deleted successfully."
    redirect_to current_user.profile_path
  end

  def show
    check_authentication
    @film = Film.find(params[:id]) # This will set the film based on the ID in the URL
    @comments = @film.comments.order(created_at: :desc)
    @comment = Comment.new
    render 'video-player'
  end

  def search
    if params[:search].present?
      @recent_films = Film.where('title ILIKE ?', "%#{params[:search]}%")
    else
      @recent_films = Film.all
    end
  end
  

end
