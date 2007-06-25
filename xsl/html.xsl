<?xml version="1.0" encoding="utf-8"?>
<!--
   Copyright (c) 2002 Douglas Gregor <doug.gregor -at- gmail.com>

   Distributed under the Boost Software License, Version 1.0.
   (See accompanying file LICENSE_1_0.txt or copy at
   http://www.boost.org/LICENSE_1_0.txt)
  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rev="http://www.cs.rpi.edu/~gregod/boost/tools/doc/revision"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="rev"
                version="1.0">

   <!-- Import the HTML chunking stylesheet -->

   <xsl:import
     href="http://docbook.sourceforge.net/release/xsl/current/xhtml/chunk.xsl"/>
   <xsl:import
     href="http://docbook.sourceforge.net/release/xsl/current/xhtml/math.xsl"/>

   <xsl:import href="user-params.xsl"/>
   <xsl:import href="docbook-params.xsl"/>

   <xsl:import href="chunk-common.xsl"/>
   <xsl:import href="docbook-layout.xsl"/>
   <xsl:import href="admon.xsl"/>
   <xsl:import href="xref.xsl"/>
   <xsl:import href="relative-href.xsl"/>
   <xsl:import href="callout.xsl"/>
   <xsl:import href="javascript.xsl"/>
   <xsl:import href="relative-href.xsl"/>

   <!-- Unused -->
   <xsl:param name="doc.standalone">false</xsl:param>


   <xsl:param name="generate.toc">
appendix  toc,title
article/appendix  nop
article   toc,title
book      toc,title
chapter   toc,title
part      toc,title
preface   toc,title
qandadiv  toc
qandaset  toc
reference toc,title
sect1     toc
sect2     toc
sect3     toc
sect4     toc
sect5     toc
section   toc
set       toc,title
   </xsl:param>



<!-- We don't want refentry's to show up in the TOC because they
     will merely be redundant with the synopsis. -->
<xsl:template match="refentry" mode="toc"/>


<!-- ============================================================ -->

<xsl:template name="user.head.content">
   <xsl:param name="node" select="."/>

   <!-- Javascipt components -->

   <xsl:call-template name="include.javascript.components" />

   <!-- Alternate styles -->

   <xsl:if test="$syntax.switcher.show='true'">
      <xsl:call-template name="include.alternate.stylesheets">
         <xsl:with-param name="xml"  select="$syntax.switcher.xml" />
         <xsl:with-param name="root" select="$syntax.switcher.root"/>
      </xsl:call-template>
   </xsl:if>

   <xsl:if test="$quickbook.source.style.show='true'">
      <xsl:call-template name="include.alternate.css">
         <xsl:with-param name="title" select="'Quickbook source'" />
         <xsl:with-param name="url"   select="$quickbook.source.css" />
      </xsl:call-template>
   </xsl:if>

   <!-- Load user stylesheet  -->

   <xsl:if test="$syntax.switcher.show='true' or $quickbook.source.style.show='true'">
      <xsl:call-template name="load.user.stylesheet" />
   </xsl:if>

</xsl:template>


<xsl:template name="include.alternate.css">
    <xsl:param name="title" />
    <xsl:param name="url" />
    <xsl:param name="rel" select="'alternate stylesheet'" />
    <link rel="{$rel}" type="text/css" title="{$title}">
        <xsl:attribute name="href">
            <xsl:call-template name="href.target.relative">
                <xsl:with-param name="target"
                                select="$url"/>
            </xsl:call-template>
        </xsl:attribute>
    </link>
</xsl:template>


<xsl:template name="output.html.stylesheets">
    <xsl:param name="stylesheets" select="''"/>

    <xsl:choose>
        <xsl:when test="contains($stylesheets, ' ')">
            <link rel="stylesheet">
                <xsl:attribute name="href">
                    <xsl:call-template name="href.target.relative">
                        <xsl:with-param name="target" select="substring-before($stylesheets, ' ')"/>
                    </xsl:call-template>
                </xsl:attribute>
                <xsl:if test="$html.stylesheet.type != ''">
                    <xsl:attribute name="type">
                        <xsl:value-of select="$html.stylesheet.type"/>
                    </xsl:attribute>
                </xsl:if>
            </link>
            <xsl:call-template name="output.html.stylesheets">
                <xsl:with-param name="stylesheets" select="substring-after($stylesheets, ' ')"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="$stylesheets != ''">

            <link rel="stylesheet">
                <xsl:attribute name="href">
                    <xsl:call-template name="href.target.relative">
                        <xsl:with-param name="target" select="$stylesheets"/>
                    </xsl:call-template>
                </xsl:attribute>
                <xsl:if test="$html.stylesheet.type != ''">
                    <xsl:attribute name="type">
                        <xsl:value-of select="$html.stylesheet.type"/>
                    </xsl:attribute>
                </xsl:if>
            </link>
        </xsl:when>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>

