# GeoWalkCreator will loop through the new geo data and find each new walk based on timestamp.
# If more than 10 minutes has elapsed it is determined it will be a new walk
class GeoWalkCreator
    def process_for_new_walks
      # get the first timestamp on a new walk determine by an empty walk_id
      current_geo = GeoDatum.get_first_new_geo_data
      return unless current_geo.present?

      @first_timestamp = current_geo.timestamp
      # create new walk record and establish a unique id
      @distance = 0
      @geowalk = Walk.new
      @geowalk.save

      # update the current geo data record with the walk_id
      current_geo.update_column(:walk_id, @geowalk.id)
      check_for_same_walk(current_geo)
    end

    # If it is detemined to be the same walk, calculate the distance between the current and next record
    def check_for_same_walk(current_geo)
      next_geo = GeoDatum.get_next_new_geo_data(current_geo)
      # there are no more new records so update and return
      if next_geo.blank?
        @last_timestamp = current_geo.timestamp
        update_geo_walk
        return
      end

      minutes = (next_geo.timestamp - current_geo.timestamp) / 1.minutes
      if minutes < 10
          next_geo.update_column(:walk_id, @geowalk.id)

          #distance accumulates for the current walk
          @distance += calculate_distance(current_geo.latitude, current_geo.longitude, next_geo.latitude, next_geo.longitude)
          current_geo = next_geo
          check_for_same_walk(current_geo)
      else
        @last_timestamp = current_geo.timestamp
        # forcing a new walk because of elapsed time
        prepare_for_next_walk
      end
    end

    def prepare_for_next_walk
      update_geo_walk
      process_for_new_walks
    end

    def update_geo_walk
      duration = (@last_timetsamp - @first_timestamp) / 60
      speed = @distance / duration

      @geowalk.distance = @distance
      @geowalk.duration = duration
      @geowalk.average_speed = speed
      @geowalk.save
    end

    DEGREES_TO_RADIANS = 57.2958
    EARTH_RADIUS = 3963.0 # miles
    def calculate_distance(lat1, lng1, lat2, lng2)
      # Great Circle Distance Formula using decimal degrees
      lat1r = lat1 / DEGREES_TO_RADIANS
      lng1r = lng1 / DEGREES_TO_RADIANS
      lat2r = lat2 / DEGREES_TO_RADIANS
      lng2r = lng2 / DEGREES_TO_RADIANS
      EARTH_RADIUS * Math.acos(
        (Math.sin(lat1r) * Math.sin(lat2r)) + \
        (Math.cos(lat1r) * Math.cos(lat2r) * Math.cos(lng2r - lng1r))
      ) rescue 0
    end
end
