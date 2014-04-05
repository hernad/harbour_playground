static aDbfs

static s_hParams
static s_hMutex

static s_main_connection
static s_connection

REQUEST DBFCDX
REQUEST HB_GT_XWC
REQUEST HB_GT_XWC_DEFAULT

static s_w
static s_main_w
static s_mtx_sql
static s_sql_in_use := .F.

function init_s_params()

  s_hParams := hb_hash()
  s_hParams[ "host" ] := "localhost"
  s_hParams[ "database" ] := "f18_2014"
  s_hParams[ "user" ] := "postgres"
  s_hParams[ "password" ] := "postgres"
  s_hParams[ "port" ] := 5432
  s_hParams[ "schema" ] := "fmk"


proc main

   LOCAL xRet, params

   init_s_params()

   FERASE( "test.dbf" )
   FERASE( "test_2.dbf" )

   hDbfs := hb_hash()
   s_hMutex := hb_mutexCreate()
   s_mtx_sql := hb_mutexCreate()

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


  params := s_hParams

  s_connection :=  TPQServer():New( params[ "host" ], ;
      params[ "database" ], ;
      params[ "user" ], ;
      params[ "password" ], ;
      params[ "port" ], ;
      params[ "schema" ] )


  s_main_connection :=  TPQServer():New( params[ "host" ], ;
      params[ "database" ], ;
      params[ "user" ], ;
      params[ "password" ], ;
      params[ "port" ], ;
      params[ "schema" ] )



   s_main_w := hb_gtSelect()
   if s_w == NIL
      s_w := hb_gtCreate( "XWC" )
   endif

   ? "pritisni nesto da kreiras thread-ove"
   inkey( 0 )

   hb_threadStart( @thread_my_create(), 1,  @hdbfs[ "test" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   hb_threadStart( @thread_my_create(), 2, @hdbfs[ "test_2" ], @xRet )
   my_use( hDbfs[ "test" ])
 

   hb_gtSelect( s_main_w )

   for i:= 1 to 10
      ? "Ovo treba na osnovvvvvvvvvvvvvvvvvvvni screen", i
      show_sql_recs( s_main_connection )
   next
 
   append blank
   replace id with "11", naz with "test"
   show_recs( "test" )
 
   my_use( hDbfs[ "test_2" ])
   append blank
   replace id with "2222", naz with "test22"
   append blank
   replace id with "3333", naz with "test333"
   show_recs( "test2" )

   ? "inkey jos 10 sekundi"
   inkey( 10 )

   RETURN

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
       hb_mutexLock( s_hMutex )
       lCreated := hdbfRec[ "created" ]
       hb_mutexUnlock( s_hMutex )
       IF !lCreated
           ? hDbfRec[ "name" ], "nije kreiran, cekam ..."
           hb_idleSleep( 0.3 )
       ELSE
           EXIT
       ENDIF
    ENDDO
        
    SELECT ( hDbfRec[ "wa" ] ) 
    USE (hDbfRec[ "name" ] ) VIA "DBFCDX" EXCLUSIVE
    RETURN


function thread_screen()

  hb_gtSelect( s_w )



function thread_my_create( nOpcija, hDbfRec, xRet )

   local i, conn, oDataSet, cId
   local w

   thread_screen()
   conn := my_connection()
  
   ? "BEFORE s_mtx_sql LOCK ....", hb_valToStr( hb_threadSelf() )

   hb_mutexLock( s_mtx_sql )
 
   if !s_sql_in_use
       s_sql_in_use := .T.

      if nOpcija == 1
       insert_sql_recs( conn )

      ELSE
        show_sql_recs( conn )
      ENDIF
      
      s_sql_in_use := .F.
   ENDIF
   hb_mutexUnLock( s_mtx_sql )
   ? "AFTER s_mtx_sql UNNNLOCK ....", hb_valToStr( hb_threadSelf() )

 
   my_create( hDbfRec )
   ? "END my create in thread", nOpcija, hb_valToStr( hb_threadSelf() )
   inkey( 3 )
   ? "DEFINITIVE END my create in thread", hb_valToStr( hb_threadSelf() )
   
   RETURN


function my_connection( params )

   if params == NIL
     params = s_hParams
   endif

   return s_connection
   

FUNCTION sql_query( conn, cQuery )

   LOCAL oQuery, cMsg

   oQuery := conn:Query( cQuery + ";" )

  
   IF VALTYPE( oQuery ) != "O" .OR. ( VALTYPE( oQuery) == "O" .AND. oQuery:lError )

      cMsg := oQuery:cError

      IF !Empty( cMsg )
            Alert( cQuery + " : " + cMsg )
      ENDIF

      RETURN .F.

   ENDIF

   RETURN oQuery

function insert_sql_recs( conn )

 local i, oDataSet
 
      FOR i := 1 TO 10
        cId := PADR( ALLTRIM( hb_valToStr( RANDOM() ) ), 6)
        oDataSet := sql_query( conn, "insert into fmk.partn(id, naz) VALUES('" + cId + "','" + cId + "')" )
        ? hb_valToStr( oDataSet:lError )
      NEXT

      oDataSet := sql_query( conn, "select count(*) from fmk.partn" )
      ? oDataSet:FieldGet( 1 )
      inkey( 2 )
 
  RETURN


function show_sql_recs( conn )

    local oDataSet
     
    oDataSet := sql_query( conn, "SELECT id, 'xxxxx' from fmk.partn LIMIT 20" )
    ? hb_valToStr( oDataSet )
    DO while !oDataSet:eof()
         ? oDataSet:FieldGet( 1 ), oDataSet:FieldGet( 2 ) 
         oDataSet:skip()
         inkey( 0.5 )
    ENDDO


    oDataSet := sql_query( conn, "select count(*) from fmk.partn" )
    ? oDataSet:FieldGet( 1 )
 
    inkey( 3 )
   RETURN .T.

function show_recs( cTitle )

go top
? REPLICATE("-", 80)
? "DBF: " + cTitle
do while !eof()
   ? id, ",", naz
   skip
enddo
? REPLICATE("=", 80)
