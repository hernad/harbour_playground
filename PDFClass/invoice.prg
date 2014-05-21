
FUNCTION Main()

   LOCAL oPDF

   oPDF := PDFClass():New()
   oPDF:cHeader := "PDFClass invoice test" 
   oPDF:Begin()
   InvoiceMask( oPDF )
   oPDF:End()

   RETURN

FUNCTION InvoiceMask( oPDF )

   LOCAL x

   oPDF:PageHeader()
   oPDF:DrawText( 2, 67, 'INVOICE', , 14, "Helvetica-Bold" )
   // Salesperson, Invoice date
   oPDF:DrawRetangle( 5.4, 60, 35, 01,, 3, { 0.75, 0.75, 0.75 } )   // Shaded Heading
   oPDF:DrawText( 6, 61, 'Salesperson/PKSlip No.', '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 6, 81, 'Date of Invoice', '@!', 7, "Courier-Bold" )
   oPDF:DrawRetangle( 5.4, 60, 35, 2 ) // Whole Box
   oPDF:DrawLine( 5.4, 77, 7.1, 77 )    // Vertical Line
   oPDF:DrawText( 8.5,  1, 'Bill To',     '@!', 6, , 270 )
   oPDF:DrawText( 8.5, 52, 'Ship To',     '@!', 6, , 270 )
   oPDF:DrawText( 62, 0, '05/2014',     '@!', 6 )
   // Draw Masks
   oPDF:DrawRetangle( 15.35, 0, 95, 1, , 3, { 0.75, 0.75, 0.75 } )    // Header
   oPDF:DrawRetangle( 17.35, 0, 95, 1, , 3, { 0.75, 0.75, 0.75 } )    // Detail
   FOR x = 1 TO 32 STEP 2
      oPDF:DrawRetangle( x + 18.3, 0, 95, 1.1, , 3, { 0.95, 0.95, 0.95 } )
   NEXT x
   // Box around header and details
   oPDF:DrawRetangle( 15.35, 00, 95, 55 )
   // Header Columns
   oPDF:DrawLine( 15.35, 09, 17.3, 09 )
   oPDF:DrawLine( 15.35, 21, 17.3, 21 )
   oPDF:DrawLine( 15.35, 39, 17.3, 39 )
   oPDF:DrawLine( 15.35, 55, 17.3, 55 )
   oPDF:DrawLine( 15.35, 72, 17.3, 72 )
   oPDF:DrawText( 16, 01, 'Account No.',     '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 16, 11, 'Date Shipped',    '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 16, 23, 'Shipped Via',     '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 16, 40, 'F.O.B. Point',    '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 16, 59, 'Terms',           '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 16, 75, 'P.O. Number',     '@!', 7, "Courier-Bold" )
   // Detail columns
   oPDF:DrawLine( 17.35, 06, 51.3, 06 )
   oPDF:DrawLine( 17.35, 12, 51.3, 12 )
   oPDF:DrawLine( 17.35, 18, 51.3, 18 )
   oPDF:DrawLine( 17.35, 30, 51.3, 30 )
   oPDF:DrawLine( 17.35, 75, 51.3, 75 )
   oPDF:DrawLine( 17.35, 85, 51.3, 85 )
   oPDF:DrawText( 18, 01, 'Qty Ord',         '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 18, 07, 'Qty Shp',         '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 18, 13, 'Qty B/O',         '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 18, 20, 'Product Code',    '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 18, 46, 'Description',     '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 18, 76, 'Unit Price',      '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 18, 89, 'Amount',          '@!', 7, "Courier-Bold" )
   // Trailer
   oPDF:DrawLine( 51.3, 0, 51.3, 95 )
   oPDF:DrawText( 52, 1, 'Comments',     '@!', 6 ) // , , 270 )
   oPDF:DrawRetangle( 51.4, 65, 20, 11.7, , 3, { 0.75, 0.75, 0.75 } ) // Total Box
   oPDF:DrawText( 52, 75, 'Subtotal',   '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 53, 75, 'GST/HST',    '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 54, 75, 'PST',        '@!', 7, "Courier-Bold" )
   oPDF:DrawText( 61, 75, 'Total',      '@!', 12, "Helvetica-Bold" )

   RETURN NIL
