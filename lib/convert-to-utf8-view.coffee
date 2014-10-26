{View} = require 'atom'

module.exports =
class ConvertToUtf8View extends View
  @content: ->
    @div class: 'convert-to-utf8 overlay from-top', =>
      @div "The ConvertToUtf8 package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "convert-to-utf8:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "ConvertToUtf8View was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
