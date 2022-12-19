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
                    margin-left="2cm" 
                    margin-right="2cm">
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
                    <fo:block font-weight="bold" text-align="center" font-size="48px" margin-top="35%">
                        Régularité mensuelle TGV
                    </fo:block>
                    <fo:block text-align="center" font-size="36px" margin-top="5%">
                        <xsl:value-of select="$nom1"/>
                        &amp;
                        <xsl:value-of select="$nom2"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>

            <!-- Corps du document -->
            <fo:page-sequence master-reference="page-unique">
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="right">
                        <fo:page-number/> / <fo:page-number-citation ref-id="last-page"/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">

                    <fo:block break-after="page">
                        <fo:block text-align="center" font-size="28px" font-weight="bold">Sommaire</fo:block>
                        <!-- Pour chaque Axe -->
                        <xsl:for-each select="//axe">
                            
                            <xsl:variable name="axe">
                                <xsl:value-of select="@nom"/>
                            </xsl:variable>

                            <fo:block>
                                <fo:basic-link>
                                    <xsl:attribute name="internal-destination"><xsl:value-of select="$axe"/></xsl:attribute>
                                    <xsl:value-of select="$axe" /> - 
                                    <fo:page-number-citation>
                                        <xsl:attribute name="ref-id"><xsl:value-of select="$axe"/></xsl:attribute>
                                    </fo:page-number-citation>
                                </fo:basic-link>
                            </fo:block>

                            <!-- Pour chaque gare de départ -->
                            <xsl:for-each select="./gare-depart">
                                <xsl:sort select="@nom"/>

                                <!-- Pour chaque gare d'arrivée -->
                                <xsl:for-each select="./gare-arrivee">
                                    <xsl:sort select="@nom"/>

                                    <xsl:variable name="gares-transit">
                                        <xsl:value-of select="ancestor::gare-depart/@nom"/> - <xsl:value-of select="@nom"/>
                                    </xsl:variable>
                                    <fo:block margin-left="32px">
                                        <fo:basic-link>
                                            <xsl:attribute name="internal-destination"><xsl:value-of select="$axe"/><xsl:value-of select="$gares-transit"/></xsl:attribute>
                                            <xsl:value-of select="$gares-transit" /> - 
                                            <fo:page-number-citation>
                                                <xsl:attribute name="ref-id"><xsl:value-of select="$axe"/><xsl:value-of select="$gares-transit"/></xsl:attribute>
                                            </fo:page-number-citation>
                                        </fo:basic-link>
                                    </fo:block>
                                    
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </fo:block>


                    <!-- Pour chaque Axe -->
                    <xsl:for-each select="//axe">
                        <xsl:variable name="axe">
                            <xsl:value-of select="@nom"/>
                        </xsl:variable>

                        <fo:block font-weight="bold" font-size="36px" text-align="center" break-after="page" margin-top="40%">
                            <xsl:attribute name="id"><xsl:value-of select="$axe"/></xsl:attribute>
                            <xsl:value-of select="$axe"/>
                        </fo:block>
                        
                        <!-- Pour chaque gare de départ -->
                        <xsl:for-each select="./gare-depart">
                            <xsl:sort select="@nom"/>

                            <!-- Pour chaque gare d'arrivée -->
                            <xsl:for-each select="./gare-arrivee">
                                <xsl:sort select="@nom"/>

                                <xsl:variable name="gares-transit">
                                    <xsl:value-of select="ancestor::gare-depart/@nom"/> - <xsl:value-of select="@nom"/>
                                </xsl:variable>

                                <fo:block break-after="page">
                                    <xsl:attribute name="id"><xsl:value-of select="$axe"/><xsl:value-of select="$gares-transit"/></xsl:attribute>
                                    <fo:block>
                                        <fo:block text-align="center" font-weight="bold">
                                            <xsl:value-of select="$gares-transit"/>
                                        </fo:block>
                                        <fo:table border="solid black 1px" text-align="center">
                                            <fo:table-header>
                                                <fo:table-row border-bottom="solid black 1px">
                                                    <fo:table-cell border-right="solid black 1px"><fo:block>Date</fo:block></fo:table-cell>
                                                    <fo:table-cell border-right="solid black 1px"><fo:block>Trains prévus</fo:block></fo:table-cell>
                                                    <fo:table-cell border-right="solid black 1px"><fo:block>Trains partis</fo:block></fo:table-cell>
                                                    <fo:table-cell border-right="solid black 1px"><fo:block>Annulés</fo:block></fo:table-cell>
                                                    <fo:table-cell border-right="solid black 1px"><fo:block>Retards</fo:block></fo:table-cell>
                                                    <fo:table-cell><fo:block>Régularité</fo:block></fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-header>
                                            <fo:table-body>
                                                <!-- Pour chaque mesure -->
                                                <xsl:for-each select="./mesure">
                                                    <xsl:sort select="@annee"/>
                                                    <xsl:sort select="@mois"/>
                                                    <xsl:variable name="date">
                                                        <xsl:value-of select="@mois"/>/<xsl:value-of select="@annee"/>
                                                    </xsl:variable>
                                                    <fo:table-row border-bottom="solid #AAA 1px">
                                                        <fo:table-cell border-right="solid black 1px"><fo:block><xsl:value-of select="$date"/></fo:block></fo:table-cell>
                                                        <fo:table-cell border-right="solid black 1px"><fo:block><xsl:value-of select="@trains-prevus"/></fo:block></fo:table-cell>
                                                        <fo:table-cell border-right="solid black 1px"><fo:block><xsl:value-of select="@trains-ok"/></fo:block></fo:table-cell>
                                                        <fo:table-cell border-right="solid black 1px"><fo:block><xsl:value-of select="@annules"/></fo:block></fo:table-cell>
                                                        <fo:table-cell border-right="solid black 1px"><fo:block><xsl:value-of select="@retards"/></fo:block></fo:table-cell>
                                                        <fo:table-cell><fo:block><xsl:value-of select="@regularite"/></fo:block></fo:table-cell>
                                                    </fo:table-row>
                                                </xsl:for-each>
                                            </fo:table-body>
                                        </fo:table>
                                    </fo:block>
                                    <fo:block text-align="center">
                                        <fo:instream-foreign-object width="500" height="153">
                                            <svg xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" width="500" height="153" viewBox="0 0 500 153">
                                                <xsl:for-each select="./mesure">
                                                    <xsl:sort select="@annee"/>
                                                    <xsl:sort select="@mois"/>
                                                    <xsl:variable name="date">
                                                        <xsl:value-of select="@mois"/>/<xsl:value-of select="@annee"/>
                                                    </xsl:variable>
                                                    <rect x="{10*position() + 30}" width="10" fill="red" stroke="black">
                                                        <xsl:attribute name="y"><xsl:value-of select="103 - round(@regularite)"/></xsl:attribute>
                                                        <xsl:attribute name="height"><xsl:value-of select="round(@regularite)"/></xsl:attribute>
                                                        
                                                        <xsl:if test="@regularite &gt;= 80">
                                                            <xsl:attribute name="fill">orange</xsl:attribute>
                                                        </xsl:if>
                                                        <xsl:if test="@regularite &gt;= 90">
                                                            <xsl:attribute name="fill">green</xsl:attribute>
                                                        </xsl:if>
                                                    </rect> 
                                                    <text x="{10*position()+3}" y="103" transform="rotate(-70, {10*position() + 40}, 103)"><xsl:value-of select="$date"/></text>
                                                </xsl:for-each>
                                                <line x1="25" y1="3" x2="500" y2="3" stroke="black"/>
                                                <text x="0" y="6">100%</text>
                                                <line x1="25" y1="13" x2="500" y2="13" stroke="black"/>
                                                <text x="0" y="16">90%</text>
                                                <line x1="25" y1="23" x2="500" y2="23" stroke="black"/>
                                                <text x="0" y="26">80%</text>
                                                <line x1="25" y1="103" x2="500" y2="103" stroke="black"/>
                                                <text x="0" y="103">0%</text>
                                            </svg>
                                        </fo:instream-foreign-object>
                                    </fo:block>
                                    <fo:block>
                                        <fo:block font-style="italic" text-decoration="underline">Commentaires : </fo:block>
                                        <xsl:for-each select="./mesure">
                                            <xsl:sort select="@annee"/>
                                            <xsl:sort select="@mois"/>
                                            <xsl:variable name="date">
                                                <xsl:value-of select="@mois"/>/<xsl:value-of select="@annee"/>
                                            </xsl:variable>
                                            <xsl:if test="@commentaire!=''">
                                                <fo:block font-size="9px"><xsl:value-of select="$date"/> : <xsl:value-of select="@commentaire"/></fo:block>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </fo:block>
                                </fo:block>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:for-each>
                    <fo:block id="last-page"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>