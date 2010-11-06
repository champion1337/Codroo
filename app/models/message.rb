class Message < ActiveRecord::Base
  has_many :replies, :class_name => "Message"
  belongs_to :reply, :class_name => "Message"
  belongs_to :user #posted by a user
  belongs_to :codroo #posted inside a codroo
  validates_presence_of :user, :message => "You must be logged in to post messages"
  validates_length_of :message, :maximum => 3000, :message => "You message can't have more than 3000 characters"

  #validates_with PermissionsValidator, :fields => [:codroo, :reply, :user]
  #the class is declared inside the helper, but some unkown reaons it fails to instantiate
 

end


