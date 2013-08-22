# encoding: utf-8
class PagesController < ApplicationController
  before_filter :authenticate_user!
  def index
  end
end
