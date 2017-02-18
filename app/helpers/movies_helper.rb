module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def headerType(header_type)
  	puts "@sort=#{@sort}"
  	session[:sort] == header_type ? "hilite" : ""
  end
end
