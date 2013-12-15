require './infinite_hash.rb'

# This will create an "infinite hash" - aka tree.
h = Hash.infinite
h[:um][2]["tres"][4] = 5

## with this you do not need to worry about nils when making assignments.
## otherwise you would end up with code something like:
# h = {}
# h[:um] ||= {}
# h[:um][2] ||= {}
# h[:um][2]["tres"] ||= {}
# h[:um][2]["tres"][4] = 5
## bummer...


# Also you can limit the depth to which the tree will "auto-generate"
h = Hash.recursive 3
# Then, this would be valid:
h[:um][2]["tres"] = 4
# But this would blow up on your face:
h[:um][2]["tres"][4] = 5

