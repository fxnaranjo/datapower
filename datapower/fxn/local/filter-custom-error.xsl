<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dp="http://www.datapower.com/extensions"
	xmlns:dpconfig="http://www.datapower.com/param/config"
	extension-element-prefixes="dp"
	exclude-result-prefixes="dp dpconfig">
	<xsl:output method="html" version="1.0" />
	<xsl:template match="/">
		<html>
			<head>
				<title>My Company Application</title>
			</head>
			<body>
				<h2>My Company Benefits</h2>
				<p>Illegal operation attempted</p>
				<p>
					This error will be reported to Application Security
				</p>
				<p>Thank you.</p>
				<p>
					<font size="2">
						Transaction ID:
						<xsl:value-of
							select="dp:variable('var://service/transaction-id')" />
					</font>
				</p>
				<p>
					<font size="2">
						Error code:
						<xsl:value-of
							select="dp:variable('var://service/error-code')" />
					</font>
				</p>
				<p>
					<font size="2">
						Error-subcode:
						<xsl:value-of
							select="dp:variable('var://service/error-subcode')" />
					</font>
				</p>
				<p>
					<font size="2">
						Error message:
						<xsl:value-of
							select="dp:variable('var://service/error-message')" />
					</font>
				</p>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>