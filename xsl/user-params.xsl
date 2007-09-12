<?xml version="1.0" encoding="utf-8"?>
<!--
   Copyright (c) 2002 Douglas Gregor <doug.gregor -at- gmail.com>
   Copyright (c) 2007 Matias Capeletto

   Distributed under the Boost Software License, Version 1.0.
   (See accompanying file LICENSE_1_0.txt or copy at
   http://www.boost.org/LICENSE_1_0.txt)
  -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<!-- Deprecated, use project.root -->
<xsl:param name="boost.root" select="'../../../..'"/>

<!--========================================================================
     Html user parameters
     These params control boostbook behaviour
============================================================================

Note: Paths can be absolute or relative to [build-dir]/html/
Conventions:

   .root : directory
   .path : general file
   .img  : image file
   .xml  : xml file
   .css  : stylesheet
   .show : boolean ('true' or 'false')
   .type : enumerated options
                                                                         -->


<!-- project.root
     =======================================================================
     Path to the project root. This is the only parameter you have to change
     if your project directory use the following structure:

        {$project.root}/doc/style/html/main.css (Main stylesheet path)
        {$project.root}/doc/style/html/conversion/docbook_to_quickbook.css
        {$project.root}/doc/style/html/syntax.xml (Alternates syntax highlighting)
        {$project.root}/doc/javascript/main.js (Boost Javascript API)
        {$project.root}/doc/chapters.xml (NestedLinks chapters xml definition)

        This element will not be needed in the future
        {$project.root}/doc/style/html/images/callouts/{n}.png
                                                                         -->
<xsl:param name   = "project.root"
           select = "$boost.root" />

<!-- Deprecated, use project.header.root -->
<xsl:param name="boost.header.root" select="$project.root"/>

<xsl:param name   = "project.header.root"
           select = "$boost.header.root" />

<!-- css.stylesheet.root
     =======================================================================
     Path to the stylesheet root. Boostbook embrace a modular css approach.
     The entry point of the stylesheet will be main.css, but other
     alternate stylesheets can be included
     ( i.e.  {$css.stylesheet.dir}/conversion/docbook_to_quickbook.css )
     Boostbook produce style agnostic xhtml. The style depends only on
     the main.css stylesheet. The banner, footer, admonitions, navigation
     and callouts graphics are controlled by the stylesheet and can be
     easily be change by editing it.

                                                                      -->
<xsl:param name   = "css.stylesheet.root"
           select = "concat($project.root,'/doc/style/html')" />

<xsl:param name   = "boostbook.main.css"
           select = "concat($css.stylesheet.root,'/main.css')" />

<xsl:param name   = "quickbook.source.css"
           select = "concat($css.stylesheet.root,'/conversion/boostbook_to_quickbook.css')" />


<!-- javascript.root
     =======================================================================
     Directory with the javascript libraries used by boostbook.
     It must contain:

        {$javascript.root}/main.js (Boost Javascript API)
                                                                         -->
<xsl:param name   = "javascript.root"
           select = "concat($project.root,'/doc/javascript')" />


<!-- page.style.type
     =======================================================================
     This parameter controls the general style of the html pages. It is
     included for future changes. The only supported style now is 'standard'
                                                                        -->
<xsl:param name   = "page.style.type"
           select = "'standard'" />


<!-- header.show
     =======================================================================
     Insert a banner with the project logo and navigation tools
                                                                         -->
<xsl:param name   = "header.show"
           select = "'true'" />


<!-- chapters.select.box (.show & .xml & .root)
     =======================================================================
     Insert a select box in the banner that allows to jump between chapters.
     The select box uses the NestedLinks javascript API to load the
     available chapters from a xml definition file.
                                                                         -->

<xsl:param name   = "chapters.select.box.show"
           select = "'true'" />

<xsl:param name   = "chapters.select.box.xml"
           select = "concat($project.root,'/doc/chapters.xml')" />

<xsl:param name   = "chapters.select.box.root"
           select = "concat($project.root,'/libs')" />


<!-- sections.select.box (.show & .xml & .root)
     =======================================================================
     Insert a select box in the banner that allows to jump between sections
     of the current chapter.
                                                                         -->

<xsl:param name   = "sections.select.box.show"
           select = "'true'" />

<xsl:param name   = "sections.select.box.xml"
           select = "'sections.xml'" />

<xsl:param name   = "sections.select.box.root"
           select = "'./'" />

<!-- google.search.box (.show & .xml)
     =======================================================================
     Insert a google search box in the banner. Boostbook use a linked cse
     custom google search page controlled by the .xml definition.
                                                                         -->

<xsl:param name   = "google.search.box.show"
           select = "'true'" />

<xsl:param name   = "google.search.box.xml"
           select = "'http://tinyurl.com/33np8c'" />


<!-- ( top & bottom ) .navigation.bar.show
     =======================================================================
     Insert spirit navigations bars at the top and the bottom of the page
                                                                        -->
<xsl:param name   = "top.navigation.bar.show"
           select = "'true'" />

<xsl:param name   = "bottom.navigation.bar.show"
           select = "'true'" />

<!-- footer.show
     =======================================================================
     Insert a footer with copyright and validation information
                                                                        -->
<xsl:param name   = "footer.show"
           select = "'true'" />


<!-- chapter.logo.img
     =======================================================================
     If defined, include the image pointed by chapter.logo.src in the first
     page of the chapter.
                                                                        -->
<xsl:param name   = "chapter.logo.img"
           select = "''" />


<!-- syntax.switcher ( .show & .xml & .root )
     =======================================================================
     Includes an alternate stylesheets for differents syntax highlighting
     and adds buttons in the corners of code blocks.
                                                                        -->
<xsl:param name   = "syntax.switcher.show"
           select = "'true'" />

<xsl:param name   = "syntax.switcher.xml"
           select = "concat($css.stylesheet.root,'/syntax.xml')" />

<xsl:param name   = "syntax.switcher.root"
           select = "$css.stylesheet.root" />


<!-- quickbook.source.style.show
     =======================================================================
     Includes an alternate stylesheet that allows to see the page as
     quickbook sources. Very useful in translations or when trying to learn
     quickbook.
                                                                        -->
<xsl:param name   = "quickbook.source.style.show"
           select = "'true'" />




</xsl:stylesheet>
