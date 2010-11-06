class UserSession < Authlogic::Session::Base
  def to_key #not defining this returns an Error when instantiating 
    new_record? ? nil : [self.send(self.class.primary_key) ]
  end

end

