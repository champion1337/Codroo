class User < ActiveRecord::Base
  acts_as_authentic #use the AuthLogic plugin
  has_many :codroos, :dependent => :destroy
end
