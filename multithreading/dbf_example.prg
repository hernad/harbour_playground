static aDbfs

REQUEST DBFCDX

proc main

   LOCAL xRet

   FERASE( "test.dbf" )
   FERASE( "test_2.dbf" )


   hDbfs := hb_hash()

   hDbfs[ "test" ] := hb_hash()
   hDbfs[ "test" ][ "wa" ] := 100
   hDbfs[ "test" ] [ "struct" ] :=  {;
                 { "ID", "C",   2, 0 }, ;
                 { "NAZ", "C",  20, 0 } }
   hDbfs[ "test" ][ "name" ] := "test.dbf"

   hDbfs[ "test_2" ] := hb_hash()
   hDbfs[ "test_2" ][ "wa" ] := 101
   hDbfs[ "test_2" ] [ "struct" ] :=  {;
                 { "ID", "C",  40, 0 }, ;
                 { "NAZ", "C",  40, 0 } }

   hDbfs[ "test_2" ][ "name" ] := "test_2.dbf"

   my_create( hDbfs[ "test" ] )
   //my_create( hDbfs[ "test_2" ] )

   hb_threadStart( @thread_my_create(), hdbfs[ "test_2" ], @xRet )
   my_use( hDbfs[ "test" ])
  
   append blank
   replace id with "11", naz with "test"
 
   my_use( hDbfs[ "test_2" ])
   append blank
   replace id with "2222", naz with "test22"


   select test
   ? "test:", id, naz
   select test_2
   ? "test_2", id, naz

function my_create( hDbfRec )
  
    SELECT ( hDbfRec[ "wa" ] )
    dbCreate( hDbfRec[ "name" ], hDbfRec[ "struct" ], "DBFCDX" )
    ? hDbfRec[ "name" ], "kreirana !"
    RETURN


function my_use ( hDbfRec )

    DO WHILE .T.
       IF !FILE( hdbfRec[ "name" ] )
           ? hDbfRec[ "name" ], "nije kreiran, cekam ..."
           hb_idleSleep( 0.3 )
       ELSE
           EXIT
       ENDIF
    ENDDO
        
    SELECT ( hDbfRec[ "wa" ] ) 
    USE (hDbfRec[ "name" ] ) VIA "DBFCDX" EXCLUSIVE
    RETURN


function thread_my_create( hDbfRec, xRet )

   hb_idleSleep( 2 )
   my_create( hDbfRec )

   RETURN

