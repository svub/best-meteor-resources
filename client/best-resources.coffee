Template.list.helpers
  entry: -> entries.find {}, sort: count: -1
  counter: -> entries.find().count()

Template.listEntry.helpers
  isFavorite: -> (favorites.findOne entry: @_id, user: Meteor.userId())?
  isMine: -> @owner is Meteor.userId()

Template.listEntry.events
  'click .toggle-fav': -> Meteor.call 'toggle', @_id
  'click .delete': -> Meteor.call 'remove', @_id

Template.addLink.events
  'submit form.create': (event, template) ->
    Meteor.call 'create', (template.$ '.name').val(), (template.$ '.link').val()
    event.preventDefault()

