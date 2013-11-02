#include "hbgtinfo.ch"
//#include "hbcompat.ch"
#include "dbinfo.ch"

//set( _SET_EVENTMASK, INKEY_ALL )

hb_gtInfo( HB_GTI_FONTNAME , "Free Mono")
hb_gtInfo( HB_GTI_FONTWIDTH, 15)
hb_gtInfo( HB_GTI_FONTSIZE , 25)

setmode(40, 120)
nSay = 0
nSay2 = 2
cStr := "                   "

@ 1, 1 SAY "Hello"

@ 1, 10 GET nSay PICTURE "9999.99"
@ 2, 10 GET nSay2 PICTURE "9999.99"


 nColor := 1            //default to the first item.
 aGroup := ARRAY( 3 )
 aGroup[ 1 ] := RadioButto( 6, 22, "&Red" )
 aGroup[ 2 ] := RadioButto( 7, 22, "&Green" )
 aGroup[ 3 ] := RadioButto( 8, 22, "&Blue" )
 @ 5, 20, 9, 40 GET nColor RADIOGROUP aGroup


 cState := "NY"

  @ 10, 20, 20, 30 GET cState LISTBOX { { "Alabama", "AL" }, ;
                                      { "Alaska", "AK" }   , ;
                                     { "Arrizna", "AZ" }, ;
                                     { "Saraj", "SA"   } } ;
                CAPTION "&State" ;
                MESSAGE "Select the client's state"



@ 35, 10 SAY "aaaaaaaaaaaaaaaa" GET cStr
READ
