<!--

Helpful references:

XSLT3.0: https://www.w3.org/TR/xslt-30/
XPath functions: https://www.w3.org/TR/xpath-functions-30/

-->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.w3.org/1999/XSL/TransformAlias"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:h="http://www.w3.org/1999/xhtml"
    xmlns:r="urn:replacer-xml"
    xmlns:phil="https://philschatz.com"
    xmlns:temp="urn:temp-placeholder-element"
    expand-text="yes"
    version="3.0">

<xsl:output method="xml" indent="yes"/>

<xsl:namespace-alias stylesheet-prefix="t" result-prefix="xsl"/>

<xsl:variable name="MIN_PASS" select="0"/>
<xsl:variable name="MAX_PASS" select="5"/>

<xsl:template match="r:root">
    <t:transform expand-text="yes" version="3.0" exclude-result-prefixes="r xs fn phil">
        <xsl:comment>This file is autogenerated. DO NOT EDIT.</xsl:comment>
        
        <t:output method="xhtml" html-version="5"/>
        <t:mode use-accumulators="#all"/>
        <t:key name="internal-id" match="*" use="@temp:id"/>
        <t:key name="internal-parent" match="*" use="@temp:parent"/>

        <xsl:apply-templates mode="accumulators-mode" select="//r:bucket"/>
        <xsl:apply-templates mode="accumulators-mode" select="//r:counter"/>

        <t:template match="/">
            <t:variable name="init"><t:apply-templates mode="INITIALIZE_MODE" select="@*|node()"/></t:variable>
            <t:variable name="annotate"><t:apply-templates mode="ANNOTATE_MODE" select="$init"/></t:variable>
            <t:variable name="expand"><t:apply-templates mode="EXPAND_MODE" select="$annotate"/></t:variable>
            <t:variable name="move"><t:apply-templates mode="MOVE_MODE" select="$expand"/></t:variable>
            <t:variable name="number"><t:apply-templates mode="NUMBER_MODE" select="$move"/></t:variable>
            <t:variable name="link"><t:apply-templates mode="LINK_MODE" select="$number"/></t:variable>
            <t:variable name="cleanup"><t:apply-templates mode="CLEANUP_MODE" select="$link"/></t:variable>
            <t:sequence select="$cleanup"/>
        </t:template>

        <!-- Recurse -->
        <xsl:apply-templates select="node()"/>

        <xsl:comment>Preserve the tree hierarchy before things start to move around</xsl:comment>
        <t:template mode="INITIALIZE_MODE" match="*">
            <t:copy>
                <t:attribute name="temp:id" select="generate-id()"/>
                <t:attribute name="temp:parent" select="generate-id(..)"/>
                <t:apply-templates mode="INITIALIZE_MODE" select="@*|node()"/>
            </t:copy>
        </t:template>

        <xsl:comment>Identity Transform</xsl:comment>
        <t:template match="@*|node()"><t:copy><t:apply-templates select="@*|node()"/></t:copy></t:template>
        <t:template mode="INITIALIZE_MODE" match="@*|node()[not(self::*)]"><t:copy><t:apply-templates mode="INITIALIZE_MODE" select="@*|node()"/></t:copy></t:template>
        <t:template mode="ANNOTATE_MODE" match="@*|node()"><t:copy><t:apply-templates mode="ANNOTATE_MODE" select="@*|node()"/></t:copy></t:template>
        <t:template mode="EXPAND_MODE" match="@*|node()"><t:copy><t:apply-templates mode="EXPAND_MODE" select="@*|node()"/></t:copy></t:template>
        <t:template mode="MOVE_MODE" match="@*|node()"><t:copy><t:apply-templates mode="MOVE_MODE" select="@*|node()"/></t:copy></t:template>
        <t:template mode="NUMBER_MODE" match="@*|node()"><t:copy><t:apply-templates mode="NUMBER_MODE" select="@*|node()"/></t:copy></t:template>
        <t:template mode="LINK_MODE" match="@*|node()"><t:copy><t:apply-templates mode="LINK_MODE" select="@*|node()"/></t:copy></t:template>
        <t:template mode="CLEANUP_MODE" match="@*|node()"><t:copy><t:apply-templates mode="CLEANUP_MODE" select="@*|node()"/></t:copy></t:template>

        <!-- Remove temporary attributes -->
        <t:template mode="CLEANUP_MODE" match="@temp:class | @temp:id | @temp:parent | @temp:linktext"/>

        <!-- boilerplate -->
        <t:template match="r:dump-counter" mode="NUMBER_MODE">
            <t:value-of select="accumulator-after(@name)"/>
        </t:template>

        <t:template match="r:dump-bucket" mode="MOVE_MODE">
            <t:sequence select="accumulator-after(@name)"/>
        </t:template>

        <t:template match="r:link[@to='parent']" mode="LINK_MODE">
            <t:variable name="parent" select="key('internal-id', ancestor::*[@temp:parent][1]/@temp:parent)"/>
            <t:if test="not($parent)">
                <t:message terminate="yes">BUG: Could not find parent element with temp:id="{@temp:parent}"</t:message>
            </t:if>
            <t:if test="not($parent[1]/@id)">
                <t:message terminate="yes">This parent element does not have an id attribute on it yet. Autogenerating id attributes is not supported yet. {@selector}</t:message>
            </t:if>
            <h:a href="#{{$parent[1]/@id}}">
                <t:if test="not($parent/@temp:linktext)">
                    <t:message terminate="yes">Link target #{{$parent[1]/@id}} did not have a link-text element defined for it so do not know how to render the link</t:message>
                </t:if>
                <t:value-of select="$parent[1]/@temp:linktext"/>
            </h:a>
        </t:template>

        <xsl:for-each select=".//r:link[@to='child']">

            <t:template mode="LINK_MODE" match="r:link[@to='child'][@temp:child-link-key='{replace(@selector, &quot;'&quot;, '#')}']">
                <t:variable name="child" select="key('internal-parent', ancestor::*[@temp:id][1]/@temp:id)[self::{@selector}]"/>
                <t:if test="not($child[1]/@id)">
                    <t:message>{{count($child)}} elements</t:message>
                    <t:message terminate="no">This child element does not have an id attribute on it yet. Autogenerating id attributes is not supported yet. {@selector}</t:message>
                </t:if>
                <h:a href="#{{$child[1]/@id}}">
                    <t:if test="not($child/@temp:linktext)">
                        <t:message terminate="no">Link target #{{$child[1]/@id}} did not have a link-text element defined for it so do not know how to render the link</t:message>
                    </t:if>
                    <t:choose>
                        <t:when test="node()">
                            <t:apply-templates mode="LINK_MODE" select="node()"/>
                        </t:when>
                        <t:otherwise>
                            <t:value-of select="$child[1]/@temp:linktext"/>
                        </t:otherwise>
                    </t:choose>
                </h:a>
            </t:template>

        </xsl:for-each>

        <!-- The children of this node are matches explicitly -->
        <t:template mode="NUMBER_MODE" match="r:link-text"/>

        <t:function name="phil:hasClass" as="xs:boolean">
            <t:param name="class" as="xs:string"/>
            <t:param name="className" as="xs:string"/>
            <t:sequence select="fn:exists(fn:index-of(fn:tokenize($class, '\s+'), $className))"/>
        </t:function>

        <t:function name="phil:addClass" as="xs:string">
            <t:param name="class" as="xs:string"/>
            <t:param name="className" as="xs:string"/>
            <t:value-of select="fn:normalize-space(fn:concat($class, ' ', $className))"/>
        </t:function>

    </t:transform>
