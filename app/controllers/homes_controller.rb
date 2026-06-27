class HomesController < ApplicationController
   allow_unauthenticated_access only: %i[ about ]
  def about
  end
end
