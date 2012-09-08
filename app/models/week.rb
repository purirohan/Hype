class Week < ActiveRecord::Base
  attr_accessible :today, :timestamps

  def self.this_week
    recover()
    update_week()
    find(1)
  end

  def self.update_week
    week = Week.find(1)
    unless week.blank?
      if week.today < 1.week.ago
        week.today = Date.today
        week.save
      end
    end  
  end

  def self.recover
    week = Week.find(:all)
    if week.blank?
      @week = Week.new(:today => Date.today)
      @week.save
    end
  end
end
