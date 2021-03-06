class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    #Part 1
    @sort = params[:sort] ? params[:sort] : session[:sort]
    #puts "@sort = #{@sort}" 
    if !@sort.nil?
      @movies = @movies.order(@sort)
    end
    session[:sort] = @sort
    #Part 2
    @all_ratings = Movie.ratings
    @ratings = params[:ratings] ? params[:ratings] : session[:ratings]
    if !@ratings.nil?
      #Check to see if ratings is an array.
      if !@ratings.kind_of?(Array)
        @ratings = @ratings.keys
      end
      #Query the model with the selected ratings
      @movies = @movies.where({rating: @ratings})
    else
      @ratings = Movie.ratings
    end
    session[:ratings] = @ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
