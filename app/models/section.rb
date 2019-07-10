class Section < ApplicationRecord
  belongs_to :course
  has_many :lessons, :dependent => :delete_all
end
