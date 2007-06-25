<?xml version="1.0" encoding="utf-8"?>
<!--
   Copyright (c) 2007 Matias Capeletto

   Distributed under the Boost Software License, Version 1.0.
   (See accompanying file LICENSE_1_0.txt or copy at
   http://www.boost.org/LICENSE_1_0.txt)
  -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

<xsl:template name="box.wrapper.decoration">
  <xsl:param name="content" />
  <div class="box-outer-wrapper">
    <div class="box-top-left" />
    <div class="box-top-right" />
    <div class="box-top" />
    <div class="box-inner-wrapper">
      <xsl:copy-of select="$content" />
    </div>
    <div class="box-bottom-left" />
    <div class="box-bottom-right" />
    <div class="box-bottom" />
  </div>
</xsl:template>



</xsl:stylesheet>