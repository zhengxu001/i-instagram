class Image
  def self.build_image(raw_image_info)
    image = {
        url: raw_image_info.images.standard_resolution.url,
        like: raw_image_info.likes.count,
        created_at: raw_image_info.created_time
      }
  end
end
  