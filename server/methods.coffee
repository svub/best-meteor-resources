Meteor.methods
  'toggle': (entryId) ->
    check entryId, String
    check @userId, String
    check (entry = entries.findOne entryId), Object
    if (fav = favorites.findOne entry: entryId, user: @userId)?
      favorites.remove _id: fav._id
      entries.update entryId, $inc: count: -1
    else
      favorites.insert entry: entryId, user: @userId
      entries.update entryId, $inc: count: 1
  'create': (name, link) ->
    check name, String
    check link, String
    check @userId, String
    entries.insert name: name, link: name, owner: @userId, count: 0
  'remove': (id) ->
    check id, String
    check (entry = entries.findOne id), Object
    if entry.owner is @userId
      entries.remove _id: id
      favorites.remove entry: id
