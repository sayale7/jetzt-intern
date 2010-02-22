class Page < ActiveRecord::Base
  acts_as_tree
  validates_presence_of :name
  
  define_index do
    indexes content
    set_property :enable_star => true
    set_property :min_infix_len => 1
  end
end
