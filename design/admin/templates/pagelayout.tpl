<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="no" lang="no">

<head>
{include uri='design:page_head.tpl'}

{* cache-block keys=array('navigation_tabs',$navigation_part.identifier,$current_user.contentobject_id) *}
{* Cache header for each navigation part *}

    <link rel="stylesheet" type="text/css" href={'stylesheets/core.css'|ezdesign} />
    <link rel="stylesheet" type="text/css" href={'stylesheets/site.css'|ezdesign} />
    <link rel="stylesheet" type="text/css" href={'stylesheets/debug.css'|ezdesign} />

    <script language="JavaScript" src={"javascript/tools/ezjsselection.js"|ezdesign}></script>
{literal}
<!--[if IE]>
<style>
div#leftmenu div.box-bc, div#rightmenu div.box-bc { border-bottom: 1px solid #bfbeb6; /* Strange IE bug fix */ }
div#contentstructure { overflow-x: auto; overflow-y: hidden; } /* hide vertical scrollbar in IE */
div.menu-block li { width: 19%; } /* Avoid width bug in IE */
div.notranslations li { width: 24%; } /* Avoid width bug in IE */
div.context-user div.menu-block li { width: 14%; } /* Avoid width bug in IE */
input.button, input.button-disabled { padding: 0 0.5em 0 0.5em; overflow: visible; }
input.box, textarea.box { width: 99%; }
div#search p.select { margin-top: 0; }
div#search p.advanced { margin-top: 0.3em; }
</style>
<![endif]-->
<!--[if lt IE 6.0]>
<style>
div#maincontent div.context-block { width: 100%; } /* Avoid width bug in IE 5.5 */
div#maincontent div#maincontent-design { width: 99%; } /* Avoid width bug in IE 5.5 */
</style>
<![endif]-->
<!--[if IE 6.0]>
<style>
div#maincontent div.box-bc { border-bottom: 1px solid #bfbfb7; /* Strange IE bug fix */ }
div#leftmenu-design { margin: 0.5em 4px 0.5em 0.5em; }
</style>
<![endif]-->
{/literal}

    {section show=and( or( eq( $navigation_part.identifier, 'ezcontentnavigationpart' ),
                           eq( $navigation_part.identifier, 'ezmedianavigationpart' ),
                           eq( $navigation_part.identifier, 'ezusernavigationpart' ) ),
                       ezpreference( 'admin_left_menu_width' )|gt( 0 ) )}
<style type="text/css">
div#leftmenu {ldelim} width: {ezpreference( 'admin_left_menu_width' )}em; {rdelim}
div#maincontent {ldelim} margin-left: {sum( ezpreference( 'admin_left_menu_width' ), 0.5 )}em; {rdelim}
</style>
{/section}

</head>

<body>

<div id="allcontent">
<div id="header">
<div id="header-design">

<div id="logo">
<a href="/"><img src={'ezpublish-logo-200x40.gif'|ezimage} width="200" height="40" alt="eZ publish" border="0" /></a>
<p>version 3.5 - beta</p>
</div>

{* --- Search ---*}
<div id="search">
<form action={'/content/search/'|ezurl} method="get">