</xsl:template>

<xsl:template match="r:replace">
    <xsl:variable name="matchString">
        <xsl:call-template name="build-match-with-self"/>
    </xsl:variable>
    <xsl:variable name="variablesDefined" select="r:count-value/@name"/>
    <xsl:variable name="variablesUsed" select="distinct-values(.//r:dump-counter/@name)"/>
    <xsl:variable name="templateId" select="generate-id()"/>
    <xsl:variable name="classMatchString">*[@temp:class][phil:hasClass(@temp:class, '{$templateId}')]</xsl:variable>

    <t:template match="{$matchString}" mode="ANNOTATE_MODE">
        <t:copy>
            <t:attribute name="temp:class">{$templateId}</t:attribute>
            <t:apply-templates mode="ANNOTATE_MODE" select="@*|node()"/>
        </t:copy>
    </t:template>

    <t:template match="{$classMatchString}" mode="EXPAND_MODE">
        <xsl:apply-templates select="node()[not(self::r:replace)]">
            <xsl:with-param tunnel="yes" name="currentMode">EXPAND_MODE</xsl:with-param>
            <xsl:with-param tunnel="yes" name="variablesDefined" select="$variablesDefined"/>
            <xsl:with-param tunnel="yes" name="variablesUsed" select="$variablesUsed"/>
        </xsl:apply-templates>
    </t:template>

    <xsl:if test="@move-to">
        <t:template match="{$matchString}" mode="MOVE_MODE">
            <t:comment>Moved "{$matchString}" because it had a @move-to</t:comment>
            <t:message>Removing element {$matchString} because it has a @move-to</t:message>
        </t:template>
    </xsl:if>

    <t:template match="{$classMatchString}" mode="NUMBER_MODE">
        <xsl:for-each select="$variablesUsed">
            <t:param tunnel="yes" name="{.}"/>
        </xsl:for-each>
        <xsl:apply-templates select="r:count-value"/>
        <t:copy>
            <t:apply-templates mode="NUMBER_MODE" select="@*"/>
            <t:attribute name="temp:linktext">
                <t:apply-templates mode="NUMBER_MODE" select="r:link-text/node()"/>
            </t:attribute>

            <xsl:call-template name="applyChildren">
                <xsl:with-param tunnel="yes" name="currentMode">NUMBER_MODE</xsl:with-param>
                <xsl:with-param tunnel="yes" name="variablesDefined" select="$variablesDefined"/>
                <xsl:with-param tunnel="yes" name="variablesUsed" select="$variablesUsed"/>
            </xsl:call-template>
        </t:copy>
    </t:template>


    <xsl:apply-templates select="r:replace">
        <xsl:with-param tunnel="yes" name="variablesDefined" select="$variablesDefined"/>
        <xsl:with-param tunnel="yes" name="variablesUsed" select="$variablesUsed"/>
    </xsl:apply-templates>
