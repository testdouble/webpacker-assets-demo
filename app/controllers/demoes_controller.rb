class DemoesController < ApplicationController
  def show
    render :inline => '', :layout => 'application'
  end
end
