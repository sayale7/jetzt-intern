class Post < ActiveRecord::Base
  acts_as_authorization_object
  
  define_index do
    indexes body
    set_property :enable_star => true
    set_property :min_infix_len => 1
  end
  
end
