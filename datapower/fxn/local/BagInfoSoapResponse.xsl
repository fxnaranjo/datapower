<?xml version="1.0" encoding="utf-8"?>
<!-- Gang Wu IBM Corp -->
<!-- Modified by Jim Brown  IBM Corp -->
<!--    This stylesheet will generate BaggageStatus Web Service response SOAP message based on baggage status xml table  -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fly="http://www.ibm.com/datapower/FLY/BaggageService/" xmlns:dp="http://www.datapower.com/extensions" extension-element-prefixes="dp" exclude-result-prefixes="dp dpconfig">
	<xsl:output method="xml"/>
	
	<xsl:template match="/">
		<!--  Get the baggage status table-->
		<xsl:variable name="baggageTbl" select="document('local:///baggageStatus.xml')"/>
		
		<xsl:variable name="bagId" select="//fly:id"/>
		<xsl:variable name="bag" select="$baggageTbl/fly:bagstatus/fly:passenger/fly:bag[fly:id=$bagId]"/>
		<xsl:variable name="passenger" select="$bag/.."/>
		
		<xsl:message dp:priority="debug">bagId=[<xsl:value-of select="$bagId"/>]</xsl:message>
		<xsl:message dp:priority="debug">bag=[<xsl:value-of select="$bag"/>]</xsl:message>
		<xsl:message dp:priority="debug">passenger=[<xsl:value-of select="$passenger"/>]</xsl:message>
		
		
	         <xsl:variable name="dummy_response">
                        <dp:url-open target="http://10.122.14.34" response="responsecode-ignore" timeout="2">

                           <xsl:copy-of select="."/>

                            </dp:url-open>
                 </xsl:variable>    

<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" >
   <soapenv:Header/>
   <soapenv:Body>
	  <fly:BagInfoResponse xmlns:fly="http://www.ibm.com/datapower/FLY/BaggageService/">
		 <fly:id><xsl:value-of select="$bagId"/></fly:id>
		 <fly:destination><xsl:value-of select="$bag/fly:destination"/></fly:destination>
		 <fly:status><xsl:value-of select="$bag/fly:status"/></fly:status>
		 <fly:lastKnownLocation><xsl:value-of select="$bag/fly:lastKnownLocation"/></fly:lastKnownLocation>
		 <fly:timeAtLastKnownLocation><xsl:value-of select="$bag/fly:timeAtLastKnownLocation"/></fly:timeAtLastKnownLocation>
		 <fly:refNumber><xsl:value-of select="$passenger/fly:refNumber"/></fly:refNumber>
		 <fly:lastName><xsl:value-of select="$passenger/fly:lastName"/></fly:lastName>
	  </fly:BagInfoResponse>
   </soapenv:Body>
</soapenv:Envelope>

	</xsl:template>
</xsl:stylesheet>