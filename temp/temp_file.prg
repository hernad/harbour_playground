PROCEDURE Main

LOCAL tmpHandler, tmpFileName

tmpHandler := hb_FTempCreateEx( @tmpFileName, , , ".txt" )
FWrite( tmpHandler, "line 0" +  hb_eol() )
FWrite( tmpHandler, "line 1" +  hb_eol() )
FWrite( tmpHandler, "line 2" +  hb_eol() )
FWrite( tmpHandler, "line 3" +  hb_eol() )

FClose( tmpHandler )
         
? tmpFileName


cmd := 'bash -c "cat  ' + tmpFileName  + ' && read"'

? cmd
?
inkey(0)
?
?

hb_run( cmd )
   
FErase( tmpFileName )


