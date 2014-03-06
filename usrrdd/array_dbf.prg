REQUEST ARRAYRDD

procedure main()
 
  LOCAL aStruct

   Set( _SET_DATEFORMAT, "yyyy-mm-dd" )
   SET DELETED OFF
   CLS

/*
   ? "Create a new dbf in memory using dbCreate() command"
   aStruct := { ;
      { "NAME"     , "C", 40, 0 }, ;
      { "ADDRESS"  , "C", 40, 0 }, ;
      { "BIRTHDAY" , "D",  8, 0 }, ;
      { "AGE"      , "N",  3, 0 } }
*/

/* 

   ipak je bolje importovati kao string pa ih onda transformisati u numericke varijable
   radi "," => "." decimalnih delimitera

   aStruct := { ;
     { "ID",  "C", 10, 0 }, ;
     { "SIRINA", "N", 10, 4 }, ;
     { "DEBLJINA", "N", 10, 4 }, ;
     { "KOLICINA", "N", 10, 0 } ;
   }
*/

   aStruct := { ;
     { "ID",  "C", 10, 0 }, ;
     { "SIRINA", "C", 10, 0 }, ;
     { "DEBLJINA", "C", 10, 0 }, ;
     { "KOLICINA", "C", 10, 0 } ;
   }
*
   ? "Create it"
   dbCreate( "arrtest.dbf", aStruct, "ARRAYRDD" )


  USE arrtest.dbf VIA "ARRAYRDD"

  APPEND FROM rnal.csv DELIMITED

  browse()

return
