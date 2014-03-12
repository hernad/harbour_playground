#include "hbapierr.h"
#include "hbapiitm.h"

//#include "cfunc.h"
struct c_struct {
  int a;
  int b;
};

//typedef c_struct c_struct_t;


HB_FUNC( GET_CSTRUCT )
{

   struct c_struct* var;

   var = (struct c_struct *) malloc( sizeof(struct c_struct) );

   var->a = 10000;
   var->b = 2000;

   hb_retptr( var );

}


HB_FUNC( PRINT_CSTRUCT )
{

   struct c_struct* pVar;
   
   pVar = (struct c_struct *)  hb_parptr(1);

   printf("a=%d, b=%d\n", pVar->a, pVar->b); 

}


HB_FUNC( PRINT_CSTRUCT_A )
{

PHB_ITEM pArray = hb_param( 1, HB_IT_ARRAY );

PHB_ITEM pItem = hb_itemArrayGet( pArray, 1 );
PHB_ITEM pItem2 = hb_itemArrayGet( pArray, 2 );

struct c_struct *pVar = (struct c_struct *) hb_itemGetPtr( pItem );

printf("array clan 1: a=%d, b=%d\n", pVar->a, pVar->b); 

printf("array clan 2: %s\n", (char *) hb_itemGetCPtr( pItem2 ));


}
