fs    = require 'fs'
iconv = require 'iconv-lite'
jschardet = require 'jschardet'
iconv.extendNodeEncodings()

module.exports =

  activate: (state) ->
    atom.workspaceView.command "convert-to-utf8:gbk", => @open_encoding 'gbk'
    atom.workspaceView.command "convert-to-utf8:big5", => @open_encoding 'cp950'
    atom.workspaceView.command "convert-to-utf8:euc-kr", => @open_encoding 'euc-kr'
    atom.workspaceView.command "convert-to-utf8:cp932", => @open_encoding 'cp932'
    atom.workspaceView.command "convert-to-utf8:shift_jis", => @open_encoding 'shift_jis'
    atom.workspaceView.command "convert-to-utf8:euc-jp", => @open_encoding 'euc-jp'
    atom.workspaceView.command "convert-to-utf8:utf8", => @open_encoding 'utf8'

  deactivate: ->
    #@convertToUtf8View.destroy()

  serialize: ->
    #convertToUtf8ViewState: @convertToUtf8View.serialize()

  open_encoding: (encoding) ->
    editor = atom.workspace.getActiveEditor()
    uri = editor.getUri()
    if not uri
      console.error('Please save it and convert again')
      return

    stream = fs.createReadStream uri
    stream.on 'data', (data) ->
      detectedEncoding = jschardet.detect data
      if encoding isnt detectedEncoding.encoding
        console.log "Recommend you Ctrl+Z and encode with #{detectedEncoding.encoding}"

      text = iconv.decode data, encoding
      convertedText = text.toString 'UTF8'
      editor.setText convertedText
