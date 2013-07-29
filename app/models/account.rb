class Account < ActiveRecord::Base
  belongs_to :user

  def windraw_bonus_points bonus
    raise "Not enought bonus" if total < bonus
    self.total = self.total - bonus.to_f
    save
  end
end