{section show=eq( $ui_context, 'edit' )}
    <input id="searchtext" name="SearchText" type="text" size="20" value="{section show=is_set( $search_text )}{$search_text|wash}{/section}" disabled="disabled" />
    <input id="searchbutton" class="button-disabled" name="SearchButton" type="submit" value="{'Search'|i18n( 'design/admin/pagelayout' )}" disabled="disabled" />
{section-else}
    <input id="searchtext" name="SearchText" type="text" size="20" value="{section show=is_set( $search_text )}{$search_text|wash}{/section}" />
    <input id="searchbutton" class="button" name="SearchButton" type="submit" value="{'Search'|i18n( 'design/admin/pagelayout' )}" />
    {literal}
    <script language="JavaScript" type="text/javascript">
    <!--
        window.onload=function()
        {
            document.getElementById('searchtext').focus();
            document.getElementById('searchtext').select();
        }
    -->
    </script>
    {/literal}
{/section}
    <p class="select">
    {let disabled=false()
         nd=1
         left_checked=true()
         current_loc=true()}
    {section show=eq($ui_context,'edit')}
        {set disabled=true()}
    {section-else}
        {section show=is_set($module_result.node_id)}
            {set nd=$module_result.node_id}
        {section-else}
            {section show=is_set($search_subtree_array)}
                {section show=count($search_subtree_array)|eq(1)}
                    {section show=$search_subtree_array.0|ne(1)}
                        {set nd=$search_subtree_array.0}
                        {set left_checked=false()}
                    {section-else}
                        {set disabled=true()}
                    {/section}
                    {set current_loc=false()}
                {section-else}
                    {set disabled=true()}
                {/section}
            {section-else}
                {set disabled=true()}
            {/section}
        {/section}
    {/section}
    <label{section show=$disabled} class="disabled"{/section}><input type="radio" name="SubTreeArray" value="1" checked="checked"{section show=$disabled} disabled="disabled"{section-else} title="{'Search within the entire site.'|i18n( 'design/admin/pagelayout' )}"{/section} />{'All content'|i18n( 'design/admin/pagelayout' )}</label>
    <label{section show=$disabled} class="disabled"{/section}><input type="radio" name="SubTreeArray" value="{$nd}"{section show=$disabled} disabled="disabled"{section-else} title="{'Search only from within the current location.'|i18n( 'design/admin/pagelayout' )}"{/section} />{section show=$current_loc}{'Current location'|i18n( 'design/admin/pagelayout' )}{section-else}{'The same location'|i18n( 'design/admin/pagelayout' )}{/section}</label>
    {/let}
    </p>
    <p class="advanced">
    {section show=eq( $ui_context, 'edit' )}
    <span class="disabled">{'Advanced'|i18n( 'design/admin/pagelayout' )}</span>
    {section-else}
        <a href={'/content/advancedsearch'|ezurl} title="{'Advanced search.'|i18n( 'design/admin/pagelayout' )}">{'Advanced'|i18n( 'design/admin/pagelayout' )}</a>
    {/section}
    </p>
</form>
</div>

<div class="break"></div>

</div>
</div>

<hr class="hide" />

<div id="topmenu">
<div id="topmenu-design">

<h3 class="hide">Top menu</h3>

{* Browse mode... *}
{section show=eq( $ui_context, 'browse' )}
<ul>
    {* Content menu *}
    {section show=$browse.top_level_nodes|contains( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )}
    {include uri='design:page_menuheadenabled.tpl' menu_text='Content structure'|i18n( 'design/admin/pagelayout' ) menu_url=concat( '/content/browse/', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) menu_item_order='first'}
    {section-else}
    {include uri='design:page_menuheadgray.tpl' menu_text='Content structure'|i18n( 'design/admin/pagelayout' ) menu_item_order='first'}
    {/section}

    {* Media menu *}
    {section show=$browse.top_level_nodes|contains( ezini( 'NodeSettings', 'MediaRootNode', 'content.ini' ) )}
    {include uri='design:page_menuheadenabled.tpl' menu_text='Media library'|i18n( 'design/admin/pagelayout' ) menu_url=concat( '/content/browse/', ezini('NodeSettings','MediaRootNode','content.ini' ) ) menu_item_order='middle'}
    {section-else}
    {include uri='design:page_menuheadgray.tpl' menu_text='Media library'|i18n( 'design/admin/pagelayout' ) menu_item_order='middle'}
    {/section}

    {* Users menu *}
    {section show=$browse.top_level_nodes|contains( ezini( 'NodeSettings', 'UserRootNode', 'content.ini' ) )}
    {include uri='design:page_menuheadenabled.tpl' menu_text='User accounts'|i18n( 'design/admin/pagelayout' ) menu_url=concat( '/content/browse/', ezini( 'NodeSettings', 'UserRootNode', 'content.ini' ) ) menu_item_order='middle'}
    {section-else}
    {include uri='design:page_menuheadgray.tpl' menu_text='User accounts'|i18n( 'design/admin/pagelayout' ) menu_item_order='middle'}
    {/section}

    {* Shop menu *}
    {include uri='design:page_menuheadgray.tpl' menu_text='Webshop'|i18n( 'design/admin/pagelayout' ) menu_item_order='middle'}

    {* Set up menu *}
    {include uri='design:page_menuheadgray.tpl' menu_text='Setup'|i18n( 'design/admin/pagelayout' ) menu_item_order='middle'}

    {* Design menu *}
    {include uri='design:page_menuheadgray.tpl' menu_text='Design'|i18n( 'design/admin/pagelayout' ) menu_item_order='middle'}

    {* Personal *}
    {include uri='design:page_menuheadgray.tpl' menu_text='My account'|i18n( 'design/admin/pagelayout' ) menu_item_order='last'}
