const { app, BrowserWindow } = require( 'electron' )
const Twitter = require( 'twitter' )

app.on( 'window-all-closed', () => app.quit() )

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
      const tweet = {
          text: event.text,
          created_at: event.created_at,
          user: {
            profile_image_url: event.user.profile_image_url,
            name: event.user.name,
            screen_name: event.user.screen_name,
          }
      }

      window.webContents.send( 'newTweet', JSON.stringify( tweet ) )
    } )
  } )
}

createWindow( {
  width: 360,
  height: 600,
} )
  .then( window => {
    window.loadURL( `file://${__dirname}/public/index.html` )
    window.setMaximumSize( 360, 600 )
    window.setMinimumSize( 360, 600 )
    window.setMenu( null )
    window.show()
    setupStream( window )
  } )
