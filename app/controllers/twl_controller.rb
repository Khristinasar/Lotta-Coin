class TwlController < ApplicationController
  def tracker
    @tracker_twl = TrackerSm.new
    @tracker_twl.tracker_twl
  end
end
