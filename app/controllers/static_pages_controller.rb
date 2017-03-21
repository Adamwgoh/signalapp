class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  def index
    render "index"
	end
end
