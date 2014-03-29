var oServer;
var lWorking = false;
var term;
var socket;

function H5_SocketServer(serverUrl)
{
    oServer = this;
    /* The actual websocket connection */
    this.webSocket = null;
    
    /* Contains the WebSockets URL */
    this.serverUrl = serverUrl;
    
    /* This is usefull for protocol version detection when your browser
     * is using an old version of the protocol and calls onClose after the
     * the first connection attempt
     */
    this.connected = false;
    
    /* Call this method to connect to the WebSockets server */
    this.connect = function()
    {
        /* See if there is support for WebSockets in your server
         * and whether it is prefixed. */
        if ("WebSocket" in window) /* Chromium uses no prefix */
        {
            socket = new WebSocket(this.serverUrl);
            this.webSocket = socket;
        }
        else if ("MozWebSocket" in window) /* Mozilla uses the Moz prefix */
        {
            this.webSocket = new MozWebSocket(this.serverUrl);
        }
        else /* Or there is just no WebSockets support.... */
        {
            this.errorMessage('You can try a Chromium or Firefox nightly for free!');
            return false;
        }
        /* Bind events to the methods that will handle them, keeping intact the original
         'this. */
        this.webSocket.onopen = this.bind(this, this.onOpen);
        this.webSocket.onclose = this.bind(this, this.onClose);
        this.webSocket.onmessage = this.bind(this, this.onMessage);
        this.webSocket.onerror = this.bind(this, this.onError);


        term = new Terminal({
           cols: 80,
           rows: 24,
           useStyle: true,
           screenKeys: true
        });

        term.on('data', function(data) {
            console.log( "term.on data: " + data);
            socket.send( data );
        });

        term.on('title', function(title) {
             console.log( "term.on title");
             document.title = title;
        });
        
        term.open(document.body);

        term.write('\x1b[31mDobro došli u term.js!\x1b[m\r\n');
        //term.write('\033]2Novi title;');

    };
    
    /* Event that is called when your browser connected to the server... */
    this.onOpen = function(e)
    {
        console.log("on open");
        /* Update connection status */
        this.connected = true;
        this._HandleEvent( 0x1, 0, 0, "" );
    };
    
    /* Event that is called when your browser has been disconnectedt from
     * the server. This event will be called when your browser tried to connect
     * but failed because it is using an old version of the protocol... or the server
     * is just down. */
    this.onClose = function(e)
    {
        console.log("on close");
        term.destroy();
        /* If we were connected, the server went down or the connection timed out. */
        if (this.connected)
        {
            alert( "Disconnected!!!!");
        }
        else /* If we were never connected, the server is down our your browser has the wrong protocol version */
        {
            alert('Your browser could not connect to the WebSocket server. This might be because the server is down or because your browser is using an old version of the protocol. This version of the protocol is only supported by the Chromium and Firefox nightly builds.'); 
        }
    
        /* Update connection status */
        this.connected = false;
    };
    
    /* This event will be called when the browser recieves a message from the server. */
    this.onMessage = function( msg )
    {     
       
       console.log("on msg" + msg.data);
       var JSON;
       
       JSON = eval ("(" + msg.data + ")");
       ServerMessageHandler( JSON );

       //console.log("webSocket.on data " + data);
       //      term.write(data);
 
    };
    
    /* This event will be raised when an error has accured on the WebSocket */
    this.onError = function(e)
    {
        console.log("on error");
        alert('** An error has accured');
    };
   
   
   
   this._HandleEvent = function( nMsg, wParam, lParam, cParam )
   {
       var wevent = { 
           "message": nMsg,
           "wParam" : wParam,
           "lParam" : lParam, 
           "cParam" : cParam
         };
                   
       var json = JSON.stringify(wevent);                  
       
       this.postMessage( json )
   }    
    
    this.postMessage = function( message )
    {
    	  if( ! lWorking )
    	  {
    	  	 lWorking = true;
           this.webSocket.send( message );
           lWorking = false;
        }
    };

    
    this.errorMessage = function(message)
    {
        /* Create a new p element */
        newp = document.createElement('p');
        /* Content would be the message */
        var contenido = document.createTextNode(message);        
        newp.appendChild(contenido);
        /* Append to the chatwindows */
        document.body.appendChild(newp);
   
    };
    
    /* Used for scoping 'this' */
    this.bind = function (scope, fn) {
        return function () {
            fn.apply(scope, arguments);
       };
    };
};

