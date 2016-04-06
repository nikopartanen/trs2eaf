<?xml version="1.0" encoding="UTF-8"?>
<!-- working with EOPAS 2.0 Schema -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dc="http://purl.org/dc/elements/1.1/" version="1.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="mediafile" select="/Trans/@audio_filename"/>
    <xsl:param name="creator" select="/Trans/@scribe"/>
    <xsl:variable name="Participant" select="/Trans/Speakers/Speaker/@id"/>
    <xsl:template match="/Trans">
        <ANNOTATION_DOCUMENT AUTHOR="unspecified" DATE="2014-09-08T16:00:59+01:00" FORMAT="2.8"
            VERSION="2.8" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:noNamespaceSchemaLocation="http://www.mpi.nl/tools/elan/EAFv2.8.xsd">
            <HEADER MEDIA_FILE="" TIME_UNITS="milliseconds">
                <MEDIA_DESCRIPTOR MEDIA_URL="file:///Users/niko/github/oulu_elan/trs/a324_26.wav"
                    MIME_TYPE="audio/x-wav" RELATIVE_MEDIA_URL="./a324_26.wav"/>
                <PROPERTY NAME="URN"
                    >urn:nl-mpi-tools-elan-eaf:61ee3117-e199-49ca-8258-9415d9cf90e1</PROPERTY>
                <PROPERTY NAME="lastUsedAnnotationId">1</PROPERTY>
            </HEADER>
            <TIME_ORDER>
                <xsl:for-each select="//Sync">
                    <TIME_SLOT TIME_SLOT_ID="ts{position()}">
                        <xsl:attribute name="TIME_VALUE">
                            <xsl:value-of select="round(@time * 1000)"/>
                        </xsl:attribute>
                    </TIME_SLOT>
                    <TIME_SLOT TIME_SLOT_ID="ts{position() + 1}">
                        <xsl:attribute name="TIME_VALUE">
                            <xsl:value-of select="round(@time * 1000)"/>
                        </xsl:attribute>
                    </TIME_SLOT>
                </xsl:for-each>
            </TIME_ORDER>
            <TIER DEFAULT_LOCALE="en" LINGUISTIC_TYPE_REF="speech" PARTICIPANT="{$Participant}"
                TIER_ID="{$Participant} Speech">
                <xsl:for-each select="Episode/Section/Turn">

                    <xsl:for-each select="Sync">
                        <xsl:if test="following-sibling::node()">
                            <xsl:if test="name(following-sibling::node())!='Sync'">

                                <ANNOTATION>
                                    <ALIGNABLE_ANNOTATION>
                                        <xsl:attribute name="ANNOTATION_ID">a<xsl:value-of
                                            select="count(preceding::Sync) + 1"/></xsl:attribute>
                                        <xsl:attribute name="TIME_SLOT_REF1">ts<xsl:value-of
                                            select="count(preceding::Sync) + 1"/></xsl:attribute>
                                        <xsl:attribute name="TIME_SLOT_REF2">ts<xsl:value-of
                                            select="count(preceding::Sync) + 2"/></xsl:attribute>
                                        <ANNOTATION_VALUE>
                                            <xsl:value-of
                                                select="replace(replace(replace(normalize-space((following-sibling::text())), 'w', 'š'),
                                                                                                                      'q', 'á'),
                                                                                                                      'x', 'č')"/>
                                            <xsl:if test="name(following-sibling::node())='Comment'"
                                                >[<xsl:value-of
                                                select="(following-sibling::Comment)[1]/@desc"
                                                />]</xsl:if>
                                            <xsl:if test="name(following-sibling::node())='Event'"
                                                >[<xsl:value-of
                                                select="(following-sibling::Event)[1]/@desc"
                                                /> - <xsl:value-of
                                                select="(following-sibling::Event)[1]/@extent"
                                                />]</xsl:if>
                                        </ANNOTATION_VALUE>
                                    </ALIGNABLE_ANNOTATION>
                                </ANNOTATION>

                            </xsl:if>
                        </xsl:if>
                    </xsl:for-each>

                </xsl:for-each>
            </TIER>
            <TIER DEFAULT_LOCALE="en" LINGUISTIC_TYPE_REF="speech" PARTICIPANT="{$Participant}"
                TIER_ID="{$Participant} Speech"/>
            <TIER DEFAULT_LOCALE="en" LINGUISTIC_TYPE_REF="word token"
                PARENT_REF="{$Participant} Speech" PARTICIPANT="{$Participant}"
                TIER_ID="{$Participant} Words"/>
            <TIER DEFAULT_LOCALE="en" LINGUISTIC_TYPE_REF="Finnish translation"
                PARENT_REF="{$Participant} Speech" PARTICIPANT="{$Participant}"
                TIER_ID="{$Participant} Finnish"/>
            <TIER DEFAULT_LOCALE="en" LINGUISTIC_TYPE_REF="English translation"
                PARENT_REF="{$Participant} Speech" PARTICIPANT="{$Participant}"
                TIER_ID="{$Participant} English"/>
            <TIER DEFAULT_LOCALE="en" LINGUISTIC_TYPE_REF="morphology"
                PARENT_REF="{$Participant} Words" PARTICIPANT="{$Participant}"
                TIER_ID="{$Participant} Morphology"/>
            <TIER DEFAULT_LOCALE="en" LINGUISTIC_TYPE_REF="syntactic function"
                PARENT_REF="{$Participant} Words" PARTICIPANT="{$Participant}"
                TIER_ID="{$Participant} Syntax"/>
            <LINGUISTIC_TYPE GRAPHIC_REFERENCES="false" LINGUISTIC_TYPE_ID="default-lt"
                TIME_ALIGNABLE="true"/>
            <LINGUISTIC_TYPE GRAPHIC_REFERENCES="false" LINGUISTIC_TYPE_ID="speech"
                TIME_ALIGNABLE="true"/>
            <LINGUISTIC_TYPE CONSTRAINTS="Symbolic_Subdivision" GRAPHIC_REFERENCES="false"
                LINGUISTIC_TYPE_ID="word token" TIME_ALIGNABLE="false"/>
            <LINGUISTIC_TYPE CONSTRAINTS="Symbolic_Association" GRAPHIC_REFERENCES="false"
                LINGUISTIC_TYPE_ID="Finnish translation" TIME_ALIGNABLE="false"/>
            <LINGUISTIC_TYPE CONSTRAINTS="Symbolic_Association" GRAPHIC_REFERENCES="false"
                LINGUISTIC_TYPE_ID="English translation" TIME_ALIGNABLE="false"/>
            <LINGUISTIC_TYPE CONSTRAINTS="Symbolic_Association" GRAPHIC_REFERENCES="false"
                LINGUISTIC_TYPE_ID="morphology" TIME_ALIGNABLE="false"/>
            <LINGUISTIC_TYPE CONSTRAINTS="Symbolic_Association" GRAPHIC_REFERENCES="false"
                LINGUISTIC_TYPE_ID="syntactic function" TIME_ALIGNABLE="false"/>
            <LINGUISTIC_TYPE CONSTRAINTS="Symbolic_Subdivision" GRAPHIC_REFERENCES="false"
                LINGUISTIC_TYPE_ID="lemma" TIME_ALIGNABLE="false"/>
            <LINGUISTIC_TYPE CONSTRAINTS="Symbolic_Subdivision" GRAPHIC_REFERENCES="false"
                LINGUISTIC_TYPE_ID="pos" TIME_ALIGNABLE="false"/>
            <LINGUISTIC_TYPE CONSTRAINTS="Symbolic_Subdivision" GRAPHIC_REFERENCES="false"
                LINGUISTIC_TYPE_ID="morph" TIME_ALIGNABLE="false"/>
            <LOCALE COUNTRY_CODE="US" LANGUAGE_CODE="en"/>
            <CONSTRAINT
                DESCRIPTION="Time subdivision of parent annotation's time interval, no time gaps allowed within this interval"
                STEREOTYPE="Time_Subdivision"/>
            <CONSTRAINT
                DESCRIPTION="Symbolic subdivision of a parent annotation. Annotations refering to the same parent are ordered"
                STEREOTYPE="Symbolic_Subdivision"/>
            <CONSTRAINT DESCRIPTION="1-1 association with a parent annotation"
                STEREOTYPE="Symbolic_Association"/>
            <CONSTRAINT
                DESCRIPTION="Time alignable annotations within the parent annotation's time interval, gaps are allowed"
                STEREOTYPE="Included_In"/>
            <CONTROLLED_VOCABULARY CV_ID="lg">
                <DESCRIPTION LANG_REF="und">language</DESCRIPTION>
                <CV_ENTRY_ML CVE_ID="cveid0">
                    <CVE_VALUE DESCRIPTION="German" LANG_REF="und">deu</CVE_VALUE>
                </CV_ENTRY_ML>
                <CV_ENTRY_ML CVE_ID="cveid1">
                    <CVE_VALUE DESCRIPTION="Norwegian" LANG_REF="und">nob</CVE_VALUE>
                </CV_ENTRY_ML>
                <CV_ENTRY_ML CVE_ID="cveid2">
                    <CVE_VALUE DESCRIPTION="English" LANG_REF="und">eng</CVE_VALUE>
                </CV_ENTRY_ML>
                <CV_ENTRY_ML CVE_ID="cveid3">
                    <CVE_VALUE DESCRIPTION="Russian" LANG_REF="und">rus</CVE_VALUE>
                </CV_ENTRY_ML>
                <CV_ENTRY_ML CVE_ID="cveid4">
                    <CVE_VALUE DESCRIPTION="Swedish" LANG_REF="und">swe</CVE_VALUE>
                </CV_ENTRY_ML>
                <CV_ENTRY_ML CVE_ID="cveid5">
                    <CVE_VALUE DESCRIPTION="Kildin Saami" LANG_REF="und">sjd</CVE_VALUE>
                </CV_ENTRY_ML>
                <CV_ENTRY_ML CVE_ID="cveid6">
                    <CVE_VALUE DESCRIPTION="Ter Saami" LANG_REF="und">sjt</CVE_VALUE>
                </CV_ENTRY_ML>
                <CV_ENTRY_ML CVE_ID="cveid7">
                    <CVE_VALUE DESCRIPTION="Pite Saami" LANG_REF="und">sje</CVE_VALUE>
                </CV_ENTRY_ML>
                <CV_ENTRY_ML CVE_ID="cveid8">
                    <CVE_VALUE DESCRIPTION="Lule Saami" LANG_REF="und">smj</CVE_VALUE>
                </CV_ENTRY_ML>
                <CV_ENTRY_ML CVE_ID="cveid9">
                    <CVE_VALUE DESCRIPTION="North Saami" LANG_REF="und">sme</CVE_VALUE>
                </CV_ENTRY_ML>
                <CV_ENTRY_ML CVE_ID="cveid10">
                    <CVE_VALUE DESCRIPTION="Komi-Zyrian" LANG_REF="und">kpv</CVE_VALUE>
                </CV_ENTRY_ML>
            </CONTROLLED_VOCABULARY>
            <EXTERNAL_REF EXT_REF_ID="er1" TYPE="iso12620"
                VALUE="http://www.isocat.org/datcat/DC-2523"/>
        </ANNOTATION_DOCUMENT>
    </xsl:template>
</xsl:stylesheet>
