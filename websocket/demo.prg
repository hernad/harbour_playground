/*
(c)2012 Daniel Garcia-Gil <danielgarciagil@gmail.com>
*/
#include "h5.ch"


PROCEDURE Main( cPort, cMode )
   LOCAL nError
   LOCAL cMsg
   local oWebSocket
   
   if cPort == NIL
       cPort := "8090" 
   endif
   cMode :=  "NONE" 
  
   oWebSocket := WebSocketServer():New( cPuerto, cMode, , {|| WebApp( ) } )

   
RETURN

STATIC FUNCTION WebApp( )

   local oMenu, oWnd, oSay, n, j
   local oRow, oCol, oTitle
   
   MENU oMenu
      MENUITEM "Test 1"
      MENU 
         MENUITEM "Date" ACTION ( MsgAlert( DToC( date() ) ) )
         MENUITEM "Time" ACTION ( MsgAlert( time() ) )
         MENUITEM "Harbour Version" ACTION ( MsgAlert( hb_version() ) )
         MENUITEM "Say ErnadH" ACTION ( SetTitle(oTitle, "ErnadHHHHH") )
         MENUITEM "Say Bakir" ACTION ( SetTitle(oTitle, "Bakir") )
         MENUITEM "Term write" ACTION ( TermWrite("test term write\r\n") )
         MENUITEM "Term resize" ACTION ( TermResize( 100, 30 ) )
         MENUITEM "Ide submeni ..."
         MENU 
            MENUITEM "Test 1.2.1"
            MENUITEM "Test 1.2.2"
            MENUITEM "Test 1.2.3"
            MENUITEM "Test 1.2.4"
            MENU
               MENUITEM "Test 1.2.4.1"
               MENUITEM "Test 1.2.4.2"
               MENUITEM "Test 1.2.4.3"
               MENUITEM "Test 1.2.4.4"  ACTION ( MsgAlert( "Item Clicked " + oSender:cPrompt ) )          
            ENDMENU            
         ENDMENU
         MENUITEM "Test 1.3"
         MENUITEM "Test 1.4"
      ENDMENU
      MENUITEM "Test 2"      
      MENUITEM "Test 3"
      MENUITEM "Test 4"

   ENDMENU
   
   
   
   oWnd = C_Window():New( oMenu )
   
   C_Say():New( 50, 20, "Row:", oWnd )
   C_Say():New( 70, 20, "Col:", oWnd )

   oTitle := C_Say():New(100, 40, "", oWnd)

   oRow = C_Say():New( 50, 50, ".", oWnd )
   oCol = C_Say():New( 70, 50, ".", oWnd )   

  oWnd:bOnMouseMove = {| r, c | MouseMove( r, c, oRow, oCol ) }
  oWnd:Activate()
   

RETURN NIL

FUNCTION MouseMove( nRow, nCol, oRow, oCol )
   oRow:SetText( Str( nRow ) )
   oCol:SetText( Str( nCol ) )

RETURN NIL
 
FUNCTION SetTitle(oTitle, cTitle)
   oTitle:SetText( cTitle )
RETURN NIL


/*
FUNCTION ReadData( cDecodeData, oClient )

? "ReadData:", cDecodeData
*/
RETURN NIL
