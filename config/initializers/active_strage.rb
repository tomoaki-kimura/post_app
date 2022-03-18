require "exifr/jpeg"

class GpsExtention < ActiveStorage::Analyzer::ImageAnalyzer
  def metadata
    read_image do |image|
      if rotated_image?(image)
        { width: image.height, height: image.width }
      else
        { width: image.width, height: image.height }
      end.merge(gps_from_exif(image))
    end
  rescue LoadError
    logger.info "gem 'mini_magick' isn't installed"
    {}
  end
  private

  def ref(gps_ref)
    %w[N E].include?(gps_ref) ? 1 : -1
  end

  def gps_from_exif(image)
    {}.tap do |data|
      next unless image.type == "JPEG"
      next if image.is_a? ActiveStorage::Variant

      image_data = EXIFR::JPEG.new(image.path)
      if image_data.exif&.fields[:gps]
        latitude = image_data.gps_latitude.to_f * ref(image_data.gps_latitude_ref)
        longitude = image_data.gps_longitude.to_f * ref(image_data.gps_longitude_ref)
        data[:latitude] = latitude
        data[:longitude] = longitude
      end
    end

  rescue EXIFR::MalformedImage, EXIFR::MalformedJPEG
  end
end

Rails.application.configure do
  config.active_storage.analyzers.delete ActiveStorage::Analyzer::ImageAnalyzer
  config.active_storage.analyzers.append GpsExtention
end