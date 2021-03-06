<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1"
		xmlns:ddue="http://ddue.schemas.microsoft.com/authoring/2003/5"
		xmlns:xlink="http://www.w3.org/1999/xlink"
		xmlns:mshelp="http://msdn.microsoft.com/mshelp" >

	<!-- sections -->

	<xsl:template match="ddue:summary">
		<div class="summary">
			<xsl:apply-templates />
		</div>
	</xsl:template>

  <xsl:template match="@address">
    <a name="{string(.)}" />
  </xsl:template>

  <!-- block elements -->

	<xsl:template match="ddue:para">
		<p><xsl:apply-templates /></p>
	</xsl:template>

	<xsl:template match="ddue:list">
		<xsl:choose>
			<xsl:when test="@class='bullet'">
				<ul>
					<xsl:apply-templates select="ddue:listItem" />
				</ul>
			</xsl:when>
			<xsl:when test="@class='ordered'">
				<ol>
					<xsl:apply-templates select="ddue:listItem" />
				</ol>
			</xsl:when>
			<xsl:otherwise>
				<span class="processingError">Unknown List Class</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="ddue:listItem">
		<li>
			<xsl:apply-templates />
		</li>
	</xsl:template>		

	<!-- inline elements -->

	<xsl:template match="ddue:parameterReference">
    <xsl:if test="normalize-space(.)">
      <span class="parameter">
        <xsl:value-of select="." />
      </span>
    </xsl:if>	</xsl:template>

	<xsl:template match="ddue:ui">
    <xsl:if test="normalize-space(.)">
      <span class="ui"><xsl:value-of select="." /></span>
    </xsl:if>
	</xsl:template>

	<xsl:template match="ddue:userInput | ddue:userInputLocalizable">
    <xsl:if test="normalize-space(.)">
      <span class="input"><xsl:value-of select="." />
      </span>
    </xsl:if>
	</xsl:template>

	<xsl:template match="ddue:newTerm">
    <xsl:if test="normalize-space(.)">
      <span class="term"><xsl:value-of select="." /></span>
    </xsl:if>
	</xsl:template>

	<xsl:template match="ddue:math">
    <xsl:if test="normalize-space(.)">
      <span class="math"><xsl:value-of select="." /></span>
    </xsl:if>
	</xsl:template>

	<xsl:template match="ddue:codeInline">
    <xsl:if test="normalize-space(.)">
      <span class="code"><xsl:value-of select="." /></span>
    </xsl:if>
	</xsl:template>

	<xsl:template match="ddue:subscript | ddue:subscriptType">
    <xsl:if test="normalize-space(.)">
      <sub><xsl:value-of select="." /></sub>
    </xsl:if>
	</xsl:template>

	<xsl:template match="ddue:superscript | ddue:superscriptType">
    <xsl:if test="normalize-space(.)">
      <sup><xsl:value-of select="." /></sup>
    </xsl:if>
	</xsl:template>

	<xsl:template match="ddue:legacyBold">
    <xsl:if test="normalize-space(.)">
      <b><xsl:apply-templates /></b>
    </xsl:if>
	</xsl:template>

	<xsl:template match="ddue:legacyItalic">
    <xsl:if test="normalize-space(.)">
      <i><xsl:apply-templates /></i>
    </xsl:if>
	</xsl:template>

	<xsl:template match="ddue:legacyUnderline">
    <xsl:if test="normalize-space(.)">
      <u><xsl:apply-templates /></u>
    </xsl:if>
	</xsl:template>

	<xsl:template match="ddue:embeddedLabel">
    <xsl:if test="normalize-space(.)">
      <span class="label"><xsl:value-of select="." /></span>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ddue:quote">
    <xsl:if test="normalize-space(.)">
      <blockQuote><xsl:apply-templates/></blockQuote>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ddue:quoteInline">
    <xsl:if test="normalize-space(.)">
      <q><xsl:apply-templates/></q>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ddue:date">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ddue:foreignPhrase">
    <xsl:if test="normalize-space(.)">
      <span class="foreignPhrase"><xsl:apply-templates/></span>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ddue:phrase">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ddue:system">
    <xsl:if test="normalize-space(.)">
      <b><xsl:apply-templates/></b>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ddue:placeholder">
    <xsl:if test="normalize-space(.)">
      <span class="placeholder"><xsl:apply-templates/></span>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ddue:copyright">
    <p>
      &amp;copyright; <xsl:value-of select="holder"/> <xsl:value-of select="trademark"/>
      <xsl:for-each select="year">
        <xsl:value-of select="."/>
      </xsl:for-each>
    </p>
  </xsl:template>

  <xsl:template match="ddue:corporation">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ddue:country">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ddue:unmanagedCodeEntityReference">
    <xsl:if test="normalize-space(.)">
      <b><xsl:apply-templates/></b>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ddue:localizedText">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- links -->

	<xsl:template match="ddue:externalLink">
		<a>
			<xsl:attribute name="href"><xsl:value-of select="ddue:linkUri" /></xsl:attribute>
			<xsl:value-of select="ddue:linkText" />
		</a>
	</xsl:template>

	<!-- fail if any unknown elements are encountered -->
<!--
	<xsl:template match="*">
		<xsl:message terminate="yes">
			<xsl:text>An unknown element was encountered.</xsl:text>
		</xsl:message>
	</xsl:template>
-->


</xsl:stylesheet>
