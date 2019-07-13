class Lesson < ApplicationRecord
  belongs_to :section

  mount_uploader :video, VideoUploader
  mount_uploader :image, ImageUploader

  include RankedModel
  ranks :row_order, with_same: :section_id
end
