class TempUser < ActiveRecord::Base
  attr_accessible :email, :moment_id
  belongs_to :moment
end
