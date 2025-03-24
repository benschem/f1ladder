class LadderController < ApplicationController
  def show
    @drivers = Driver.all
  end
end
