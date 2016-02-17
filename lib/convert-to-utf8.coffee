fs    = require 'fs'
iconv = require 'iconv-lite'
jschardet = require 'jschardet'
iconv.extendNodeEncodings()

module.exports =

  activate: (state) ->
    atom.workspaceView.command "convert-to-utf8:open:gbk", => @open_encoding 'gbk'
    atom.workspaceView.command "convert-to-utf8:open:big5", => @open_encoding 'cp950'
    atom.workspaceView.command "convert-to-utf8:open:euc-kr", => @open_encoding 'euc-kr'
    atom.workspaceView.command "convert-to-utf8:open:cp932", => @open_encoding 'cp932'
    atom.workspaceView.command "convert-to-utf8:open:shift_jis", => @open_encoding 'shift_jis'
    atom.workspaceView.command "convert-to-utf8:open:euc-jp", => @open_encoding 'euc-jp'
    atom.workspaceView.command "convert-to-utf8:open:utf8", => @open_encoding 'utf8'
    atom.workspaceView.command "convert-to-utf8:save:gbk", => @save_encoding 'gbk'
    atom.workspaceView.command "convert-to-utf8:save:big5", => @save_encoding 'cp950'
    atom.workspaceView.command "convert-to-utf8:save:euc-kr", => @save_encoding 'euc-kr'
    atom.workspaceView.command "convert-to-utf8:save:cp932", => @save_encoding 'cp932'
    atom.workspaceView.command "convert-to-utf8:save:shift_jis", => @save_encoding 'shift_jis'
    atom.workspaceView.command "convert-to-utf8:save:euc-jp", => @save_encoding 'euc-jp'
    atom.workspaceView.command "convert-to-utf8:save:utf8", => @save_encoding 'utf8'

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
      text = iconv.decode data, encoding
      convertedText = text.toString 'UTF8'
      editor.setText convertedText
      
  save_encoding: (encoding) ->
    editor = atom.workspace.getActiveEditor()
    uri = editor.getUri()
    if not uri
      console.error('Please save it and convert again')
      return
    
    text = editor.getText
    data = iconv.encode text, encoding
    fs.writeFile uri data