function ServerMessageHandler( json )
{
   var acc = json.ACTION;
   switch( acc ) {
      case "CREATEMENU":
         createMenu( json );
         break;
      case "MSGALERT":
         //alert( json.MSG );
         term.write('\x1b[31m' + json.MSG + '\x1b[m\r\n');
         break;
      case "BUILDCONTROLS":
         $.each( json.PARAMETERS, function(i, n) {
            console.log("BUILDCONTROLS " +  i + ":" + JSON.stringify( n ) );
            ServerMessageHandler( n );
         });      
         break;
      case "CREATESAY":
         CreateSay( json );
         break;
      case "SETTEXTSAY":
         SetTextSay( json );
         break;
      case "CONFIGWND":
         ConfigWnd( json );
         break;
      case "TW":
         term.write( json.MSG );
         break;
      case "TR":
         console.log( "term resize" );
         term.resize( json.COLS, json.ROWS );
         break;


 
    }
}

function onMenuItemClick( p_sType, p_aArgs ) {
   var oEvent = p_aArgs[0], // DOM Event
   oMenuItem  = p_aArgs[1]; // YAHOO.widget.MenuItem instance
   var oMenuParent;
   
   if (oMenuItem) {
      oMenuParent = oMenuItem.parent;
      while( oMenuParent.id.substring(0, 3) != "MNU" )
      {
        oMenuParent = oMenuParent.parent;
      }
      oServer._HandleEvent( 0x2, oMenuItem.id, oMenuParent.id, "" );
   }   
   
}

function CreateSay( json )
{
  console.log("createsay");
  var say = document.createElement("div");
  var par = json.PARAMETER;
  
  say.class            = "MySay";
  say.id               = par.ID;
  say.innerHTML        = par.cText;
  say.style.top        = par.nRow + "px";
  say.style.left       = par.nCol + "px";
  say.style.position   = "absolute";

//  say.style.backgroundColor = "#398278";

  document.getElementById(par.PARENT).appendChild(say);
  
}

function SetTextSay( json )
{
  var par = json.PARAMETER;
  console.log("SetTextSay:" + par.ID);
  var say = document.getElementById(par.ID);
 
  if (say == null) 
     console.log( par.ID + " ne postoji !?");
  else
     say.innerHTML = par.cText;
  
}

function createMenu( json ) {
 
    
    console.log("createMenu");
    var aItemData = json.items;
    
    // Instantiate a MenuBar, passing in the id of the element to be created

    var oMenuBar = new YAHOO.widget.MenuBar( json.ID );

    // Add items to the MenuBar instance
    oMenuBar.addItems(aItemData);
 
    // Render the MenuBar instance
    oMenuBar.subscribe( "click", onMenuItemClick );

    oMenuBar.render(document.getElementById( json.PARENT ));
 
};

function HIGHWORD( a )
{
	return ( a - LOWWORD( a ) ) >> 16;
}

function LOWWORD( a )
{
	return a & ( ( 1 << 16 ) -1 ) ;
}

function MAKEDWORD( a, b )
{
   return ( a << 16 ) + b; 
}

function _OnMouseMove( ev )
{
   if( ev.currentTarget.id == ev.target.id )
   {
    oServer._HandleEvent( 0x3, MAKEDWORD( ev.clientY, ev.clientX ), ev.currentTarget.id, "" );
   }
}

function ConfigWnd( json )
{
        console.log("configWnd");
	var par = json.PARAMETERS;
	
	var divmain = document.getElementById( "divmain" );
	divmain.id = par.ID;
	divmain.style.width = "100%";
	divmain.style.height = "100%";
	divmain.style.position = "absolute";
	divmain.onmousemove = _OnMouseMove;
 
}
  
