class Codroo < ActiveRecord::Base
  belongs_to :user
  has_many :messages
  #validates_acceptance_of :terms
  validates_uniqueness_of :name
  validates_length_of :name, :minimum => 3, :maximum => 50
  validates_length_of :description, :minimum => 20, :maximum => 500
  
end

