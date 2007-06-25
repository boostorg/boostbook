<?xml version="1.0" encoding="utf-8"?>
<!--
   Copyright (c) 2007 Joel de Guzman <djowel -at- gmail.com>

   Distributed under the Boost Software License, Version 1.0.
   (See accompanying file LICENSE_1_0.txt or copy at
   http://www.boost.org/LICENSE_1_0.txt)
  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

<!--
<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/xhtml/callout.xsl" />
-->

<xsl:import href="relative-href.xsl"/>

<xsl:template name="callout-bug">
  <xsl:param name="conum" select='1'/>

  <xsl:choose>
    <xsl:when test="$callout.graphics != 0
                    and $conum &lt;= $callout.graphics.number.limit">

      <xsl:variable name="relative_callout_graphics_path">
        <xsl:call-template name="href.target.relative">
          <xsl:with-param name="target" select="$callout.graphics.path"/>
        </xsl:call-template>
      </xsl:variable>

      <img src="{$relative_callout_graphics_path}{$conum}{$callout.graphics.extension}"
           alt="[{$conum}>"/>
    </xsl:when>

    <xsl:when test="$callout.unicode != 0
                    and $conum &lt;= $callout.unicode.number.limit">
      <xsl:choose>
        <xsl:when test="$callout.unicode.start.character = 10102">
          <xsl:choose>
            <xsl:when test="$conum = 1">&#10102;</xsl:when>
            <xsl:when test="$conum = 2">&#10103;</xsl:when>
            <xsl:when test="$conum = 3">&#10104;</xsl:when>
            <xsl:when test="$conum = 4">&#10105;</xsl:when>
            <xsl:when test="$conum = 5">&#10106;</xsl:when>
            <xsl:when test="$conum = 6">&#10107;</xsl:when>
            <xsl:when test="$conum = 7">&#10108;</xsl:when>
            <xsl:when test="$conum = 8">&#10109;</xsl:when>
            <xsl:when test="$conum = 9">&#10110;</xsl:when>
            <xsl:when test="$conum = 10">&#10111;</xsl:when>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message>
            <xsl:text>Don't know how to generate Unicode callouts </xsl:text>
            <xsl:text>when $callout.unicode.start.character is </xsl:text>
            <xsl:value-of select="$callout.unicode.start.character"/>
          </xsl:message>
          <xsl:text>(</xsl:text>
          <xsl:value-of select="$conum"/>
          <xsl:text>)</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>(</xsl:text>
      <xsl:value-of select="$conum"/>
      <xsl:text>)</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- Overwrites calloutlist to make the output validate against Strict XHTML
     Avoid the use of "width" and "compact"
-->

<xsl:template match="calloutlist">
  <div class="calloutlist">
    <xsl:apply-templates select="." mode="class.attribute"/>
    <xsl:call-template name="anchor"/>
    <xsl:if test="title|info/title">
      <xsl:call-template name="formal.object.heading"/>
    </xsl:if>

    <!-- Preserve order of PIs and comments -->
    <xsl:apply-templates select="*[not(self::callout or self::title or self::titleabbrev)]                    |comment()[not(preceding-sibling::callout)]      |processing-instruction()[not(preceding-sibling::callout)]"/>

    <dl>
       <xsl:apply-templates select="callout            |comment()[preceding-sibling::calllout]     |processing-instruction()[preceding-sibling::callout]"/>
    </dl>
  </div>
</xsl:template>


<xsl:template match="callout">
   <dt>
     <xsl:call-template name="anchor"/>
     <xsl:call-template name="callout.arearefs">
        <xsl:with-param name="arearefs" select="@arearefs"/>
     </xsl:call-template>
   </dt>
   <dd><xsl:apply-templates/></dd>
</xsl:template>


</xsl:stylesheet>