</ul>

{* NOT Browse mode... *}
{section-else}
<ul>
    {* Content menu *}
    {section show=ne( $ui_context, 'edit' )}
        {section show=eq($navigation_part.identifier,'ezcontentnavigationpart')}
        {include uri='design:page_menuheadselected.tpl' menu_text='Content structure'|i18n( 'design/admin/pagelayout' ) menu_url=concat( '/content/view/full/', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) menu_item_order='selected-first'}
        {section-else}
        {include uri='design:page_menuheadenabled.tpl' menu_text='Content structure'|i18n( 'design/admin/pagelayout' ) menu_url=concat( '/content/view/full/', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) menu_item_order='first'}
        {/section}
    {section-else}
        {include uri='design:page_menuheadgray.tpl' menu_text='Content structure'|i18n( 'design/admin/pagelayout' ) menu_url=concat('/content/view/full/',ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )  menu_item_order='first'}
    {/section}

    {* Media menu *}
    {section show=ne( $ui_context, 'edit' )}
        {section show=eq($navigation_part.identifier,'ezmedianavigationpart')}
        {include uri='design:page_menuheadselected.tpl' menu_text='Media library'|i18n( 'design/admin/pagelayout' ) menu_url=concat( '/content/view/full/', ezini( 'NodeSettings', 'MediaRootNode', 'content.ini' ) )  menu_item_order='selected-middle'}
        {section-else}
        {include uri='design:page_menuheadenabled.tpl' menu_text='Media library'|i18n( 'design/admin/pagelayout' ) menu_url=concat( '/content/view/full/', ezini( 'NodeSettings', 'MediaRootNode', 'content.ini' ) ) menu_item_order='middle'}
        {/section}
    {section-else}
        {include uri='design:page_menuheadgray.tpl' menu_text='Media library'|i18n( 'design/admin/pagelayout' ) menu_url=concat( '/content/view/full/', ezini( 'NodeSettings', 'MediaRootNode', 'content.ini' ) ) menu_item_order='middle'}
    {/section}

    {* Users menu *}
    {section show=ne( $ui_context, 'edit' )}
        {section show=eq($navigation_part.identifier,'ezusernavigationpart')}
        {include uri='design:page_menuheadselected.tpl' menu_text='User accounts'|i18n( 'design/admin/pagelayout' ) menu_url='/content/view/full/5/' menu_item_order='selected-middle'}
        {section-else}
        {include uri='design:page_menuheadenabled.tpl' menu_text='User accounts'|i18n( 'design/admin/pagelayout' ) menu_url='/content/view/full/5/' menu_item_order='middle'}
        {/section}
    {section-else}
        {include uri='design:page_menuheadgray.tpl' menu_text='User accounts'|i18n( 'design/admin/pagelayout' ) menu_url='/content/view/full/5/' menu_item_order='middle'}
    {/section}

    {* Shop menu *}
    {section show=ne( $ui_context, 'edit' )}
        {section show=eq($navigation_part.identifier,'ezshopnavigationpart')}
        {include uri='design:page_menuheadselected.tpl' menu_text='Webshop'|i18n( 'design/admin/pagelayout' ) menu_url='/shop/orderlist/' menu_item_order='selected-middle'}
        {section-else}
        {include uri='design:page_menuheadenabled.tpl' menu_text='Webshop'|i18n( 'design/admin/pagelayout' ) menu_url='/shop/orderlist/' menu_item_order='middle'}
        {/section}
    {section-else}
        {include uri='design:page_menuheadgray.tpl' menu_text='Webshop'|i18n( 'design/admin/pagelayout' ) menu_url='/shop/orderlist/' menu_item_order='middle'}
    {/section}

    {* Design menu *}
    {section show=ne( $ui_context, 'edit' )}
        {section show=eq($navigation_part.identifier,'ezdesignnavigationpart')}
        {include uri='design:page_menuheadselected.tpl' menu_text='Design'|i18n( 'design/admin/pagelayout' ) menu_url='/design/menuconfig' menu_item_order='selected-middle'}
        {section-else}
        {include uri='design:page_menuheadenabled.tpl' menu_text='Design'|i18n( 'design/admin/pagelayout' ) menu_url='/design/menuconfig' menu_item_order='middle'}
        {/section}
    {section-else}
        {include uri='design:page_menuheadgray.tpl' menu_text='Design'|i18n( 'design/admin/pagelayout' ) menu_url='/design/menuconfig' menu_item_order='middle'}
    {/section}

    {* Set up menu *}
    {section show=ne( $ui_context, 'edit' )}
        {section show=eq($navigation_part.identifier,'ezsetupnavigationpart')}
        {include uri='design:page_menuheadselected.tpl' menu_text='Setup'|i18n( 'design/admin/pagelayout' ) menu_url='/setup/cache' menu_item_order='selected-middle'}
        {section-else}
        {include uri='design:page_menuheadenabled.tpl' menu_text='Setup'|i18n( 'design/admin/pagelayout' ) menu_url='/setup/cache' menu_item_order='middle'}
        {/section}
    {section-else}
        {include uri='design:page_menuheadgray.tpl' menu_text='Setup'|i18n( 'design/admin/pagelayout' ) menu_url='/setup/cache' menu_item_order='middle'}
    {/section}

    {* Personal *}
    {section show=ne( $ui_context, 'edit' )}
        {section show=eq($navigation_part.identifier,'ezmynavigationpart')}
        {include uri='design:page_menuheadselected.tpl' menu_text='My account'|i18n( 'design/admin/pagelayout' ) menu_url='/content/draft/' menu_item_order='selected-last'}
        {section-else}
        {include uri='design:page_menuheadenabled.tpl' menu_text='My account'|i18n( 'design/admin/pagelayout' ) menu_url='/content/draft/' menu_item_order='last'}
        {/section}
    {section-else}
        {include uri='design:page_menuheadgray.tpl' menu_text='My account'|i18n( 'design/admin/pagelayout' ) menu_url='/content/draft/' menu_item_order='last'}
    {/section}

