class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  # GET /sites/new
  def new
    @site = Site.new
  end

  # POST /sites
  def create
    @site = Site.new(site_params)
    @site.url = begin
      Site.clean_url(@site.url)
    rescue
      Rails.logger.warn($!)
    end

    #Check if site exists, if so, load it
    existing_site = Site.where({:url => @site.url}).take()
    @site = existing_site unless existing_site.nil?()

    respond_to do |format|
      if verify_recaptcha({:model => @site}) && @site.save
        format.html
      else
        format.html { render :new }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:url)
    end
end
