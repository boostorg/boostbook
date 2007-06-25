<?xml version="1.0" encoding="utf-8"?>
<!--
   Copyright (c) 2002 Douglas Gregor <doug.gregor -at- gmail.com>
   Copyright (c) 2007 Matias Capeletto

   Distributed under the Boost Software License, Version 1.0.
   (See accompanying file LICENSE_1_0.txt or copy at
   http://www.boost.org/LICENSE_1_0.txt)
  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

<!--
<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/xhtml/admon.xsl" />
-->

<xsl:import href="relative-href.xsl" />
<xsl:import href="box-wrapper.xsl" />

   <xsl:template name="admon.graphic.icon">
      <xsl:param name="node" select="."/>

      <xsl:variable name="admon.icon.type">
         <xsl:choose>
            <xsl:when test="local-name($node)='note'">note</xsl:when>
            <xsl:when test="local-name($node)='warning'">warning</xsl:when>
            <xsl:when test="local-name($node)='caution'">caution</xsl:when>
            <xsl:when test="local-name($node)='tip'">tip</xsl:when>
            <xsl:when test="local-name($node)='important'">important</xsl:when>
            <xsl:otherwise>note</xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <div class="admonition-icon">
          <div class="{$admon.icon.type}-icon" />
      </div>

   </xsl:template>



   <!-- overwrites docbook graphical.admonition -->

   <xsl:template name="graphical.admonition">

      <xsl:variable name="admon.type">
         <xsl:choose>
            <xsl:when test="local-name(.)='note'">Note</xsl:when>
            <xsl:when test="local-name(.)='warning'">Warning</xsl:when>
            <xsl:when test="local-name(.)='caution'">Caution</xsl:when>
            <xsl:when test="local-name(.)='tip'">Tip</xsl:when>
            <xsl:when test="local-name(.)='important'">Important</xsl:when>
            <xsl:otherwise>Note</xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:variable name="alt">
         <xsl:call-template name="gentext">
            <xsl:with-param name="key" select="$admon.type"/>
         </xsl:call-template>
      </xsl:variable>

      <div class="{name(.)}">

        <xsl:call-template name="box.wrapper.decoration" >
        <xsl:with-param name="content" >

         <div class="admonition-graphic">
            <xsl:call-template name="admon.graphic.icon"/>
         </div>
         <div class="admonition-body">
         <div class="admonition-title">
            <xsl:call-template name="anchor"/>
            <xsl:if test="$admon.textlabel != 0 or title">
               <xsl:apply-templates select="." mode="object.title.markup"/>
            </xsl:if>
         </div>
         <div class="admonition-content">
            <xsl:apply-templates/>
         </div>
         </div>

        </xsl:with-param>
        </xsl:call-template>

      </div>

   </xsl:template>


</xsl:stylesheet>