</xsl:template>


<xsl:template match="r:this">
    <xsl:comment>r:this</xsl:comment>
    <t:copy>
        <t:apply-templates select="@*"/>
        <xsl:if test="../r:link-text">
            <xsl:copy-of select="../r:link-text"/>
        </xsl:if>

        <xsl:apply-templates select="node()"/>
    </t:copy>
</xsl:template>

<xsl:template match="r:children" name="applyChildren">
    <xsl:param tunnel="yes" name="currentMode" as="xs:string"/>
    <xsl:param tunnel="yes" name="variablesDefined"/>
    <xsl:comment>r:children</xsl:comment>
    <t:apply-templates mode="{$currentMode}" select="node()">
        <xsl:for-each select="$variablesDefined">
            <t:with-param tunnel="yes" name="{.}" select="${.}"/>
        </xsl:for-each>
    </t:apply-templates>
</xsl:template>


<xsl:template match="r:link-text"/>

<!--We have to hardcode the selector because XSLT Home Edition does not support dynamic selectors-->
<xsl:template match="r:link[@to='child']/@selector">
    <xsl:attribute name="temp:child-link-key" select="replace(., &quot;'&quot;, '#')"/>
</xsl:template>

<xsl:template mode="accumulators-mode" match="r:bucket">
    <xsl:variable name="name" select="@name"/>
    <xsl:variable name="resetMatchString">
        <xsl:call-template name="build-match-ancestors"/>
    </xsl:variable>
    <t:accumulator name="{@name}" initial-value="()">
        <t:accumulator-rule match="{$resetMatchString}" select="()"/>
        <xsl:for-each select="/r:root//r:replace[@move-to=$name]">
            <xsl:variable name="appendMatchString">
                <xsl:call-template name="build-match-with-self"/>
            </xsl:variable>
            <t:accumulator-rule match="{$appendMatchString}" select="$value union ."/>
        </xsl:for-each>
    </t:accumulator>
</xsl:template>

<xsl:template mode="accumulators-mode" match="r:counter">
    <xsl:variable name="name" select="@name"/>
    <xsl:variable name="resetMatchString">
        <xsl:call-template name="build-match-ancestors"/>
    </xsl:variable>
    <t:accumulator name="{@name}" initial-value="0">
        <t:accumulator-rule match="{$resetMatchString}" select="0"/>
        <t:accumulator-rule match="{@selector}" select="$value + 1"/>
    </t:accumulator>
</xsl:template>

<!-- Discard the bucket declaration. We no longer need it -->
<xsl:template match="r:bucket"/>
<xsl:template match="r:counter"/>

<xsl:template name="build-match-with-self"><xsl:for-each select="ancestor::r:replace">//{@selector}</xsl:for-each><xsl:if test="@selector">//{@selector}</xsl:if></xsl:template>
<xsl:template name="build-match-ancestors"><xsl:for-each select="ancestor::r:replace">//{@selector}</xsl:for-each></xsl:template>


<!-- Identity Transform -->
<xsl:template match="@*|node()">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>

</xsl:stylesheet>