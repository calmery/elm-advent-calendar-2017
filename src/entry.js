const { app, BrowserWindow } = require( 'electron' )

const createWindow = options => {
  return new Promise( ( resolve, _ ) => {
    app.on( 'ready', () => {
      const window = new BrowserWindow( options )
      resolve( window )
    } )
  } )
}

createWindow()
  .then( window => {
    window.loadURL( `file://${__dirname}/public/index.html` )
  } )
