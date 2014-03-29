static aDbfs
static s_hMutex

REQUEST DBFCDX

proc main

   LOCAL xRet

   FERASE( "test.dbf" )
   FERASE( "test_2.dbf" )


   hDbfs := hb_hash()
   s_hMutex := hb_mutexCreate()

   hDbfs[ "test" ] := hb_hash()
   hDbfs[ "test" ][ "wa" ] := 100
   hDbfs[ "test" ] [ "struct" ] :=  {;
                 { "ID", "C",   2, 0 }, ;
                 { "NAZ", "C",  20, 0 } }
   hDbfs[ "test" ][ "name" ] := "test.dbf"
   hDbfs[ "test" ][ "created" ] := .F.

   hDbfs[ "test_2" ] := hb_hash()
   hDbfs[ "test_2" ][ "wa" ] := 101
   hDbfs[ "test_2" ] [ "struct" ] :=  {;
                 { "ID", "C",  40, 0 }, ;
                 { "NAZ", "C",  40, 0 } }

   hDbfs[ "test_2" ][ "name" ] := "test_2.dbf"
   hDbfs[ "test_2" ][ "created" ] := .F.

   hb_threadStart( @thread_my_create(), @hdbfs[ "test" ], @xRet )
   hb_threadStart( @thread_my_create(), @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), @hdbfs[ "test" ], @xRet )
   my_use( hDbfs[ "test" ])
  
   append blank
   replace id with "11", naz with "test"
   show_recs( "test" )
 
   my_use( hDbfs[ "test_2" ])
   append blank
   replace id with "2222", naz with "test22"
   append blank
   replace id with "3333", naz with "test333"
   show_recs( "test2" )

function my_create( hDbfRec )
  
    SELECT ( hDbfRec[ "wa" ] )
    hb_mutexLock( s_hMutex )
    IF !hDbfRec[ "created" ]
        ? hDbfRec[ "name" ], "kreirana !"
        dbCreate( hDbfRec[ "name" ], hDbfRec[ "struct" ], "DBFCDX" )
        hDbfRec[ "created" ] := .T.
    ELSE
        ? hDbfRec[ "name" ], "VEC kreirana !"
    ENDIF
    hb_mutexUnLock( s_hMutex )
    
    RETURN


function my_use ( hDbfRec )

    DO WHILE .T.
       IF !hdbfRec[ "created" ]
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


function show_recs( cTitle )

go top
? REPLICATE("-", 80)
? "DBF: " + cTitle
do while !eof()
   ? id, ",", naz
   skip
enddo
? REPLICATE("=", 80)
