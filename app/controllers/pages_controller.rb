class PagesController < ApplicationController
  def home
  end

  def contact
    @enquiry = Enquiry.new
  end

  def about
  end

  def privacy
  end
end
