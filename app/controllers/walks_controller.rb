class WalksController < ApplicationController
  def index
    GeoWalkCreator.new.process_for_new_walks

    @walks = Walk.all
  end
end