</ul>
{/section}
<div class="break"></div>
</div>
</div>

{* /cache-block *}

<hr class="hide" />


<div id="path">
<div id="path-design">

{include uri='design:page_toppath.tpl'}

</div>
</div>


<hr class="hide" />

<div id="columns">

{section show=and( eq( $ui_context, 'edit' ), eq( $ui_component, 
'content' ) )}

{section-else}
<div id="leftmenu">
<div id="leftmenu-design">

{section show=and( $ui_context|eq( 'edit' ), $ui_component|eq( 'content' ) )}
    {include uri='design:edit_menu.tpl'}
{section-else}

{section show=eq( $navigation_part.identifier, 'ezcontentnavigationpart' )}
    {include uri='design:parts/content/menu.tpl'}
{/section}

{section show=eq( $navigation_part.identifier, 'ezmedianavigationpart' )}
    {include uri='design:parts/media/menu.tpl'}
{/section}

{section show=eq( $navigation_part.identifier, 'ezshopnavigationpart' )}
    {include uri='design:parts/shop/menu.tpl'}
{/section}

{section show=eq( $navigation_part.identifier, 'ezusernavigationpart' )}
    {include uri='design:parts/user/menu.tpl'}
{/section}

{section show=eq( $navigation_part.identifier, 'ezdesignnavigationpart' )}
    {include uri='design:parts/design/menu.tpl'}
{/section}

