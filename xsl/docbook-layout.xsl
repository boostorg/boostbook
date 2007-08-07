<?xml version = "1.0" encoding = "utf-8"?>
<!--
   Copyright (c) 2002 Douglas Gregor <doug.gregor -at- gmail.com>
   Copyright (c) 2007 Matias Capeletto

   Distributed under the Boost Software License, Version 1.0.
   (See accompanying file LICENSE_1_0.txt or copy at
   http://www.boost.org/LICENSE_1_0.txt)
  -->

<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version = "1.0">

<!--
<xsl:import
  href="http://docbook.sourceforge.net/release/xsl/current/xhtml/formal.xsl"/>
-->

  <xsl:import href="relative-href.xsl"/>
  <xsl:import href="box-wrapper.xsl" />

  <!--
     Override the behaviour of some DocBook elements for better
     integration with the new look & feel.
  -->


  <xsl:template match = "programlisting[ancestor::informaltable]">
     <pre class = "table-{name(.)}"><xsl:apply-templates/></pre>
  </xsl:template>

  <xsl:template match = "refsynopsisdiv">
     <h2 class = "{name(.)}-title">Synopsis</h2>
     <div class = "{name(.)}"><xsl:apply-templates/></div>
  </xsl:template>


  <!-- logo -->

  <xsl:template name="insert.titlepage.logo">
    <xsl:if test="$chapter.logo.img != ''">
      <div class="titlepage_logo"><img src="{$chapter.logo.img}"/></div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="chapter.titlepage.before.recto">
     <xsl:call-template name="insert.titlepage.logo" />
  </xsl:template>

  <xsl:template name="article.titlepage.before.recto">
     <xsl:call-template name="insert.titlepage.logo" />
  </xsl:template>

  <xsl:template name="set.titlepage.before.recto">
     <xsl:call-template name="insert.titlepage.logo" />
  </xsl:template>

  <xsl:template name="book.titlepage.before.recto">
     <xsl:call-template name="insert.titlepage.logo" />
  </xsl:template>

  <xsl:template name="part.titlepage.before.recto">
     <xsl:call-template name="insert.titlepage.logo" />
  </xsl:template>

  <!-- separators -->

  <xsl:template name="section.titlepage.separator">
     <xsl:if test="count(parent::*)='0'"><div class="titlepage_separator"/></xsl:if>
  </xsl:template>

  <xsl:template name="article.titlepage.separator"><div class="titlepage_separator"/></xsl:template>
  <xsl:template name="set.titlepage.separator"><div class="titlepage_separator"/></xsl:template>
  <xsl:template name="book.titlepage.separator"><div class="titlepage_separator"/></xsl:template>
  <xsl:template name="reference.titlepage.separator"><div class="titlepage_separator"/></xsl:template>

  <!-- table: remove border = '1' -->

  <xsl:template match = "table|informaltable">
     <xsl:choose>
        <xsl:when test = "self::table and tgroup|mediaobject|graphic">
           <xsl:apply-imports/>
        </xsl:when><xsl:when test = "self::informaltable and tgroup|mediaobject|graphic">
           <xsl:call-template name = "informal.object">
              <xsl:with-param name = "class"><xsl:choose>
                 <xsl:when test = "@tabstyle">
                    <xsl:value-of select = "@tabstyle"/>
                 </xsl:when><xsl:otherwise>
                    <xsl:value-of select = "local-name(.)"/>
                 </xsl:otherwise>
              </xsl:choose></xsl:with-param>
           </xsl:call-template>
        </xsl:when><xsl:otherwise>
           <table class = "table"><xsl:copy-of select = "@*[not(local-name(.)='border')]"/>
              <xsl:call-template name = "htmlTable"/>
           </table>
        </xsl:otherwise>
     </xsl:choose>
  </xsl:template>

  <xsl:template match = "tgroup" name = "tgroup">
     <xsl:variable name="summary"><xsl:call-template name="dbhtml-attribute">
        <xsl:with-param name="pis" select="processing-instruction('dbhtml')"/>
        <xsl:with-param name="attribute" select="'table-summary'"/>
     </xsl:call-template></xsl:variable>

     <xsl:variable name="cellspacing"><xsl:call-template name="dbhtml-attribute">
        <xsl:with-param name="pis" select="processing-instruction('dbhtml')"/>
        <xsl:with-param name="attribute" select="'cellspacing'"/>
     </xsl:call-template></xsl:variable>

     <xsl:variable name="cellpadding"><xsl:call-template name="dbhtml-attribute">
        <xsl:with-param name="pis" select="processing-instruction('dbhtml')[1]"/>
        <xsl:with-param name="attribute" select="'cellpadding'"/>
     </xsl:call-template></xsl:variable>

     <table class = "table">
        <xsl:choose>
           <xsl:when test="../textobject/phrase">
              <xsl:attribute name="summary">
                 <xsl:value-of select="../textobject/phrase"/>
              </xsl:attribute>
           </xsl:when><xsl:when test="$summary != ''">
              <xsl:attribute name="summary">
                 <xsl:value-of select="$summary"/>
              </xsl:attribute>
           </xsl:when><xsl:when test="../title">
              <xsl:attribute name="summary">
                 <xsl:value-of select="string(../title)"/>
              </xsl:attribute>
           </xsl:when>
           <xsl:otherwise/>
        </xsl:choose><xsl:if test="$cellspacing != '' or $html.cellspacing != ''">
           <xsl:attribute name="cellspacing"><xsl:choose>
              <xsl:when test="$cellspacing != ''"><xsl:value-of select="$cellspacing"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="$html.cellspacing"/></xsl:otherwise>
           </xsl:choose></xsl:attribute>
        </xsl:if><xsl:if test="$cellpadding != '' or $html.cellpadding != ''">
           <xsl:attribute name="cellpadding"><xsl:choose>
              <xsl:when test="$cellpadding != ''"><xsl:value-of select="$cellpadding"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="$html.cellpadding"/></xsl:otherwise>
           </xsl:choose></xsl:attribute>
        </xsl:if><xsl:if test="../@pgwide=1">
           <xsl:attribute name="width">100%</xsl:attribute>
        </xsl:if>

        <xsl:variable name="colgroup">
           <colgroup><xsl:call-template name="generate.colgroup">
              <xsl:with-param name="cols" select="@cols"/>
           </xsl:call-template></colgroup>
        </xsl:variable>

        <xsl:variable name="explicit.table.width"><xsl:call-template name="dbhtml-attribute">
           <xsl:with-param name="pis" select="../processing-instruction('dbhtml')[1]"/>
           <xsl:with-param name="attribute" select="'table-width'"/>
        </xsl:call-template></xsl:variable>

        <xsl:variable name="table.width"><xsl:choose>
           <xsl:when test="$explicit.table.width != ''">
              <xsl:value-of select="$explicit.table.width"/>
           </xsl:when><xsl:when test="$default.table.width = ''">
              <xsl:text>100%</xsl:text>
           </xsl:when><xsl:otherwise>
              <xsl:value-of select="$default.table.width"/>
           </xsl:otherwise>
        </xsl:choose></xsl:variable>

        <xsl:if test="$default.table.width != '' or $explicit.table.width != ''">
           <xsl:attribute name="width"><xsl:choose>
              <xsl:when test="contains($table.width, '%')">
                 <xsl:value-of select="$table.width"/>
              </xsl:when><xsl:when test="$use.extensions != 0 and $tablecolumns.extension != 0">
                 <xsl:choose>
                    <xsl:when test="function-available('stbl:convertLength')">
                       <xsl:value-of select="stbl:convertLength($table.width)"/>
                    </xsl:when><xsl:when test="function-available('xtbl:convertLength')">
                       <xsl:value-of select="xtbl:convertLength($table.width)"/>
                    </xsl:when><xsl:otherwise>
                       <xsl:message terminate="yes">
                          <xsl:text>No convertLength function available.</xsl:text>
                       </xsl:message>
                    </xsl:otherwise>
                 </xsl:choose>
              </xsl:when><xsl:otherwise>
                 <xsl:value-of select="$table.width"/>
              </xsl:otherwise>
           </xsl:choose></xsl:attribute>
        </xsl:if>

        <xsl:choose>
           <xsl:when test="$use.extensions != 0 and $tablecolumns.extension != 0">
              <xsl:choose>
                 <xsl:when test="function-available('stbl:adjustColumnWidths')">
                    <xsl:copy-of select="stbl:adjustColumnWidths($colgroup)"/>
                 </xsl:when><xsl:when test="function-available('xtbl:adjustColumnWidths')">
                    <xsl:copy-of select="xtbl:adjustColumnWidths($colgroup)"/>
                 </xsl:when><xsl:when test="function-available('ptbl:adjustColumnWidths')">
                    <xsl:copy-of select="ptbl:adjustColumnWidths($colgroup)"/>
                 </xsl:when><xsl:otherwise>
                    <xsl:message terminate="yes">
                       <xsl:text>No adjustColumnWidths function available.</xsl:text>
                    </xsl:message>
                 </xsl:otherwise>
              </xsl:choose>
           </xsl:when><xsl:otherwise>
              <xsl:copy-of select="$colgroup"/>
           </xsl:otherwise>
        </xsl:choose>

        <xsl:apply-templates select="thead"/>
        <xsl:apply-templates select="tfoot"/>
        <xsl:apply-templates select="tbody"/>

        <xsl:if test=".//footnote"><tbody class="footnotes">
           <tr><td colspan="{@cols}">
              <xsl:apply-templates select=".//footnote" mode="table.footnote.mode"/>
           </td></tr>
        </tbody></xsl:if>
     </table>
  </xsl:template>

  <!-- table of contents 

    The standard Docbook template selects, amoung others,
    the 'refentry' element for inclusion in TOC. In some
    cases, this creates empty TOC. The most possible reason
    is that there's 'refentry' element without 'refentrytitle',
    but it's a mistery why it occurs. Even if we fix that
    problem, we'll get non-empty TOC where no TOC is desired
    (e.g. for section corresponding to each header file in
    library doc). So, don't bother for now.
  -->

  <xsl:template name="section.toc">
     <xsl:param name="toc-context" select="."/>
     <xsl:param name="toc.title.p" select="true()"/>

     <xsl:call-template name="make.toc">
        <xsl:with-param name="toc-context" select="$toc-context"/>
        <xsl:with-param name="toc.title.p" select="$toc.title.p"/>
        <xsl:with-param name="nodes" select="
           section|sect1|sect2|sect3|sect4|sect5|
           bridgehead[$bridgehead.in.toc != 0]
        "/>
     </xsl:call-template>

  </xsl:template>

  <!-- When there is both a title and a caption for a table, only use the 
       title. -->
  <xsl:template match="table" mode="title.markup">
    <xsl:param name="allow-anchors" select="0"/>
    <xsl:apply-templates select="(title|caption)[1]" mode="title.markup">
      <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
    </xsl:apply-templates>
  </xsl:template>


<!--========================================================================
                        Box-wrapper support
============================================================================

Overwrites docbook blocks templates to insert a box wrapper nested in them.
With this wrapper in place we can modify the look & feel of the blocks with
total freedom.

These overwrites are against long stablished docbook templates, so it seems
to be safe.

=========================================================================-->


<xsl:template match="sidebar">
  <div class="{name(.)}">
    <xsl:call-template name="box.wrapper.decoration" >
    <xsl:with-param name="content" >
        <xsl:call-template name="anchor"/>
        <xsl:apply-templates/>
    </xsl:with-param>
    </xsl:call-template>
  </div>
</xsl:template>


<!-- Overwrites make.toc to add the box wrapper -->

<xsl:template name="make.toc">
  <xsl:param name="toc-context" select="."/>
  <xsl:param name="toc.title.p" select="true()"/>
  <xsl:param name="nodes" select="/NOT-AN-ELEMENT"/>

  <xsl:variable name="toc.title">
    <xsl:if test="$toc.title.p">
      <p>
        <b>
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">TableofContents</xsl:with-param>
          </xsl:call-template>
        </b>
      </p>
    </xsl:if>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$manual.toc != ''">
      <xsl:variable name="id">
        <xsl:call-template name="object.id"/>
      </xsl:variable>
      <xsl:variable name="toc" select="document($manual.toc, .)"/>
      <xsl:variable name="tocentry" select="$toc//tocentry[@linkend=$id]"/>
      <xsl:if test="$tocentry and $tocentry/*">
        <div class="toc">
        <xsl:call-template name="box.wrapper.decoration" >
        <xsl:with-param name="content" >
          <xsl:copy-of select="$toc.title"/>
          <xsl:element name="{$toc.list.type}" namespace="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="manual-toc">
              <xsl:with-param name="tocentry" select="$tocentry/*[1]"/>
            </xsl:call-template>
          </xsl:element>
        </xsl:with-param>
        </xsl:call-template>
        </div>
      </xsl:if>
    </xsl:when>
    <xsl:otherwise>
      <xsl:if test="$nodes">
        <div class="toc">

        <xsl:call-template name="box.wrapper.decoration" >
        <xsl:with-param name="content" >

          <xsl:copy-of select="$toc.title"/>
          <xsl:element name="{$toc.list.type}" namespace="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="$nodes" mode="toc">
              <xsl:with-param name="toc-context" select="$toc-context"/>
            </xsl:apply-templates>
          </xsl:element>

        </xsl:with-param>
        </xsl:call-template>

        </div>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template match="programlisting|screen|synopsis">
  <xsl:param name="suppress-numbers" select="'0'"/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:call-template name="anchor"/>

  <div class="{name(.)}">

  <xsl:call-template name="box.wrapper.decoration" >
  <xsl:with-param name="content" >

  <xsl:if test="name(.) = 'programlisting'">
     <xsl:if test="$syntax.switcher.show='true'">
        <xsl:call-template name="insert.style.selector">
           <xsl:with-param name="xml"  select="$syntax.switcher.xml" />
           <xsl:with-param name="root" select="$syntax.switcher.root"/>
        </xsl:call-template>
     </xsl:if>
  </xsl:if>

  <pre>

  <xsl:choose>
    <xsl:when test="$suppress-numbers = '0'       and @linenumbering = 'numbered'       and $use.extensions != '0'       and $linenumbering.extension != '0'">
      <xsl:variable name="rtf">
        <xsl:apply-templates/>
      </xsl:variable>
        <xsl:call-template name="number.rtf.lines">
          <xsl:with-param name="rtf" select="$rtf"/>
        </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
        <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>

  </pre>
  </xsl:with-param>
  </xsl:call-template>
  </div>

</xsl:template>


<!-- [XHTML] Overwrites to achive Strict XHTML validation -->

<xsl:template name="process.footnotes">
  <xsl:variable name="footnotes" select=".//footnote"/>
  <xsl:variable name="fcount">
    <xsl:call-template name="count.footnotes.in.this.chunk">
      <xsl:with-param name="node" select="."/>
      <xsl:with-param name="footnotes" select="$footnotes"/>
    </xsl:call-template>
  </xsl:variable>

<!--
  <xsl:message>
    <xsl:value-of select="name(.)"/>
    <xsl:text> fcount: </xsl:text>
    <xsl:value-of select="$fcount"/>
  </xsl:message>
-->

  <!-- Only bother to do this if there's at least one non-table footnote -->
  <xsl:if test="$fcount &gt; 0">
    <div class="footnotes">
      <xsl:call-template name="process.footnotes.in.this.chunk">
        <xsl:with-param name="node" select="."/>
        <xsl:with-param name="footnotes" select="$footnotes"/>
      </xsl:call-template>
    </div>
  </xsl:if>

  <!-- FIXME: When chunking, only the annotations actually used
              in this chunk should be referenced. I don't think it
              does any harm to reference them all, but it adds
              unnecessary bloat to each chunk. -->
  <xsl:if test="$annotation.support != 0 and //annotation">
    <div class="annotation-list">
      <div class="annotation-nocss">
        <p>The following annotations are from this essay. You are seeing
        them here because your browser doesn&#8217;t support the user-interface
        techniques used to make them appear as &#8216;popups&#8217; on modern browsers.</p>
      </div>

      <xsl:apply-templates select="//annotation" mode="annotation-popup"/>
    </div>
  </xsl:if>
</xsl:template>


<xsl:template match="orderedlist">
  <xsl:variable name="start">
    <xsl:call-template name="orderedlist-starting-number"/>
  </xsl:variable>

  <xsl:variable name="numeration">
    <xsl:call-template name="list.numeration"/>
  </xsl:variable>

  <xsl:variable name="type">
    <xsl:choose>
      <xsl:when test="$numeration='arabic'">ol_1</xsl:when>
      <xsl:when test="$numeration='loweralpha'">ol_a</xsl:when>
      <xsl:when test="$numeration='lowerroman'">ol_i</xsl:when>
      <xsl:when test="$numeration='upperalpha'">ol_A</xsl:when>
      <xsl:when test="$numeration='upperroman'">ol_I</xsl:when>
      <!-- What!? This should never happen -->
      <xsl:otherwise>
        <xsl:message>
          <xsl:text>Unexpected numeration: </xsl:text>
          <xsl:value-of select="$numeration"/>
        </xsl:message>
        <xsl:value-of select="1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <div>
    <!--<xsl:apply-templates select="." mode="class.attribute"/>-->
    <xsl:call-template name="anchor"/>

    <xsl:if test="title">
      <xsl:call-template name="formal.object.heading"/>
    </xsl:if>

    <!-- Preserve order of PIs and comments -->
    <xsl:apply-templates select="*[not(self::listitem                   or self::title                   or self::titleabbrev)]                 |comment()[not(preceding-sibling::listitem)]                 |processing-instruction()[not(preceding-sibling::listitem)]"/>

    <ol>
      <xsl:if test="$start != '1'">
        <xsl:attribute name="start">
          <xsl:value-of select="$start"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$numeration != ''">
        <xsl:attribute name="class">
          <xsl:value-of select="$type"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="listitem                     |comment()[preceding-sibling::listitem]                     |processing-instruction()[preceding-sibling::listitem]"/>
    </ol>
  </div>
</xsl:template>

<xsl:template name="language.attribute">
  <xsl:param name="node" select="."/>
</xsl:template>

</xsl:stylesheet>
