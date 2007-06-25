<?xml version="1.0" encoding="utf-8"?>
<!--
   Copyright (c) 2007 Matias Capeletto

   Distributed under the Boost Software License, Version 1.0.
   (See accompanying file LICENSE_1_0.txt or copy at
   http://www.boost.org/LICENSE_1_0.txt)
  -->

<!--
   Header stylesheet
  -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

<xsl:import href="javascript.xsl"/>

   <xsl:template name = "boostbook.header">
      <xsl:param name = "prev" select = "/foo"/>
      <xsl:param name = "next" select = "/foo"/>
      <xsl:param name = "nav.context"/>

      <xsl:variable name = "home" select = "/*[1]"/>
      <xsl:variable name = "up"   select = "parent::*"/>

      <!-- Include the grouped links java script api -->

      <div id="heading">

         <div id="heading-placard"></div>

         <!-- GroupedLinks selection boxes for All Boost Libraries and
              inner sections -->

         <div class="heading-navigation-box">
         <xsl:if test = "$chapters.select.box.show = 'true'">
            <xsl:call-template name = "nested.links.select.box">
               <xsl:with-param name = "xml"
                               select="$chapters.select.box.xml"/>
               <xsl:with-param name = "id" select = "'chapters_select_box'"/>
               <xsl:with-param name = "base.root" select = "$chapters.select.box.root"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:if test = "$sections.select.box.show = 'true'">
            <xsl:call-template name = "nested.links.select.box">
               <xsl:with-param name = "xml"
                               select="$sections.select.box.xml"/>
               <xsl:with-param name = "id" select = "'sections_select_box'"/>
               <xsl:with-param name = "base.root" select = "$sections.select.box.root"/>
            </xsl:call-template>
         </xsl:if>
         </div>

         <!-- Google Custom Search linked CSE allows us to customize google
              search pages by means of a definition in xml format. By default a
              general definition is used, but libraries are encouraged to change
              it in order to add a refinement for the libs docs -->

         <div class="search-box">
         <xsl:if test = "$google.search.box.show = 'true'">
            <xsl:call-template name = "insert.google.search.box">
               <xsl:with-param name = "xml"
                               select = "$google.search.box.xml"/>
            </xsl:call-template>
         </xsl:if>
         </div>

      </div>

   </xsl:template>



   <!--
      insert.google.search.box template

      params:
         cse.definition - absolute web url of the cse definition xml

      effects:
         Insert a linked cse google search box
   -->

   <xsl:template name = "insert.google.search.box">
      <xsl:param name = "xml"/>

      <form id="cref" action="http://google.com/cse">
         <div class="search-box-label" />
         <div>
         <input type="hidden" name="cref" value="{$xml}" />
         <input class="search-box" type="text" name="q" id="q" size="40"
                maxlength="255" alt="Search Text"/>
         </div>
      </form>
   </xsl:template>

</xsl:stylesheet>
