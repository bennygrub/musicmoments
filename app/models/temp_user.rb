class TempUser < ActiveRecord::Base
  attr_accessible :email, :moment_id, :name
  belongs_to :moment
end
