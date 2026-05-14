// ------------------------------------------------------------------------------------------
// Function:  	parseURI()
//
// Purpose:		Parse URI into a JSON Object
//
// Args:		paramURI - string - URI to parse
//					e.g. /airport/detail?iata=DTW&country=US
//
// Output:		JSON object
//
//				{
//					"url":"/airport/detail?iata=DTW&country=US",
//					"base-url":"/airport/detail",
//					"args": { iata: 'DTW', country: 'US' }
//				}
//
// ------------------------------------------------------------------------------------------

// Import Modules
var querystringModule = require ('querystring');		// Module: querystring

exports.parseURI = function (paramURI) {

	if ((paramURI) && (paramURI.length > 7)) {
		
		// extract the query strring portion of the URI; e.g. {"iata": "DTW"}
		var varQueryStringJSON = querystringModule.parse(paramURI.slice(paramURI.indexOf("?") + 1));
		var varBaseURL = paramURI.substr(0, paramURI.indexOf("?") - 1);
		
		var varUriJson = {
			"uri": paramURI,
			"base-url": varBaseURL,
			"args": varQueryStringJSON
		};
		
		return varUriJson;
	} else {
		throw new SyntaxError("parseURI() - Invalid function parameters.");
	}
}