{section show=eq( $navigation_part.identifier, 'ezsetupnavigationpart' )}
    {include uri='design:parts/setup/menu.tpl'}
{/section}

{section show=eq( $navigation_part.identifier, 'ezmynavigationpart' )}
    {include uri='design:parts/my/menu.tpl'}
{/section}

{/section}

</div>
</div>

<hr class="hide" />

{/section}

<div id="rightmenu">
<div id="rightmenu-design">

<h3 class="hide">Right</h3>
{* --- Current user ---*}
<div id="currentuser">

<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h4>{'Current user'|i18n( 'design/admin/pagelayout' )}</h4>

</div></div></div></div></div></div>

<div class="box-ml"><div class="box-mr"><div class="box-content">

<p><img src={'current-user.gif'|ezimage} height="22" width="22" alt="" style="align: left; vertical-align: middle;" /> {$current_user.contentobject.name|wash}</p>

<ul>
{let basket=fetch( shop, basket )}

{section show=ne( $ui_context, 'edit' )}
    <li><a href={concat( '/content/edit/',  $current_user.contentobject_id, '/' )|ezurl} title="{'Change name, e-mail, password, etc.'|i18n( 'design/admin/pagelayout' )}">{'Change information'|i18n( 'design/admin/pagelayout' )}</a></li>
    <li><a href={concat( '/user/password/', $current_user.contentobject_id )|ezurl} title="{'Change password for <%username>.'|i18n( 'design/admin/pagelayout',, hash( '%username', $current_user.contentobject.name ) )|wash}">{'Change password'|i18n( 'design/admin/pagelayout' )}</a></li>

{section show=$basket.is_empty|not}
<li><a href={'shop/basket'|ezurl} title="{'There are %basket_count items in the shopping basket.'|i18n( 'design/admin/pagelayout',, hash( '%basket_count', $basket.items|count ) )}">{'Shopping basket (%basket_count)'|i18n( 'design/admin/pagelayout',, hash( '%basket_count', $basket.items|count ) )}</a></li>
{/section}

        <li><a href={'/user/logout'|ezurl} title="{'Logout from the system.'|i18n( 'design/admin/pagelayout' )}">{'Logout'|i18n( 'design/admin/pagelayout' )}</a></li>
{section-else}
    <li><span class="disabled">{'Change user info'|i18n( 'design/admin/pagelayout' )}</span></li>
    <li><span class="disabled">{'Change password'|i18n( 'design/admin/pagelayout' )}</span></li>
    {section show=$basket.is_empty|not}
    <li><span class="disabled">{'Shopping basket (%basket_count)'|i18n( 'design/admin/pagelayout',, hash( '%basket_count', $basket.items|count ) )}</span></li>
    {/section}
    <li><span class="disabled">{'Logout'|i18n( 'design/admin/pagelayout' )}</span></li>
{/section}
{/let}
</ul>

</div></div></div>

</div>

{* --- Bookmarks --- *}
<div id="bookmarks">

<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr">

{section show=ezpreference( 'admin_bookmark_menu' )}
    {section show=ne( $ui_context, 'edit' )}
     <h4><a class="showhide" href={'/user/preferences/set/admin_bookmark_menu/0'|ezurl} title="{'Hide bookmarks.'|i18n( 'design/admin/pagelayout' )}"><span class="bracket">[</span>-<span class="bracket">]</span></a> <a href={'/content/bookmark/'|ezurl} title="{'Manage your personal bookmarks.'|i18n( 'design/admin/pagelayout' )}">{'Bookmarks'|i18n( 'design/admin/pagelayout' )}</a></h4>
    {section-else}
     <h4><span class="disabled">{'Bookmarks'|i18n( 'design/admin/pagelayout' )}</span> <span class="disabled openclose"><span class="bracket">[</span>-<span class="bracket">]</span></span></h4>
    {/section}

