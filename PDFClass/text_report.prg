#include "pdf_cls.ch"

static s_constant_width_font := "Courier"
static s_constant_width_font_bold := "Courier-Bold"
static s_font_bold := "Helvetica-Bold"
static s_font_bold_2 := "Times-Bold"

FUNCTION Main()

   LOCAL oPDF


   SET EPOCH TO 1960
   SET DATE TO GERMAN
   REQUEST HB_CODEPAGE_SLWIN
   REQUEST HB_CODEPAGE_SLISO

   hb_cdpSelect( "SLWIN" )
   hb_SetTermCP( "SLISO" )
 
   oPDF := PDFClass():New()
   oPDF:cFileName := "outf.txt"
   oPDF:cHeader := "PDFClass bosnian diacritics: šŠ ćĆ đĐ žŽ"


   ? "generisemo outf.txt"
   oPDF:SetType( PDF_TXT )
   oPDF:Begin()
   TextReport( oPDF )
   oPDF:End()
   
   ? "generisemo outf.pdf na osnovu outf.txt"
   oPDF := PDFClass():New()
   oPDF:SetType( PDF_PORTRAIT )
   oPDF:cFileName := "outf.pdf"
   oPDF:Begin()
   oPDF:PrnToPdf( "outf.txt" )
   oPDF:End()
 
   RETURN


FUNCTION TextReport( oPDF )

   LOCAL i, page

   FOR page := 1 to 100
     oPDF:PageHeader()
     FOR i := 1 TO 66
        oPDF:DrawText( i, i, ALLTRIM( STR( i ) ) + " žŽ " + ALLTRIM( STR( page ) ), , 10)
     NEXT
     oPDF:DrawText( 67, 0, "" )  
     oPDF:AddPage()
   NEXT
   RETURN NIL
