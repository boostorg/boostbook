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

<!--========================================================================
    Docbook parameters
    These params overwrite docbook default parameters
==========================================================================-->



<xsl:param name="html.stylesheet" select="$boostbook.main.css" />

<!-- Callouts graphics may pass to css control in the future -->
<xsl:param name="callout.graphics.path" select="concat($css.stylesheet.root,'/images/callouts/')"/>


<xsl:param name="generate.section.toc.level"    select="3"     />
<xsl:param name="toc.max.depth"                 select="2"     />
<xsl:param name="admon.graphics"                select="1"     />
<xsl:param name="chapter.autolabel"             select="1"     />
<xsl:param name="css.decoration"                select="0"     />
<xsl:param name="use.id.as.filename"            select="1"     />
<xsl:param name="refentry.generate.name"        select="0"     />
<xsl:param name="refentry.generate.title"       select="1"     />
<xsl:param name="make.year.ranges"              select="1"     />
<xsl:param name="generate.manifest"             select="1"     />
<xsl:param name="chunker.output.indent"         select="'yes'" />
<xsl:param name="callout.graphics.number.limit" select="15"    />

<xsl:param name="admon.style">
    <!-- Remove the style. Let the CSS do the styling -->
</xsl:param>


</xsl:stylesheet>
