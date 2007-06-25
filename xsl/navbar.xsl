<?xml version="1.0" encoding="utf-8"?>
<!--
   Copyright (c) 2002 Douglas Gregor <doug.gregor -at- gmail.com>
  
   Distributed under the Boost Software License, Version 1.0.
   (See accompanying file LICENSE_1_0.txt or copy at
   http://www.boost.org/LICENSE_1_0.txt)
  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

   <xsl:import href="user-params.xsl"/>
   <xsl:import href="relative-href.xsl"/>

   <xsl:template name = "insert.spirit.navig.icon">
      <xsl:param name="direction" select="'next'"/>
      <xsl:param name="accesskey" select="''"/>
      <xsl:param name="target" select="''"/>

      <div class = "spirit-nav-icon">
         <a accesskey = "{$accesskey}" href="{$target}">
            <div class = "{$direction}-icon" />
         </a>
      </div>

   </xsl:template>

   <xsl:template name = "insert.spirit.navbar">
      <xsl:param name = "prev" select = "/foo"/>
      <xsl:param name = "next" select = "/foo"/>
      <xsl:param name = "nav.context"/>

      <xsl:variable name = "home" select = "/*[1]"/>
      <xsl:variable name = "up"   select = "parent::*"/>

      <div class = "spirit-nav">
         <!-- prev -->
         <xsl:if test = "count($prev)>0">
            <xsl:call-template name = "insert.spirit.navig.icon">
               <xsl:with-param name = "direction" select = "'prev'"/>
               <xsl:with-param name = "accesskey" select="'p'" />
               <xsl:with-param name = "target">
                  <xsl:call-template name = "href.target">
                     <xsl:with-param name = "object" select = "$prev"/>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>

         <!-- up -->
         <xsl:if test = "count($up)>0">
            <xsl:call-template name = "insert.spirit.navig.icon">
               <xsl:with-param name = "direction" select = "'up'"/>
               <xsl:with-param name = "accesskey" select="'u'" />
               <xsl:with-param name = "target">
                  <xsl:call-template name = "href.target">
                     <xsl:with-param name = "object" select = "$up"/>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:if>

         <!-- home -->
         <xsl:if test = "$home != . or $nav.context = 'toc'">
            <xsl:call-template name = "insert.spirit.navig.icon">
               <xsl:with-param name = "direction" select = "'home'"/>
               <xsl:with-param name = "accesskey" select="'h'" />
               <xsl:with-param name = "target">
                  <xsl:call-template name = "href.target">
                     <xsl:with-param name = "object" select = "$home"/>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:if test = "$chunk.tocs.and.lots != 0 and $nav.context != 'toc'">
               <xsl:text>|</xsl:text>
            </xsl:if>
         </xsl:if>
         <xsl:if test = "$chunk.tocs.and.lots != 0 and $nav.context != 'toc'">
            <a accesskey = "t">
            <xsl:attribute name = "href">
               <xsl:apply-templates select = "/*[1]" mode = "recursive-chunk-filename"/>
               <xsl:text>-toc</xsl:text>
               <xsl:value-of select = "$html.ext"/>
            </xsl:attribute>
            <xsl:call-template name = "gentext">
               <xsl:with-param name = "key" select = "'nav-toc'"/>
            </xsl:call-template>
            </a>
        </xsl:if>
         <!-- next -->
         <xsl:if test = "count($next)>0">
            <xsl:call-template name = "insert.spirit.navig.icon">
               <xsl:with-param name = "direction" select = "'next'"/>
               <xsl:with-param name = "accesskey" select="'n'" />
               <xsl:with-param name = "target">
                  <xsl:call-template name = "href.target">
                     <xsl:with-param name = "object" select = "$next"/>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
     </div>
   </xsl:template>

</xsl:stylesheet>