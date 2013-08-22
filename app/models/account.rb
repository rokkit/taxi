# encoding: utf-8
class Account < ActiveRecord::Base
  belongs_to :client

  def windraw_bonus_points bonus
    raise "Not enought bonus" if total < bonus
    self.total = self.total - bonus.to_f
    save
  end

  def add_bonus_points price, added_bonus
    self.total = self.total + added_bonus
  end

  def total_bonus_points
     Orders::calculate_total_bonus self.client
  end
end
