
FUNCTION TermWrite( cMsg )
   
   local cJSon
   local hJSon := hb_Hash()
   local nLen
   local oClient
   
   oClient = H5_GetClient()
   
   hJSon[ "ACTION" ] = "TW"
   hJSon[ "MSG" ]    = cMsg
   cJSon := hb_jsonEncode( hJSon, @nLen, .F. )
   
   ? "SendData:", cJSon
   oClient:SendData( cJSon )

RETURN NIL

FUNCTION TermResize( cols, rows )
   
   local cJSon
   local hJSon := hb_Hash()
   local nLen
   local oClient
   
   oClient = H5_GetClient()
   
   hJSon[ "ACTION" ] = "TR"
   hJSon[ "COLS" ]    = cols
   hJSon[ "ROWS" ]    = rows
   cJSon := hb_jsonEncode( hJSon, @nLen, .F. )
   
   ? "SendData:", cJSon
   oClient:SendData( cJSon )

RETURN NIL

