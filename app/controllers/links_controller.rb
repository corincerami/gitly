class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.find_or_initialize_by(long_url: link_params[:long_url])
    @link.shorten if !@link.valid?
    if @link.save
      flash[:notice] = "Link created"
      redirect_to link_path(@link)
    else
      render :new
    end
  end

  def show
    @link = Link.find(params[:id])
  end

  def redirect
    link = Link.find_by(short_url: params[:short_url])
    if link
      link.analytic.increment!(:visits, by = 1)
      if !link.analytic.unique_visitors.any? { |uv| uv.visitor_ip == request.ip }
        link.analytic.unique_visitors.create(visitor_ip: request.ip)
        link.analytic.increment!(:unique_visits, by = 1)
      end
      redirect_to link.long_url
    else
      flash[:error] = "Couldn't find that link"
      redirect_to :root
    end
  end

  private

  def link_params
    params.require("link").permit(:long_url)
  end
end
