<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="report">
    <html>
      <style>
        node {display: table-cell; padding: 4pt; text-align: center}
        leaf {display: block; background-color: #FCF265; padding: 4pt}
        children {display: table}

        node:not(hover) {border: 1pt solid transparent;}
        node:hover {border: 1pt solid red;}

        leaf[collapsed] {background-color: #eCe265;}
        leaf[collapsed] + children{display: none}

        type { font-family: Arial, Helvetica, sans-serif; font-weight: 600; }
        constant { font-family: "Courier New", Courier, monospace }
        position { font-family: "Courier New", Courier, monospace; white-space: nowrap; display: block}
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
      </leaf>
      <children>
        <xsl:apply-templates select="ast"/>
      </children>
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

</xsl:stylesheet>
