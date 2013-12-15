require './module_attr_accessors.rb'

module IvoJesus

  module_attr_accessor name: 'Ivo Jesus',
                       age: 29,
                       gender: 'male',
                       phone_number: '934477556',
                       email: ['ivo.jesus@gmail.com', 'ivo.jesus@ymail.com', 'ivo.jesus@clix.pt']

end

# This is awesome to build gems with global configurations, modules with defaults, etc... why? because writing something like this is a drag:

# module IvoJesus
#   @@name = 'Ivo Jesus'
#   mattr_accessor :name
#
#   @@age = 29
#   mattr_accessor :age
#
#   # ... you can see the picture ...
# end


