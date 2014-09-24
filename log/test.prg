#include "hblog.ch"

FUNCTION Main()

   LOCAL nLogStyle

   ? "test log funkcije"
   ?

   hb_InitStandardLog()
   hb_StandardLogAdd( HB_LogFile():New( 1, "test_log.txt", 1000000 , 50 ) )


   hb_StandardLogAdd( HB_LogConsole():New( 1 ))


   //nLogStyle :=  HB_LOG_ST_DATE  + HB_LOG_ST_TIME  + HB_LOG_ST_SECS + HB_LOG_ST_LEVEL  + HB_LOG_ST_ISODATE + HB_LOG_ST_NAME

   //hb_SetStandardLogStyle( nLogStyle  )


   hb_StandardLogName( "test_log" )

   hb_OpenStandardLog()
   hb_StandardLog( hb_BldLogMsg( 100 ), 1 )

   ? "kraj"

   hb_CloseStandardLog()

   RETURN .T.
