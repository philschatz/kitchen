<?xml version="1.0" encoding="UTF-8"?>
<!--This file is autogenerated. DO NOT EDIT.-->
<xsl:transform xmlns:fn="http://www.w3.org/2005/xpath-functions"
               xmlns:h="http://www.w3.org/1999/xhtml"
               xmlns:phil="https://philschatz.com"
               xmlns:r="urn:replacer-xml"
               xmlns:temp="urn:temp-placeholder-element"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               expand-text="yes"
               version="3.0"
               exclude-result-prefixes="r xs fn phil temp">
   <xsl:output method="xhtml" html-version="5"/>
   <xsl:mode use-accumulators="#all"/>
   <xsl:key name="link-target" match="*" use="@id"/>
   <xsl:key name="internal-id" match="*" use="@temp:id"/>
   <xsl:key name="internal-parent" match="*" use="@temp:parent"/>
   <xsl:accumulator name="solutionBucket" initial-value="()">
      <xsl:accumulator-rule match="//h:body" select="()"/>
      <xsl:accumulator-rule match="//h:body//*[@data-type='chapter']//*[@data-type='exercise']//*[@data-type='solution']"
                            select="$value union ."/>
   </xsl:accumulator>
   <xsl:accumulator name="exerciseBucket" initial-value="()">
      <xsl:accumulator-rule match="//h:body//*[@data-type='chapter']" select="()"/>
      <xsl:accumulator-rule match="//h:body//*[@data-type='chapter']//*[@data-type='exercise']"
                            select="$value union ."/>
   </xsl:accumulator>
   <xsl:accumulator name="chapterCounter" initial-value="0">
      <xsl:accumulator-rule match="//h:body" select="0"/>
      <xsl:accumulator-rule match="*[@data-type='chapter']" select="$value + 1"/>
   </xsl:accumulator>
   <xsl:accumulator name="exerciseCounter" initial-value="0">
      <xsl:accumulator-rule match="//h:body//*[@data-type='chapter']" select="0"/>
      <xsl:accumulator-rule match="*[@data-type='exercise']" select="$value + 1"/>
   </xsl:accumulator>
   <xsl:accumulator name="figureCounter" initial-value="0">
      <xsl:accumulator-rule match="//h:body//*[@data-type='chapter']" select="0"/>
      <xsl:accumulator-rule match="h:figure" select="$value + 1"/>
   </xsl:accumulator>
   <xsl:template match="/">
      <xsl:variable name="init">
         <xsl:apply-templates mode="INITIALIZE_MODE" select="@*|node()"/>
      </xsl:variable>
      <xsl:variable name="annotate">
         <xsl:apply-templates mode="ANNOTATE_MODE" select="$init"/>
      </xsl:variable>
      <xsl:variable name="expand">
         <xsl:apply-templates mode="EXPAND_MODE" select="$annotate"/>
      </xsl:variable>
      <xsl:variable name="move">
         <xsl:apply-templates mode="MOVE_MODE" select="$expand"/>
      </xsl:variable>
      <xsl:variable name="number">
         <xsl:apply-templates mode="NUMBER_MODE" select="$move"/>
      </xsl:variable>
      <xsl:variable name="link">
         <xsl:apply-templates mode="LINK_MODE" select="$number"/>
      </xsl:variable>
      <xsl:variable name="cleanup">
         <xsl:apply-templates mode="CLEANUP_MODE" select="$link"/>
      </xsl:variable>
      <xsl:sequence select="$cleanup"/>
   </xsl:template>
   <xsl:template mode="ANNOTATE_MODE" match="//h:body">
      <xsl:copy>
         <xsl:attribute name="temp:class">d1e4</xsl:attribute>
         <xsl:apply-templates mode="ANNOTATE_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="EXPAND_MODE"
                 match="*[@temp:class][phil:hasClass(@temp:class, 'd1e4')]">

        <!--r:this-->
      <xsl:copy>
         <xsl:apply-templates select="@*"/>
         <!--r:children-->
         <xsl:apply-templates mode="EXPAND_MODE" select="node()"/>
         <section xmlns="http://www.w3.org/1999/xhtml">
            <h1>Answers</h1>
            <r:dump-bucket name="solutionBucket"/>
         </section>
      </xsl:copy>
      <!--Chapter-->
   </xsl:template>
   <xsl:template mode="NUMBER_MODE"
                 match="*[@temp:class][phil:hasClass(@temp:class, 'd1e4')]">
      <xsl:param tunnel="yes" name="chapterCounter"/>
      <xsl:param tunnel="yes" name="exerciseCounter"/>
      <xsl:param tunnel="yes" name="figureCounter"/>
      <xsl:copy>
         <xsl:apply-templates mode="NUMBER_MODE" select="@*"/>
         <xsl:attribute name="temp:linktext">
            <xsl:apply-templates mode="NUMBER_MODE" select="r:link-text/node()"/>
         </xsl:attribute>
         <!--r:children-->
         <xsl:apply-templates mode="NUMBER_MODE" select="node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="ANNOTATE_MODE" match="//h:body//*[@data-type='chapter']">
      <xsl:copy>
         <xsl:attribute name="temp:class">d1e27</xsl:attribute>
         <xsl:apply-templates mode="ANNOTATE_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="EXPAND_MODE"
                 match="*[@temp:class][phil:hasClass(@temp:class, 'd1e27')]">

            <!--r:this-->
      <xsl:copy>
         <xsl:apply-templates select="@*"/>
         <h2 xmlns="http://www.w3.org/1999/xhtml">Chapter <r:dump-counter name="chapterCounter"/>
         </h2>
         <!--r:children-->
         <xsl:apply-templates mode="EXPAND_MODE" select="node()"/>
         <div xmlns="http://www.w3.org/1999/xhtml">
            <h3>Homework</h3>
            <r:dump-bucket name="exerciseBucket"/>
         </div>
      </xsl:copy>
      <!--Exercise-->
      <!--Figure-->
   </xsl:template>
   <xsl:template mode="NUMBER_MODE"
                 match="*[@temp:class][phil:hasClass(@temp:class, 'd1e27')]">
      <xsl:param tunnel="yes" name="chapterCounter"/>
      <xsl:param tunnel="yes" name="exerciseCounter"/>
      <xsl:param tunnel="yes" name="figureCounter"/>
      <xsl:copy>
         <xsl:apply-templates mode="NUMBER_MODE" select="@*"/>
         <xsl:attribute name="temp:linktext">
            <xsl:apply-templates mode="NUMBER_MODE" select="r:link-text/node()"/>
         </xsl:attribute>
         <!--r:children-->
         <xsl:apply-templates mode="NUMBER_MODE" select="node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="ANNOTATE_MODE"
                 match="//h:body//*[@data-type='chapter']//*[@data-type='exercise']">
      <xsl:copy>
         <xsl:attribute name="temp:class">d1e56</xsl:attribute>
         <xsl:apply-templates mode="ANNOTATE_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="EXPAND_MODE"
                 match="*[@temp:class][phil:hasClass(@temp:class, 'd1e56')]">
                
                <!--r:this-->
      <xsl:copy>
         <xsl:apply-templates select="@*"/>
         <r:link-text xmlns="http://www.w3.org/1999/xhtml">
            <r:dump-counter name="chapterCounter"/>.<r:dump-counter name="exerciseCounter"/>
         </r:link-text>
         <r:link xmlns="http://www.w3.org/1999/xhtml"
                 to="child"
                 temp:child-link-key="*[@data-type=#solution#]">
            <r:dump-counter name="chapterCounter"/>.<r:dump-counter name="exerciseCounter"/>
         </r:link>
         <!--r:children-->
         <xsl:apply-templates mode="EXPAND_MODE" select="node()"/>
      </xsl:copy>
      <!--Solution-->
   </xsl:template>
   <xsl:template mode="MOVE_MODE"
                 match="//h:body//*[@data-type='chapter']//*[@data-type='exercise']">
      <xsl:comment>Moved "//h:body//*[@data-type='chapter']//*[@data-type='exercise']" because it had a @move-to</xsl:comment>
      <xsl:message>Removing element //h:body//*[@data-type='chapter']//*[@data-type='exercise'] because it has a @move-to</xsl:message>
   </xsl:template>
   <xsl:template mode="NUMBER_MODE"
                 match="*[@temp:class][phil:hasClass(@temp:class, 'd1e56')]">
      <xsl:param tunnel="yes" name="chapterCounter"/>
      <xsl:param tunnel="yes" name="exerciseCounter"/>
      <xsl:copy>
         <xsl:apply-templates mode="NUMBER_MODE" select="@*"/>
         <xsl:attribute name="temp:linktext">
            <xsl:apply-templates mode="NUMBER_MODE" select="r:link-text/node()"/>
         </xsl:attribute>
         <!--r:children-->
         <xsl:apply-templates mode="NUMBER_MODE" select="node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="ANNOTATE_MODE"
                 match="//h:body//*[@data-type='chapter']//*[@data-type='exercise']//*[@data-type='solution']">
      <xsl:copy>
         <xsl:attribute name="temp:class">d1e80</xsl:attribute>
         <xsl:apply-templates mode="ANNOTATE_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="EXPAND_MODE"
                 match="*[@temp:class][phil:hasClass(@temp:class, 'd1e80')]">
                    <!--r:this-->
      <xsl:copy>
         <xsl:apply-templates select="@*"/>
         <r:link xmlns="http://www.w3.org/1999/xhtml" to="parent"/>
         <!--r:children-->
         <xsl:apply-templates mode="EXPAND_MODE" select="node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="MOVE_MODE"
                 match="//h:body//*[@data-type='chapter']//*[@data-type='exercise']//*[@data-type='solution']">
      <xsl:comment>Moved "//h:body//*[@data-type='chapter']//*[@data-type='exercise']//*[@data-type='solution']" because it had a @move-to</xsl:comment>
      <xsl:message>Removing element //h:body//*[@data-type='chapter']//*[@data-type='exercise']//*[@data-type='solution'] because it has a @move-to</xsl:message>
   </xsl:template>
   <xsl:template mode="NUMBER_MODE"
                 match="*[@temp:class][phil:hasClass(@temp:class, 'd1e80')]">
      <xsl:copy>
         <xsl:apply-templates mode="NUMBER_MODE" select="@*"/>
         <xsl:attribute name="temp:linktext">
            <xsl:apply-templates mode="NUMBER_MODE" select="r:link-text/node()"/>
         </xsl:attribute>
         <!--r:children-->
         <xsl:apply-templates mode="NUMBER_MODE" select="node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="ANNOTATE_MODE"
                 match="//h:body//*[@data-type='chapter']//h:figure">
      <xsl:copy>
         <xsl:attribute name="temp:class">d1e94</xsl:attribute>
         <xsl:apply-templates mode="ANNOTATE_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="EXPAND_MODE"
                 match="*[@temp:class][phil:hasClass(@temp:class, 'd1e94')]">

                <!--r:this-->
      <xsl:copy>
         <xsl:apply-templates select="@*"/>
         <!--r:children-->
         <xsl:apply-templates mode="EXPAND_MODE" select="node()"/>
      </xsl:copy>
      <!--Caption-->
   </xsl:template>
   <xsl:template mode="NUMBER_MODE"
                 match="*[@temp:class][phil:hasClass(@temp:class, 'd1e94')]">
      <xsl:param tunnel="yes" name="chapterCounter"/>
      <xsl:param tunnel="yes" name="figureCounter"/>
      <xsl:copy>
         <xsl:apply-templates mode="NUMBER_MODE" select="@*"/>
         <xsl:attribute name="temp:linktext">
            <xsl:apply-templates mode="NUMBER_MODE" select="r:link-text/node()"/>
         </xsl:attribute>
         <!--r:children-->
         <xsl:apply-templates mode="NUMBER_MODE" select="node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="ANNOTATE_MODE"
                 match="//h:body//*[@data-type='chapter']//h:figure//h:figcaption">
      <xsl:copy>
         <xsl:attribute name="temp:class">d1e103</xsl:attribute>
         <xsl:apply-templates mode="ANNOTATE_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="EXPAND_MODE"
                 match="*[@temp:class][phil:hasClass(@temp:class, 'd1e103')]">
                    <!--r:this-->
      <xsl:copy>
         <xsl:apply-templates select="@*"/>
         <strong xmlns="http://www.w3.org/1999/xhtml">
            <r:dump-counter name="chapterCounter"/>.<r:dump-counter name="figureCounter"/>
         </strong>
         <!--r:children-->
         <xsl:apply-templates mode="EXPAND_MODE" select="node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="NUMBER_MODE"
                 match="*[@temp:class][phil:hasClass(@temp:class, 'd1e103')]">
      <xsl:param tunnel="yes" name="chapterCounter"/>
      <xsl:param tunnel="yes" name="figureCounter"/>
      <xsl:copy>
         <xsl:apply-templates mode="NUMBER_MODE" select="@*"/>
         <xsl:attribute name="temp:linktext">
            <xsl:apply-templates mode="NUMBER_MODE" select="r:link-text/node()"/>
         </xsl:attribute>
         <!--r:children-->
         <xsl:apply-templates mode="NUMBER_MODE" select="node()"/>
      </xsl:copy>
   </xsl:template>
   <!--Preserve the tree hierarchy before things start to move around-->
   <xsl:template mode="INITIALIZE_MODE" match="*">
      <xsl:copy>
         <xsl:attribute name="temp:id" select="generate-id()"/>
         <xsl:attribute name="temp:parent" select="generate-id(..)"/>
         <xsl:apply-templates mode="INITIALIZE_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <!--Identity Transform-->
   <xsl:template match="@*|node()">
      <xsl:copy>
         <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="INITIALIZE_MODE" match="@*|node()[not(self::*)]">
      <xsl:copy>
         <xsl:apply-templates mode="INITIALIZE_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="ANNOTATE_MODE" match="@*|node()">
      <xsl:copy>
         <xsl:apply-templates mode="ANNOTATE_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="EXPAND_MODE" match="@*|node()">
      <xsl:copy>
         <xsl:apply-templates mode="EXPAND_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="MOVE_MODE" match="@*|node()">
      <xsl:copy>
         <xsl:apply-templates mode="MOVE_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="NUMBER_MODE" match="@*|node()">
      <xsl:copy>
         <xsl:apply-templates mode="NUMBER_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="LINK_MODE" match="@*|node()">
      <xsl:copy>
         <xsl:apply-templates mode="LINK_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="CLEANUP_MODE" match="@*|node()">
      <xsl:copy>
         <xsl:apply-templates mode="CLEANUP_MODE" select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="CLEANUP_MODE"
                 match="@temp:class | @temp:id | @temp:parent | @temp:linktext"/>
   <xsl:template mode="NUMBER_MODE" match="r:dump-counter">
      <xsl:value-of select="accumulator-after(@name)"/>
   </xsl:template>
   <xsl:template mode="MOVE_MODE" match="r:dump-bucket">
      <xsl:sequence select="accumulator-after(@name)"/>
   </xsl:template>
   <xsl:template mode="LINK_MODE" match="h:a[starts-with(@href, '#')]">
      <xsl:variable name="targetId" select="substring-after(@href, '#')"/>
      <xsl:variable name="target" select="key('link-target', $targetId)"/>
      <xsl:if test="not($target)">
         <xsl:message terminate="yes">BUG: Could not find link target with id="{$targetId}"</xsl:message>
      </xsl:if>
      <xsl:copy>
         <xsl:apply-templates mode="LINK_MODE" select="@*"/>
         <xsl:value-of select="$target[1]/@temp:linktext"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template mode="LINK_MODE" match="r:link[@to='parent']">
      <xsl:variable name="parent"
                    select="key('internal-id', ancestor::*[@temp:parent][1]/@temp:parent)"/>
      <xsl:if test="not($parent)">
         <xsl:message terminate="yes">BUG: Could not find parent element with temp:id=""</xsl:message>
      </xsl:if>
      <xsl:if test="not($parent[1]/@id)">
         <xsl:message terminate="yes">This parent element does not have an id attribute on it yet. Autogenerating id attributes is not supported yet. </xsl:message>
      </xsl:if>
      <h:a href="#{$parent[1]/@id}">
         <xsl:if test="not($parent/@temp:linktext)">
            <xsl:message terminate="yes">Link target #{$parent[1]/@id} did not have a link-text element defined for it so do not know how to render the link</xsl:message>
         </xsl:if>
         <xsl:value-of select="$parent[1]/@temp:linktext"/>
      </h:a>
   </xsl:template>
   <xsl:template mode="LINK_MODE"
                 match="r:link[@to='child'][@temp:child-link-key='*[@data-type=#solution#]']">
      <xsl:variable name="child"
                    select="key('internal-parent', ancestor::*[@temp:id][1]/@temp:id)[self::*[@data-type='solution']]"/>
      <xsl:if test="not($child[1]/@id)">
         <xsl:message>{count($child)} elements</xsl:message>
         <xsl:message terminate="no">This child element does not have an id attribute on it yet. Autogenerating id attributes is not supported yet. *[@data-type='solution']</xsl:message>
      </xsl:if>
      <h:a href="#{$child[1]/@id}">
         <xsl:if test="not($child/@temp:linktext)">
            <xsl:message terminate="no">Link target #{$child[1]/@id} did not have a link-text element defined for it so do not know how to render the link</xsl:message>
         </xsl:if>
         <xsl:choose>
            <xsl:when test="node()">
               <xsl:apply-templates mode="LINK_MODE" select="node()"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$child[1]/@temp:linktext"/>
            </xsl:otherwise>
         </xsl:choose>
      </h:a>
   </xsl:template>
   <xsl:template mode="NUMBER_MODE" match="r:link-text"/>
   <xsl:function name="phil:hasClass" as="xs:boolean">
      <xsl:param name="class" as="xs:string"/>
      <xsl:param name="className" as="xs:string"/>
      <xsl:sequence select="fn:exists(fn:index-of(fn:tokenize($class, '\s+'), $className))"/>
   </xsl:function>
   <xsl:function name="phil:addClass" as="xs:string">
      <xsl:param name="class" as="xs:string"/>
      <xsl:param name="className" as="xs:string"/>
      <xsl:value-of select="fn:normalize-space(fn:concat($class, ' ', $className))"/>
   </xsl:function>
</xsl:transform>
