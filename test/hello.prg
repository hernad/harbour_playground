#include "inkey.ch"

#translate TEST_LINE( <x>, <result> ) => TEST_CALL( #<x>, {|| <x> }, <result> )

procedure Main(...)

local aPom
local cPom
local nPos
local pg_sql

? "hello world"

? K_ESC

? "Valtype od .f. :", VALTYPE(.f.)
for i:=1 to 10
  ? "hello world", i
next

cPom := "/home/hernad/test/DATA.DBF"

? FILEBASE(cPom), FILEEXT(cPom)

cPom := "osuban"

? FILEBASE(cPom), FILEEXT(cPom)

aPom := { { "jedan", 100 },;
          { "dva", 200 }, ;
          { "tri", 300 } ;
        }

nPos:=ASCAN(aPom,  { |x|  x[1]=="dva"} )

? "nasao sam da je 'dva' clan sa vrijednosti", aPom[nPos, 1], aPom[nPos, 2]


? "broj ulaznih parametara: ", PCount() 


pg_sql  = "{jen,dva,tri}"

? pg_sql

? pg_sql := SUBSTR(pg_sql, 2, LEN(pg_sql)-2)

_num_arr := numtoken(pg_sql, ",")

_arr := {}

for i:=1 to _num_arr
    AADD(_arr, token(pg_sql, ",", i))
next

? "_arr", LEN(_arr)
for i:=1 to LEN(_arr)
   ? _arr[i]
next

?

TEST_BEGIN("")

TEST_LINE( hb_ValToStr( 4 )                     , "         4"    )
TEST_LINE( hb_ValToStr( 4.0 / 2 )               , "         2.00" )
TEST_LINE( hb_ValToStr( "String" )              , "String"        )
TEST_LINE( hb_ValToStr( hb_SToD( "20010101" ) ) , "2001.01.01"    )
TEST_LINE( hb_ValToStr( NIL )                   , "NIL"           )
TEST_LINE( hb_ValToStr( .F. )                   , ".F."           )

TEST_LINE( hb_ValToStr( .T. )                   , ".T."           )
TEST_LINE( hb_ValToStr( .f. )                   , ".T."           )

TEST_END()
? "kraj"
?
