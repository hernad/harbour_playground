/*
 * $Id: wx_ImageList.cpp 660 2010-11-04 04:18:08Z tfonrouge $
 */

/*
    wxHarbour: a portable GUI for [x]Harbour Copyright (C) 2009 Teo Fonrouge

    This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

    (C) 2009 Teo Fonrouge <teo@windtelsoft.com>
*/

/*
    wx_ImageList
    Teo. Mexico 2009
*/

#include "wx/wx.h"
#include "wxh.h"

#include "wxbase/wx_ImageList.h"

/*
    ~wx_ImageList
    Teo. Mexico 2009
*/
wx_ImageList::~wx_ImageList()
{
    xho_itemListDel_XHO( this );
}

/*
    New
    Teo. Mexico 2009
*/
HB_FUNC( WXIMAGELIST_NEW )
{
    xho_ObjParams objParams = xho_ObjParams( NULL );

    wx_ImageList* imageList = new wx_ImageList();

    objParams.Return( imageList );
}

/*
    Add
    Teo. Mexico 2009
*/
// HB_FUNC( WXIMAGELIST_ADD )
// {
//   wxImageList* imageList = (wxImageList *) xho_itemListGet_XHO( hb_stackSelfItem() );
//
//   if( imageList )
//   {
//     imageList->Add();
//   }
// }