</div></div></div></div>

<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">

<ul>
{let bookmark_list=fetch( content, bookmarks )}
    {section var=Bookmarks loop=$bookmark_list}
        {section show=ne( $ui_context, 'edit' )}
         <li>
     
     <a href="#" onclick="ezpopmenu_showTopLevel( event, 'BookmarkMenu', ez_createAArray( new Array( '%nodeID%', '{$Bookmarks.item.node_id}' , '%objectID%', '{$Bookmarks.item.contentobject_id}' ) ) , '{$Bookmarks.item.name|shorten(18)|wash(javascript)}'); return false;">{$Bookmarks.item.node.object.content_class.identifier|class_icon( small, $Bookmarks.item.node.object.content_class.name )}</a>&nbsp;<a href={$Bookmarks.item.node.url_alias|ezurl}>{$Bookmarks.item.node.name|wash}</a></li>
     {section-else}
         <li>{$Bookmarks.item.node.object.content_class.identifier|class_icon( small, $Bookmarks.item.node.object.content_class.name )}&nbsp;<span class="disabled">{$Bookmarks.item.node.name|wash}</span></li>
         {/section}
    {/section}
{/let}
</ul>

{section-else}
    {section show=ne( $ui_context,'edit' )}
    <h4><a class="showhide" href={'/user/preferences/set/admin_bookmark_menu/1'|ezurl} title="{'Show bookmarks.'|i18n( 'design/admin/pagelayout' )}"><span class="bracket">[</span>+<span class="bracket">]</span></a> <a href={'/content/bookmark/'|ezurl}>{'Bookmarks'|i18n( 'design/admin/pagelayout' )}</a></h4>
    {section-else}
    <h4><span class="disabled">{'Bookmarks'|i18n( 'design/admin/pagelayout' )}</span> <span class="disabled openclose"><span class="bracket">[</span>+<span class="bracket">]</span></span></h4>
    {/section}
</div></div></div></div>

<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">
{/section}

<div class="block">
{* Show "Add to bookmarks" button if we're viewing an actual node. *}
{section show=and( is_set( $node.node_id ), $ui_context|ne( 'edit' ) )}
<form method="post" action={'content/action'|ezurl}>
<input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
<input class="button" type="submit" name="ActionAddToBookmarks" value="{'Add to bookmarks'|i18n( 'design/admin/pagelayout' )}" title="{'Add the current item to your bookmarks.'|i18n( 'design/admin/pagelayout' )}" />
</form>
{section-else}
<form method="post" action={'content/action'|ezurl}>
<input class="button-disabled" type="submit" name="" value="{'Add to bookmarks'|i18n( 'design/admin/pagelayout' )}" disabled="disabled" />
</form>
{/section}
</div>

</div></div></div></div></div></div>

</div>

</div>
</div>

<hr class="hide" />

{section show=and( eq( $ui_context, 'edit' ), eq( $ui_component, 'content' ) )}

{* Main area START *}

{include uri='design:page_mainarea.tpl'}

{* Main area END *}

{section-else}

<div id="maincontent"><div id="fix">
<div id="maincontent-design">
<!-- Maincontent START -->
{* Main area START *}

{include uri='design:page_mainarea.tpl'}

{* Main area END *}

<!-- Maincontent END -->
</div>
<div class="break"></div>
</div></div>

{/section}

<div class="break"></div>
</div>

<hr class="hide" />

<div id="footer">
<div id="footer-design">

{include uri='design:page_copyright.tpl'}

</div>
</div>

<div class="break"></div>
</div>

{* The popup menu include must be outside all divs. It is hidden by default. *}
{include uri='design:popupmenu/popup_menu.tpl'}

</body>
</html>
