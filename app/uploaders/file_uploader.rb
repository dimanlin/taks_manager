# encoding: utf-8
require 'carrierwave/processing/mime_types'

class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  process :save_size_in_model

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def original_file
    original_filename
  end

  def save_size_in_model
    model.file_size = file.size
  end
end
