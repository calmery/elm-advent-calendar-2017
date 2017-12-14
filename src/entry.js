const { app, BrowserWindow } = require( 'electron' )
const Twitter = require( 'twitter' )

const createWindow = options => {
  return new Promise( ( resolve, _ ) => {
    app.on( 'ready', () => {
      const window = new BrowserWindow( options )
      resolve( window )
    } )
  } )
}

const setupStream = window => {
  const client = new Twitter( {
    consumer_key: process.env.CONSUMER_KEY,
    consumer_secret: process.env.CONSUMER_SECRET,
    access_token_key: process.env.ACCESS_TOKEN_KEY,
    access_token_secret: process.env.ACCESS_TOKEN_SECRET
  } )

  client.stream( 'statuses/filter', {
    track: '#elm'
  }, stream => {
    stream.on( 'data', event => {
      const tweet = event.text
      window.webContents.send( 'newTweet', tweet )
    } )
  } )
}

createWindow()
  .then( window => {
    window.loadURL( `file://${__dirname}/public/index.html` )
    window.openDevTools()
    setupStream( window )
  } )
