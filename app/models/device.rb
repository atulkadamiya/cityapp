class Device < ActiveRecord::Base
  attr_accessible :device_id

  has_many :devices_issues
  has_many :issues, :through => :devices_issues
end
