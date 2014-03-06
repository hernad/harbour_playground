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

  ? "pretpostavljamo da je decimalni separator ,"

   GO TOP
   ? "Preskacemo header"
   SKIP 1
  
  do while !eof()
     ? id, field->id, string_to_number(field->debljina, "BA"), string_to_number(field->sirina, "BA"),  string_to_number(field->kolicina, "BA")     
     SKIP
  enddo

return


function string_to_number(cNumber, countryCode)
local sepDec := ","
local sep1000 := "."
local cTmp

if countryCode == NIL
   countryCode = "BA"
endif

if countryCode == "EN"
   // u tom slucaju je sepDec := ".", sep1000 := ","
   // nemamo sta konvertovati
   return VAL(cNumber)
endif

cTmp := strtran(cNumber, sep1000, "")
cTmp := strtran(cNumber, sepDec, ".")

return VAL(cTmp)


