/*
 * $Id: mttest02.prg 14676 2010-06-03 16:23:36Z vszakats $
 */

/*
 * Harbour Project source code:
 *    demonstration/test code for using QUIT commands and ALWAYS statements
 *    execution. Child thread uses QUIT before main one.
 *
 * Copyright 2008 Przemyslaw Czerpak <druzus / at / priv.onet.pl>
 * www - http://harbour-project.org
 *
 */

#ifdef __XHARBOUR__
   #xtranslate hb_threadStart( <x,...> ) => StartThread( <x> )
   #xtranslate hb_threadJoin( <x,...> ) => JoinThread( <x> )
   #command begin sequence   => try
   #command always           => finally
#endif

proc main()
   local thID, i
   ? Version()
   ? "Main start"
   thID := hb_threadStart( @thFunc(), "A", "B", "C" )
   ? "Thread ID:", thID
   ? "==================="
   ?
   begin sequence
      for i := 1 to 20
         ?? "M"
         hb_idleSleep(0.40)
      next
      ? "==================="
      ? "Main QUIT"
      Alert ("Main Quit" )
      quit
   always
      ? "Main ALWAYS section"
      ?
   endsequence
   ? "End of main"
return

proc thFunc( ... )
   local i
   ? "Thread begin"
   ? "Parameters:"
   aeval( hb_aParams(), {|x|qqout("",x)})
   ?
   //Alert( "th Func start" )
   set console off
   begin sequence
      for i:=1 to 20
         hb_idleSleep(0.10)
         if i > 10
              set console on
              ?? "T"
         else
              ?? "t"
         endif
         if i == 20
            ? "Thread QUIT"
            quit
         endif
      next
   always
      ? "Thread ALWAYS section"
      ?
   endsequence
   ? "Thread end"
   ?
return

exit proc p
? "I'm EXIT procedure"
