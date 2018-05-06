class Image
  attr_accessor :created_time, :likes_count, :uri
  def initialize(raw_image_info)
    @uri         = raw_image_info.images.standard_resolution.url
    @likes_count = raw_image_info.likes.count
    @created_time  = raw_image_info.created_time
  end
end
