{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{let content_object=fetch( content, object, hash( object_id, $browse.content.object_id ) )}
<div class="maincontentheader">
<h1>
    {'Choose the node to exchange for %objectname'
     |i18n( 'design/standard/content/view',, hash( '%objectname', $content_object.name|wash ) )}
</h1>
</div>

<p>
    {"Please choose which node you want to exchange %objectname with.

    Select the node then click the %buttonname button.
    Using the recent and bookmark items for quick placement is also possible.
    Click on placement names to change the browse listing."
    |i18n( 'design/standard/content/view',,
           hash( '%objectname',$content_object.name|wash,
                 '%buttonname','Select'|i18n('design/standard/content/view' ) ) )
    |nl2br}
</p>
{/let}