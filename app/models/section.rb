class Section < ApplicationRecord
  belongs_to :course
  has_many :lessons, :dependent => :delete_all

  include RankedModel
  ranks :row_order, with_same: :course_id
end
