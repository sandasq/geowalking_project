# == Schema Information
#
# Table name: geo_walk
#
#  id                       :integer          not null, primary key
#  distance                 :float
#  duration                   :float
#  average_speed            :float
#  created_at               :datetime
class Walk < ApplicationRecord
  has_many :geo_data, dependent: :destroy, inverse_of: :walk
end
