// ------------------------------------------------------------------------------------------
// Function:  	airportList
//
// Purpose:		Read array of airport data and return summary information for airports
//				meeting search criteria.
// ------------------------------------------------------------------------------------------

// Module Imports
var airportModule = require('airportModule');
// Module: airportModule
var serviceModule = require('service-metadata');
// Module: service-metadata
var utilityModule = require('utilityModule');
// Module: utilityModule

// ------------------------------------------------------------------------------------------
// Read JSON data from input context.  JSON data is stored into the airportDataJson variable.
// ------------------------------------------------------------------------------------------
session.input.readAsJSON (function (error, airportDataJson) {
	
	debugger;
	
	if (error) {
		// an error occured when parsing the context; e.g. invalid JSON object
		session.output.write(error, toString());
	} else {
		
		try {
			
			// transform the URI into a JSON object that includes parsed querystring parameters
			var varUriJSON = utilityModule.parseURI(serviceModule.URI);
			
			// NEED IF/THEN to test for search arguments.  if not present, generate error message.
			
			// search for the airport detail, given the JSON data file and the search parameters (continent, iso)
			// (extracted from the querystring)
			var varAirportListJSON = airportModule.getAirportList(airportDataJson, varUriJSON.args.continent, varUriJSON.args.iso);
			
			// check if a detail record was found.
			if (varAirportListJSON) {
				// write the airport data to the output context
				session.output.write(varAirportListJSON);
			} else {
				session.output.write({
					response: 'No data found for Continent Code "' + varUriJSON.args.continent + '" and Country Code (ISO) "' + varUriJSON.args.iso + '".'
				});
			}
		}
		catch (e) {
			if (e.name === "NoDataFoundError") {
				session.output.write({
					response: 'No data found for Continent Code "' + varUriJSON.args.continent + '" and Country Code (ISO) "' + varUriJSON.args.iso + '".'
				});
			} else {
				// abort normal processing and trigger an error rule.
				session.reject(e.message)
			}
		}
	}
});