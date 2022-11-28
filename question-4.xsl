<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:output encoding="utf8" indent="yes"/>
    <xsl:template match="/regularite-tgv">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master 
                    master-name="page-unique"
                    page-height="29.7cm" 
                    page-width="21cm"
                    margin-top="1.5cm" 
                    margin-bottom="2cm"
                    margin-left="2.5cm" 
                    margin-right="1cm">
                    <fo:region-body background-color="#FFFFFF"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="page-unique">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:for-each select="//axe">
                            <fo:block font-weight="bold">
                                <xsl:value-of select="@nom"/>
                            </fo:block>
                    </xsl:for-each>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>