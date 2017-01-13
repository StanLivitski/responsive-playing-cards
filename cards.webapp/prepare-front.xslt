<?xml version="1.0" encoding="utf-8" ?>
<!--
    Copyright © 2017 Stan Livitski

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License  as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 -->

<!-- 
*****************************************************************************
XSL transformation that changes an upstream front image of a card as follows:

 - Small version of the card image is removed.
 - Height of the image is reset using the `height` parameter that defaults
   to 318, which results in aspect ratio of the image of 1:sqrt(2).
 - The image is centered within the new canvas by applying SVG transformation
   from the `image-transform` paremeter, which by default moves it down 2
   pixels.
 - White rectangular frame is replaced with a shape and style specified by
   the `frame-path-data` and `frame-style` parameters. Defaults create a
   frame with smooth corners and a thin black border.

This should work with both minified and unminified images. However, some
SVG viewers may not render minified images properly, even before the
transformation.
*****************************************************************************
-->
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
 xmlns:svg="http://www.w3.org/2000/svg"
>

 <xsl:param name="height" select="318" />
 <xsl:param name="frame-style">fill:<xsl:value-of select="/svg:svg/svg:rect[@width='100%' and @height='100%']/@fill" />;stroke:#000000;stroke-width:0.5;</xsl:param>
 <xsl:param name="frame-path-data">M0,10C0.3,4.5,4.5,0.3,9.6,0.3h204c4.5,0.3,9,4.5,9.4,9v298c-0.3,4.5,-4.5,9,-9.4,9H10c-4.5,-0.3,-9.4,-4.5,-9.6,-9z</xsl:param>
 <xsl:param name="image-transform">translate(0,2)</xsl:param>

 <xsl:output method="xml" indent="no" />

 <xsl:variable name="minified" select="not(/svg:svg/comment()[1])" />

 <xsl:template match="/svg:svg/svg:defs/svg:style|svg:g[@class='mini-card']|comment()[following-sibling::svg:g[position()=1 and @class='mini-card']]|text()[following-sibling::svg:rect[position()=1 and @width='100%' and @height='100%']]"><!-- omit these elements --></xsl:template>

 <xsl:template match="/svg:svg">
  <xsl:copy><xsl:apply-templates select="@*" /><!-- set viewBox="0 0 @width $height" --><xsl:attribute name="viewBox">0 0 <xsl:choose><xsl:when test="contains(@width,'px')"><xsl:value-of select="substring-before(@width,'px')" /></xsl:when><xsl:otherwise><xsl:value-of select="@width" /></xsl:otherwise></xsl:choose><xsl:text> </xsl:text><xsl:value-of select="$height" /></xsl:attribute><!-- set height="{$height}px" --><xsl:attribute name="height"><xsl:value-of select="$height" /><xsl:if test="not($minified)">px</xsl:if></xsl:attribute>
  <xsl:apply-templates select="node()" /></xsl:copy>
 </xsl:template>

 <xsl:template match="svg:g[@class='maxi-card']">
  <xsl:copy><xsl:apply-templates select="@*" /><!-- add transform="translate(0,2)" --><xsl:attribute name="transform"><xsl:value-of select="$image-transform" /><xsl:if test="@transform"> </xsl:if><xsl:value-of select="@transform" /></xsl:attribute>
  <xsl:apply-templates select="node()" /></xsl:copy>
 </xsl:template>

 <xsl:template match="/svg:svg/svg:rect[@width='100%' and @height='100%']">
  <xsl:if test="not($minified)">
   <xsl:text>
    
    </xsl:text>
   <xsl:comment> Background frame </xsl:comment>
  <xsl:text>
    </xsl:text>
  </xsl:if>
  <xsl:element name="path" namespace="http://www.w3.org/2000/svg">
   <xsl:attribute name="style"><xsl:value-of select="$frame-style" /></xsl:attribute>
   <xsl:attribute name="d"><xsl:value-of select="$frame-path-data" /></xsl:attribute>
  </xsl:element>
 </xsl:template>

 <xsl:template match="@*|node()"><xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy></xsl:template>

</xsl:transform>