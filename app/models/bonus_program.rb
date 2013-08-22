# encoding: utf-8
class BonusProgram < ActiveRecord::Base
  has_many :clients
  before_save :update_name
  def initialize(args={})
    super
    self.rate = 0
  end

  def to_s
    human_name
  end

  private
  def update_name
    self.name = Russian::transliterate self.human_name
  end
end
