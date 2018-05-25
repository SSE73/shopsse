module TovarsHelper

  def get_tovar_images(color)
    data_images, data_image_angles,data_color_name = [], [], []

    color.images.each do |image|
      data_images.push(image.thumbnail(:small))
      data_image_angles.push(image.thumbnail(:medium))
    end
    data_color_name.push(color.name)

    [ data_images, data_image_angles,data_color_name ]
  end

end
