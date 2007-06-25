<?xml version="1.0" encoding="utf-8"?>
<!--
   Copyright (c) 2007 Matias Capeletto

   Distributed under the Boost Software License, Version 1.0.
   (See accompanying file LICENSE_1_0.txt or copy at
   http://www.boost.org/LICENSE_1_0.txt)
  -->

<!--
   Footer stylesheet
  -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:rev="http://www.cs.rpi.edu/~gregod/boost/tools/doc/revision"
                exclude-result-prefixes="rev"
                version="1.0">


   <xsl:template name = "boostbook.footer">
      <xsl:param name = "prev" select = "/foo"/>
      <xsl:param name = "next" select = "/foo"/>
      <xsl:param name = "nav.context"/>

      <!-- website footer -->

      <div id="footer">
         <div id="footer-left">
            <xsl:variable name="revised.time">
               <xsl:call-template name = "find.revised.time"/>
            </xsl:variable>
            <xsl:choose>
               <xsl:when test="$revised.time='unknown'">
               <!-- unknown revised time, skip revised time -->
               </xsl:when>
               <xsl:otherwise>
                  <div id="revised">Revised: <xsl:value-of select="$revised.time"/></div>
               </xsl:otherwise>
            </xsl:choose>
            <div id="copyright">
               <xsl:apply-templates select="ancestor::*/*/copyright"
                                    mode="boost.footer"/>
            </div>
            <div id="license">
               <p>Distributed under the
                  <a href="/LICENSE_1_0.txt"
                     class="internal">Boost Software License, Version 1.0</a>.
               </p>
            </div>
         </div>
         <div id="footer-right">
            <div id="banners">
               <p id="banner-xhtml">
                  <a href="http://validator.w3.org/check?uri=referer"
                     class="external">XHTML 1.0</a>
               </p>
               <p id="banner-css">
                  <a href="http://jigsaw.w3.org/css-validator/check/referer"
                     class="external">CSS</a>
               </p>
               <p id="banner-sourceforge">
                  <a href="http://sourceforge.net"
                     class="external">SourceForge</a>
               </p>
            </div>
         </div>
         <div class="clear"></div>
      </div>


   </xsl:template>


   <xsl:template name = "month.name.from.number" >
      <xsl:param name = "month"/>
      <xsl:choose>
         <xsl:when test="$month=1">January</xsl:when>
         <xsl:when test="$month=2">February</xsl:when>
         <xsl:when test="$month=3">March</xsl:when>
         <xsl:when test="$month=4">April</xsl:when>
         <xsl:when test="$month=5">May</xsl:when>
         <xsl:when test="$month=6">June</xsl:when>
         <xsl:when test="$month=7">July</xsl:when>
         <xsl:when test="$month=8">August</xsl:when>
         <xsl:when test="$month=9">September</xsl:when>
         <xsl:when test="$month=10">October</xsl:when>
         <xsl:when test="$month=11">November</xsl:when>
         <xsl:when test="$month=12">December</xsl:when>
      </xsl:choose>
   </xsl:template> 


   <xsl:template name="format.cvs.revision">
      <xsl:param name="text"/>

      <!-- Remove the "$Date: " -->
      <xsl:variable name="text.noprefix"
         select="substring-after($text, '$Date: ')"/>

      <!-- Grab the year -->
      <xsl:variable name="year" select="substring-before($text.noprefix, '/')"/>
      <xsl:variable name="text.noyear"
         select="substring-after($text.noprefix, '/')"/>

      <!-- Grab the month -->
      <xsl:variable name="month" select="substring-before($text.noyear, '/')"/>
      <xsl:variable name="text.nomonth"
         select="substring-after($text.noyear, '/')"/>

      <!-- Grab the year -->
      <xsl:variable name="day" select="substring-before($text.nomonth, ' ')"/>
      <xsl:variable name="text.noday"
         select="substring-after($text.nomonth, ' ')"/>

      <!-- Get the time -->
      <xsl:variable name="time" select="substring-before($text.noday, ' ')"/>

      <xsl:variable name="month.name">
         <xsl:call-template name = "month.name.from.number" >
            <xsl:with-param name = "month" select="$month" />
         </xsl:call-template>
      </xsl:variable>

      <xsl:value-of select="concat($month.name, ' ', $day, ', ', $year, ' at ',
                                   $time, ' GMT')"/>
   </xsl:template>


   <xsl:template name="format.svn.revision">
       <xsl:param name="text"/>

       <!-- Remove the "$Date: " -->
       <xsl:variable name="text.noprefix"
          select="substring-after($text, '$Date: ')"/>

       <!-- Grab the year -->
       <xsl:variable name="year" select="substring-before($text.noprefix, '-')"/>
       <xsl:variable name="text.noyear"
          select="substring-after($text.noprefix, '-')"/>

       <!-- Grab the month -->
       <xsl:variable name="month" select="substring-before($text.noyear, '-')"/>
       <xsl:variable name="text.nomonth"
          select="substring-after($text.noyear, '-')"/>

       <!-- Grab the year -->
       <xsl:variable name="day" select="substring-before($text.nomonth, ' ')"/>
       <xsl:variable name="text.noday"
          select="substring-after($text.nomonth, ' ')"/>

       <!-- Get the time -->
       <xsl:variable name="time" select="substring-before($text.noday, ' ')"/>
       <xsl:variable name="text.notime"
          select="substring-after($text.noday, ' ')"/>

       <!-- Get the timezone -->
       <xsl:variable name="timezone" select="substring-before($text.notime, ' ')"/>

       <xsl:variable name="month.name">
         <xsl:call-template name = "month.name.from.number" >
            <xsl:with-param name = "month" select="$month" />
         </xsl:call-template>
       </xsl:variable>

       <xsl:value-of select="concat($month.name, ' ', $day, ', ', $year, ' at ',
                                    $time, ' ', $timezone)"/>
    </xsl:template>


    <xsl:template match="copyright" mode="boost.footer">
       <!--xsl:if test="position() &gt; 1"-->
       <p xmlns="http://www.w3.org/1999/xhtml">
       <xsl:call-template name="gentext">
          <xsl:with-param name="key" select="'Copyright'"/>
       </xsl:call-template>
       <xsl:call-template name="gentext.space"/>
       <xsl:call-template name="dingbat">
          <xsl:with-param name="dingbat">copyright</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="gentext.space"/>
       <xsl:call-template name="copyright.years">
          <xsl:with-param name="years" select="year"/>
          <xsl:with-param name="print.ranges" select="$make.year.ranges"/>
          <xsl:with-param name="single.year.ranges"
                          select="$make.single.year.ranges"/>
       </xsl:call-template>
       <xsl:call-template name="gentext.space"/>
       <xsl:apply-templates select="holder" mode="titlepage.mode"/>
       </p>
    </xsl:template>


    <xsl:template name= "find.revised.time" >
       <xsl:variable name="revision-nodes"
                     select="ancestor-or-self::*
                    [not (attribute::rev:last-revision='')]"/>

       <xsl:if test="count($revision-nodes) &gt; 0">
          <xsl:variable name="revision-node"
                        select="$revision-nodes[last()]"/>
          <xsl:variable name="revision-text">
             <xsl:value-of
                select="normalize-space($revision-node/attribute::rev:last-revision)"/>
          </xsl:variable>
          <xsl:choose>
             <xsl:when test="string-length($revision-text) &gt; 0">
                 <xsl:choose>
                     <xsl:when test="contains($revision-text, '/')">
                         <xsl:call-template name="format.cvs.revision">
                            <xsl:with-param name="text" select="$revision-text"/>
                         </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:call-template name="format.svn.revision">
                             <xsl:with-param name="text" select="$revision-text"/>
                         </xsl:call-template>
                     </xsl:otherwise>
                 </xsl:choose>
             </xsl:when>
             <xsl:otherwise>unknown</xsl:otherwise>
          </xsl:choose>
       </xsl:if>
    </xsl:template>


</xsl:stylesheet>