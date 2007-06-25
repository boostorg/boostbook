<?xml version="1.0" encoding="utf-8"?>
<!--
   Copyright (c) 2007 Matias Capeletto

   Distributed under the Boost Software License, Version 1.0.
   (See accompanying file LICENSE_1_0.txt or copy at
   http://www.boost.org/LICENSE_1_0.txt)
  -->

<!--
   Templates that allows the use javascript
   Support for GroupedLinks select boxes  
  -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

<xsl:import href="relative-href.xsl"/>


   <!--
      include.javascript template

      Effects:
      Include boost javascript library
   -->

   <xsl:template name = "include.javascript.components">

      <xsl:call-template name="insert.javascript.file" >
         <xsl:with-param name="js" select="concat($javascript.root,'/main.js')" />
      </xsl:call-template>

      <xsl:call-template name="insert.javascript" >
      <xsl:with-param name="content" >
         boostscript.init( new Array(
         <xsl:if test="($chapters.select.box.show='true') or ($sections.select.box.show='true')"
         >   boostscript.nested_links,
         </xsl:if>
         <xsl:if test="$syntax.switcher.show='true'"
         >   boostscript.style_switcher,
         </xsl:if
         >   boostscript.common
         ),
         '<xsl:call-template name="href.target.relative">
             <xsl:with-param name="target" select="$javascript.root"/>
          </xsl:call-template>'
         );
      </xsl:with-param>
      </xsl:call-template>

   </xsl:template>

   <!--
      nested.links.select.box template

      Params:
         definition.xml - path to the xml definition file (it can be relative)
         element.id - string identifier, it must be unique in the page

      Effects:
         Insert a NestedLinks select box

      Requires:
         nested_links.js must be included in the page
   -->

   <xsl:template name = "nested.links.select.box">
      <xsl:param name = "id" select="generate-id()"/>
      <xsl:param name = "xml"/>
      <xsl:param name = "base.root"/>

      <div class="nested-links-select-box" id="{$id}">
      <xsl:call-template name="insert.javascript" >
      <xsl:with-param name="content" >
         boostscript.call( boostscript.nested_links, 'select_box',
            '<xsl:value-of select="$id"/>',
            '<xsl:call-template name="href.target.relative">
                 <xsl:with-param name="target" select="$xml"/>
             </xsl:call-template>',
            '<xsl:call-template name="href.target.relative">
                 <xsl:with-param name="target" select="$base.root"/>
             </xsl:call-template>');
      </xsl:with-param>
      </xsl:call-template>
      </div>
   </xsl:template>

   <xsl:template name = "include.alternate.stylesheets">
      <xsl:param name = "xml"/>
      <xsl:param name = "root"/>
      <xsl:call-template name="insert.javascript" >
      <xsl:with-param name="content" >
          boostscript.call( boostscript.style_switcher, 'include_alternate_stylesheets',
             '<xsl:call-template name = "href.target.relative">
                <xsl:with-param name = "target" select="$xml" />
            </xsl:call-template>',
             '<xsl:call-template name = "href.target.relative">
                <xsl:with-param name = "target" select="$root" />
            </xsl:call-template>'
          );
      </xsl:with-param>
      </xsl:call-template>

   </xsl:template>

   <xsl:template name="load.user.stylesheet">
      <xsl:call-template name="insert.javascript" >
      <xsl:with-param name="content" >
          boostscript.call( boostscript.style_switcher, 'load_user_stylesheet' );
      </xsl:with-param>
      </xsl:call-template>
   </xsl:template>

   <xsl:template name = "insert.style.selector">
      <xsl:param name = "xml"/>
      <xsl:param name = "root"/>
      <xsl:param name = "id" select="generate-id()"/>
      <div class="style-switcher-box" id="{$id}">
      <xsl:call-template name="insert.javascript" >
      <xsl:with-param name="content" >
          boostscript.call( boostscript.style_switcher, 'insert_style_selector',
             '<xsl:value-of select="$id"/>',
             '<xsl:call-template name = "href.target.relative">
                <xsl:with-param name = "target" select="$xml" />
              </xsl:call-template>',
             '<xsl:call-template name = "href.target.relative">
                <xsl:with-param name = "target" select="$root" />
              </xsl:call-template>'
          );
      </xsl:with-param>
      </xsl:call-template>
      </div>
   </xsl:template>

   <!-- insert.javascript

        This function takes cares of adding the correct header
        and footer to support old browsers that do not understand
        javascript.

        Effects:

        <script type="text/javascript" /><!- -
        {$content}
        - -></script>
                                                                -->

   <xsl:template name="insert.javascript">
      <xsl:param name="content" />
      <xsl:text disable-output-escaping="yes">
      &lt;script type="text/javascript" &gt; &lt;!--</xsl:text>
      <xsl:value-of select="$content" />
      <xsl:text disable-output-escaping="yes">//--&gt;&lt;/script&gt;
</xsl:text>
   </xsl:template>

   <xsl:template name="insert.javascript.file">
      <xsl:param name="js" />
      <script type="text/javascript">
         <xsl:attribute name="src">
            <xsl:call-template name = "href.target.relative">
                <xsl:with-param name = "target" select="$js" />
            </xsl:call-template>
         </xsl:attribute>
      </script>
    </xsl:template>

</xsl:stylesheet>