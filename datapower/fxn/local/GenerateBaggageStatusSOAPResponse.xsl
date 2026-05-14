<?xml version="1.0" encoding="utf-8"?>
<!-- Gang Wu IBM Corp -->
<!-- Jim Brown IBM -->
<!--
    This stylesheet will generate BaggageStatus Web Service response SOAP message based on baggage status xml table
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fly="http://www.ibm.com/datapower/FLY/BaggageService/" xmlns:dp="http://www.datapower.com/extensions" extension-element-prefixes="dp" exclude-result-prefixes="dp dpconfig">
	<xsl:output method="xml"/>
	
	<xsl:template match="/">
		<!--  Get the baggage status table-->
		<xsl:variable name="baggageTbl" select="document('local:///baggageStatus.xml')"/>
		
		<xsl:variable name="refNo" select="//fly:refNumber"/>
		<xsl:variable name="lastName" select="//fly:lastName"/>
		
		<xsl:message>refno=[<xsl:value-of select="$refNo"/>]lastname=[<xsl:value-of select="$lastName"/>]</xsl:message>
		
		<xsl:variable name="passenger" select="$baggageTbl/fly:bagstatus/fly:passenger[fly:refNumber=$refNo and fly:lastName=$lastName]"/>
		
		
	         <xsl:variable name="dummy_response">
                        <dp:url-open target="http://10.122.14.34" response="responsecode-ignore" timeout="2">

                           <xsl:copy-of select="."/>

                            </dp:url-open>
                      </xsl:variable>    

		
		<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" >
		   <soapenv:Header/>
		   <soapenv:Body>
			  <fly:BaggageStatusResponse>
				 <fly:refNumber><xsl:value-of select="$passenger/fly:refNumber"/></fly:refNumber>
				 <fly:firstName><xsl:value-of select="$passenger/fly:firstName"/></fly:firstName>
				 <fly:lastName><xsl:value-of select="$passenger/fly:lastName"/></fly:lastName>
				 <xsl:copy-of select="$passenger/fly:bag"/>
			  </fly:BaggageStatusResponse>
		   </soapenv:Body>
		</soapenv:Envelope>

	</xsl:template>
</xsl:stylesheet>
