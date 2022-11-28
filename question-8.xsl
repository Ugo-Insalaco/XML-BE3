<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:output encoding="utf8" indent="yes"/>
<xsl:param name="nom1" />
<xsl:param name="nom2" />
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
                    <fo:region-after background-color="#FFFFFF"/>
                </fo:simple-page-master>

            </fo:layout-master-set>
            <!-- Page de garde -->
            <fo:page-sequence master-reference="page-unique">
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block font-weight="bold">
                    - Page <fo:page-number/> -
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-weight="bold">
                        Régularité mensuelle TGV
                    </fo:block>
                    <fo:block>
                        <xsl:value-of select="$nom1"/>
                        &amp;
                        <xsl:value-of select="$nom2"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>

            <!-- Corps du document -->
            <fo:page-sequence master-reference="page-unique">
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block font-weight="bold">
                    - Page <fo:page-number/> -
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">

                    <!-- Pour chaque Axe -->
                    <xsl:for-each select="//axe">
                        <fo:block font-weight="bold">
                            <xsl:value-of select="@nom"/>
                        </fo:block>
                        
                        <!-- Pour chaque gare de départ -->
                        <xsl:for-each select="./gare-depart">
                            <xsl:sort select="@nom"/>

                            <!-- Pour chaque gare d'arrivée -->
                            <xsl:for-each select="./gare-arrivee">
                                <xsl:sort select="@nom"/>
                                <fo:block>
                                    <xsl:value-of select="ancestor::gare-depart/@nom"/> - <xsl:value-of select="@nom"/>
                                </fo:block>
                                <fo:table>
                                    <fo:table-body>
                                        <!-- Pour chaque mesure -->
                                        <xsl:for-each select="./mesure">
                                            <xsl:sort select="@annee"/>
                                            <xsl:sort select="@mois"/>
                                            <xsl:variable name="date">
                                                <xsl:value-of select="@mois"/>/<xsl:value-of select="@annee"/>
                                            </xsl:variable>
                                            <fo:table-row>
                                                <fo:table-cell><fo:block><xsl:value-of select="$date"/></fo:block></fo:table-cell>
                                                <fo:table-cell><fo:block><xsl:value-of select="@trains-prevus"/></fo:block></fo:table-cell>
                                                <fo:table-cell><fo:block><xsl:value-of select="@trains-ok"/></fo:block></fo:table-cell>
                                                <fo:table-cell><fo:block><xsl:value-of select="@annules"/></fo:block></fo:table-cell>
                                                <fo:table-cell><fo:block><xsl:value-of select="@retards"/></fo:block></fo:table-cell>
                                                <fo:table-cell><fo:block><xsl:value-of select="@regularite"/></fo:block></fo:table-cell>
                                            </fo:table-row>
                                        </xsl:for-each>
                                    </fo:table-body>
                                </fo:table>
                                <fo:block>Commentaires : </fo:block>
                                <xsl:for-each select="./mesure">
                                    <xsl:sort select="@annee"/>
                                    <xsl:sort select="@mois"/>
                                    <xsl:variable name="date">
                                        <xsl:value-of select="@mois"/>/<xsl:value-of select="@annee"/>
                                    </xsl:variable>
                                    <xsl:if test="@commentaire!=''">
                                        <fo:block><xsl:value-of select="$date"/> : <xsl:value-of select="@commentaire"/></fo:block>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:for-each>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>