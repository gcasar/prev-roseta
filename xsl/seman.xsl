<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="report">
    <html>
      <style>
        body { font-family: Arial, Helvetica, sans-serif;}
        node {display: table-cell; padding: 4pt; text-align: center}
        leaf {display: block; background-color: #FCF265; padding: 4pt}
        children {display: table}
        more {display: block; background-color: #eee; padding-bottom: 4pt; cursor: pointer}
        more::before {content: "&#8230;"}

        node:not(hover) > leaf {border: 1pt solid transparent;}
        node:hover > leaf {border: 1pt solid red;}

        leaf[collapsed] ~ children{display: none}
        leaf:not([collapsed]) ~ more{display: none}

        type { font-weight: 600; }
        constant { font-family: "Courier New", Courier, monospace }
        position { font-family: "Courier New", Courier, monospace; white-space: nowrap; display: block}

        seman { display: block; background-color: #d4ca90; font-size: 0.8em; }
      </style>
      <body>
        <xsl:apply-templates select="ast"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="ast">
    <node>
      <leaf onclick="this.toggleAttribute('collapsed')">
        <type>
          <xsl:value-of select="@kind"/>
        </type>
        <xsl:if test="@name!=''">
          <constant>
            <xsl:text>=</xsl:text>
            <xsl:value-of select="@name"/>
          </constant>
        </xsl:if>
        <xsl:apply-templates select="position"/>
        <xsl:apply-templates select="seman"/>
      </leaf>
      <xsl:if test="ast">
        <more onclick="this.previousSibling.toggleAttribute('collapsed')"/>
        <children>
          <xsl:apply-templates select="ast"/>
        </children>
      </xsl:if>
    </node>
  </xsl:template>

  <xsl:template match="position">
    <position>
      <xsl:value-of select="@begLine"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="@begColumn"/>
      <xsl:text>-</xsl:text>
      <xsl:value-of select="@endLine"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="@endColumn"/>
    </position>
  </xsl:template>

  <xsl:template match="seman">
    <seman>
      <xsl:if test="@value!=''">
        <span style="white-space:nowrap">
          <xsl:text>value=</xsl:text>
          <xsl:value-of select="@value"/>
        </span>
      </xsl:if>
      <xsl:if test="@mem!=''">
        <span style="white-space:nowrap">
          <xsl:text>mem</xsl:text>
        </span>
      </xsl:if>
      <xsl:if test="@decl!=''">
        <span style="white-space:nowrap">
          <xsl:text>@</xsl:text>
          <xsl:value-of select="@decl"/>
        </span>
      </xsl:if>
      <xsl:apply-templates select="typ"/>
    </seman>
  </xsl:template>

  <xsl:template match="typ">
    <div>
      <xsl:value-of select="@kind"/>
      <xsl:apply-templates select="typ"/>
    </div>
  </xsl:template>

</xsl:stylesheet>
