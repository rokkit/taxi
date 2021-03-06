# encoding: utf-8
class BonusProgram < ActiveRecord::Base
  has_many :clients
  before_save :update_name
  def initialize(args={})
    super
    self.rate = 0
  end

  def to_s
    human_name.force_encoding("cp1251").encode("utf-8", undef: :replace)
  end

  private
  def update_name
    self.name = Russian::transliterate self.human_name.encode
  end
end
