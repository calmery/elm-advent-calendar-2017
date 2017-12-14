import { ipcRenderer } from 'electron'

const Elm = require( './elm/Main.elm' )

require( './static/index.html' )
require( './static/css/style.css' )

const app = Elm.Main.fullscreen()

ipcRenderer.on( 'newTweet', ( _, tweet ) => {
  app.ports.newTweet.send( tweet )
} )
