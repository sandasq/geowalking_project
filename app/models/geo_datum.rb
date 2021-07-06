# == Schema Information
#
# Table name: geo_datum
#
#  id                       :integer          not null, primary key
#  timestamp                :datetime
#  latitude                 :float
#  longitude                :float
#  altitude                 :float
#  horizontal_accuracy      :float
#  vertical_accracy         :float
#  speed                    :float
#  course                   :float
#  walk_id                  :integer
#  created_at               :datetime
#  updated_at               :datetime

class GeoDatum < ApplicationRecord

  def self.get_first_new_geo_data
    GeoDatum.where('walk_id is null').order('timestamp asc').first
  end

  def self.get_next_new_geo_data(current)
    GeoDatum.where("walk_id is null and id > ? ", current.id).order('timestamp asc').first
  end
end
