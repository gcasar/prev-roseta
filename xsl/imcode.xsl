<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="report">
    <html>
      <style>
        tr, td {
        text-align: center;
        vertical-align: top;
        }
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
        <xsl:apply-templates select="frame"/>
        <xsl:apply-templates select="access"/>
        <xsl:apply-templates select="fragment"/>
        <xsl:apply-templates select="imcode"/>
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

  <xsl:template match="frame">
    <table style="width:100%;width:100%;font-size:80%">
      <tr style="background-color:#E8C31A">
        <td>
          <text>&#xA0;</text>
          <span style="white-space:nowrap">
            <xsl:text>level=</xsl:text>
            <xsl:value-of select="@level"/>
            <text>&#xA0;</text>
            <xsl:text>label=</xsl:text>
            <xsl:value-of select="@label"/>
            <text>&#xA0;</text>
            <xsl:text>size=</xsl:text>
            <xsl:value-of select="@size"/>
          </span>
          <text>&#xA0;</text>
        </td>
      </tr>
      <tr style="background-color:#E8C31A">
        <td>
          <text>&#xA0;</text>
          <span style="white-space:nowrap">
            <xsl:text>inpCall=</xsl:text>
            <xsl:value-of select="@inpCallSize"/>
            <text>&#xA0;</text>
            <xsl:text>locVars=</xsl:text>
            <xsl:value-of select="@locVarsSize"/>
            <text>&#xA0;</text>
            <xsl:text>tmpVars=</xsl:text>
            <xsl:value-of select="@tmpVarsSize"/>
            <text>&#xA0;</text>
            <xsl:text>hidRegs=</xsl:text>
            <xsl:value-of select="@hidRegsSize"/>
            <text>&#xA0;</text>
            <xsl:text>outCall=</xsl:text>
            <xsl:value-of select="@outCallSize"/>
          </span>
          <text>&#xA0;</text>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="access">
    <table style="width:100%;width:100%;font-size:80%">
      <tr style="background-color:#E8C31A">
        <td>
          <text>&#xA0;</text>
          <span style="white-space:nowrap">
            <xsl:if test="@level!=''">
              <xsl:text>level=</xsl:text>
              <xsl:value-of select="@level"/>
              <text>&#xA0;</text>
            </xsl:if>
            <xsl:if test="@label!=''">
              <xsl:text>label=</xsl:text>
              <xsl:value-of select="@label"/>
              <text>&#xA0;</text>
            </xsl:if>
            <xsl:if test="@offset!=''">
              <xsl:text>offset=</xsl:text>
              <xsl:value-of select="@offset"/>
              <text>&#xA0;</text>
            </xsl:if>
            <xsl:text>size=</xsl:text>
            <xsl:value-of select="@size"/>
          </span>
          <text>&#xA0;</text>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="fragment">
    <table style="width:100%;background-color:#1FB1FE;border:3px solid #FCF265;font-size:80%">
      <tr>
        <xsl:apply-templates select="frg"/>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="frg">
    <td>
      <table style="width:100%;font-size:100%">
        <tr>
          <td colspan="100">
            <span style="white-space:nowrap">
              <text>&#xA0;</text>
              <xsl:value-of select="@kind"/>
              <text>&#xA0;</text>
            </span>
          </td>
        </tr>
        <tr>
          <xsl:apply-templates select="imc"/>
        </tr>
      </table>
    </td>
  </xsl:template>

  <xsl:template match="imcode">
    <table style="width:100%;background-color:#8CD5FE;border:3px solid #FCF265;width:100%;font-size:80%">
      <tr>
        <xsl:apply-templates select="imc"/>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="imc">
    <td>
      <table style="width:100%;border:1px solid black;width:100%;font-size:100%">
        <tr>
          <td colspan="100">
            <span style="white-space:nowrap">
              <text>&#xA0;</text>
              <xsl:value-of select="@kind"/>
              <text>&#xA0;</text>
            </span>
          </td>
        </tr>
        <tr>
          <xsl:apply-templates select="imc"/>
        </tr>
      </table>
    </td>
  </xsl:template>

  <xsl:template match="position">
    <span style="white-space:nowrap">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="@begLine"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="@begColumn"/>
      <xsl:text>-</xsl:text>
      <xsl:value-of select="@endLine"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="@endColumn"/>
      <xsl:text>]</xsl:text>
    </span>
  </xsl:template>

</xsl:stylesheet>
