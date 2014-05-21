#include "pdf_cls.ch"

#ifdef __PLATFORM__LINUX
   static s_constant_width_font_bold := "Courier-Bold"
   static s_font_bold := "Helvetica-Bold"
   static s_font_bold_2 := "Times-Bold"
#else
   static s_constant_width_font_bold := "Courier-Bold"
   static s_font_bold := "Helvetica-Bold"
   static s_font_bold_2 := "Times-Bold"
#endif

FUNCTION Main()

   LOCAL oPDF


   SET EPOCH TO 1960
   SET DATE TO GERMAN
   REQUEST HB_CODEPAGE_SLWIN
   REQUEST HB_CODEPAGE_SLISO

   hb_cdpSelect( "SLWIN" )
   hb_SetTermCP( "SLISO" )
 
   oPDF := PDFClass():New()
   oPDF:cHeader := hb_Utf8ToStr( "PDFClass bosnian diacritics: šŠ ćĆ đĐ žŽ" )

   oPDF:SetType( PDF_PORTRAIT )
   oPDF:Begin()
   InvoiceMask( oPDF )
   oPDF:End()

   RETURN

FUNCTION InvoiceMask( oPDF )

   LOCAL x

   oPDF:PageHeader()

   oPDF:DrawText( 2, 67, 'Račun', , 14, s_font_bold )

   // Salesperson, Invoice date
   oPDF:DrawRectangle( 5.4, 60, 35, 1, , 3, { 0.75, 0.75, 0.75 } )   // Shaded Heading
   oPDF:DrawText( 6, 61, 'Prodavač', '@!', 7, s_constant_width_font_bold )
   oPDF:DrawText( 6, 81, 'Datum Računa', '@!', 7, s_constant_width_font_bold )
   oPDF:DrawRectangle( 5.4, 60, 35, 2.2 ) // Whole Box

   oPDF:DrawLine( 5.4, 77, 7.1, 77 )    // Vertical Line
   oPDF:DrawText( 8.5,  1, 'Fatkturisano',     '@!', 6, , 270 )
   oPDF:DrawText( 8.5, 52, 'Isporučeno',     '@!', 6, , 270 )
   oPDF:DrawText( 62, 0, '05/2014',     '@!', 6 )

   // Draw Masks
   oPDF:DrawRectangle( 15.35, 0, 95, 1, , 3, { 0.75, 0.75, 0.75 } )    // Header
   oPDF:DrawRectangle( 17.35, 0, 95, 1, , 3, { 0.75, 0.75, 0.75 } )    // Detail

   FOR x = 1 TO 32 STEP 2
      oPDF:DrawRectangle( x + 18.3, 0, 95, 1.1, , 3, { 0.95, 0.95, 0.95 } )
   NEXT x

   // Box around header and details
   oPDF:DrawRectangle( 15.35, 00, 95, 55 )
   // Header Columns
   oPDF:DrawLine( 15.35, 09, 17.3, 09 )
   oPDF:DrawLine( 15.35, 21, 17.3, 21 )
   oPDF:DrawLine( 15.35, 39, 17.3, 39 )
   oPDF:DrawLine( 15.35, 55, 17.3, 55 )
   oPDF:DrawLine( 15.35, 72, 17.3, 72 )
 

   oPDF:DrawText( 16, 01, 'Račun br.',     '@!', 7, s_constant_width_font_bold )
   oPDF:DrawText( 16, 11, 'Datum Isporuke',  '@!', 5, s_constant_width_font_bold )
   oPDF:DrawText( 16, 23, 'Shipped Via',     '@!', 7, s_constant_width_font_bold )
   oPDF:DrawText( 16, 40, 'F.O.B. Point',    '@!', 7, s_constant_width_font_bold )
   oPDF:DrawText( 16, 59, 'Terms',           '@!', 7, s_constant_width_font_bold )
   oPDF:DrawText( 16, 75, 'P.O. Number',     '@!', 7, s_constant_width_font_bold )

   // Detail columns
   oPDF:DrawLine( 17.35, 06, 51.3, 06 )
   oPDF:DrawLine( 17.35, 12, 51.3, 12 )
   oPDF:DrawLine( 17.35, 18, 51.3, 18 )
   oPDF:DrawLine( 17.35, 30, 51.3, 30 )
   oPDF:DrawLine( 17.35, 75, 51.3, 75 )
   oPDF:DrawLine( 17.35, 85, 51.3, 85 )
   oPDF:DrawText( 18, 01, 'Kol. Nar',    '@!', 5, s_font_bold_2 )
   oPDF:DrawText( 18, 07, 'Kol. Isp',  '@!', 5, s_font_bold_2 )
   oPDF:DrawText( 18, 13, 'Kol B/O',         '@!', 5, s_constant_width_font_bold )
   oPDF:DrawText( 18, 20, 'Product Code',    '@!', 7, s_constant_width_font_bold )
   oPDF:DrawText( 18, 46, 'Trgovačko dobro',     '@!', 7, s_constant_width_font_bold )
   oPDF:DrawText( 18, 78, 'Cijena',      '@!', 7, s_constant_width_font_bold )
   oPDF:DrawText( 18, 89, 'Iznos',          '@!', 7, s_constant_width_font_bold )

   // Trailer
   oPDF:DrawLine( 51.3, 0, 51.3, 95 )
   oPDF:DrawText( 52, 1, 'Komentari',     '@!', 6 ) // , , 270 )
   oPDF:DrawRectangle( 51.4, 65, 20, 8, , 3, { 0.75, 0.75, 0.75 } ) // Total Box
   oPDF:DrawText( 52, 75, 'Uk.bez PDV',   '@!', 7, s_constant_width_font_bold )
   oPDF:DrawText( 53, 75, 'PDV %',     '@!', 7, s_constant_width_font_bold )
   oPDF:DrawText( 54, 75, 'PDV Inos',  '@!', 7, s_constant_width_font_bold )
   oPDF:DrawText( 56, 75, 'Ukupno:',   '@!', 10, s_font_bold )

   RETURN NIL
