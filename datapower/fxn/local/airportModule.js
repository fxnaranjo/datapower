// ------------------------------------------------------------------------------------------
// Function:  	getAirportDetail()
//
// Purpose:		Read array of airport data and return the detailed record for the
//				IATA code passed as a parameter.
// ------------------------------------------------------------------------------------------
exports.getAirportDetail = function (paramAirportDataArray, paramIataCode) {
	
	debugger;
	
	if ((paramAirportDataArray) && (paramIataCode) && (paramAirportDataArray.length > 0) && (paramIataCode.length >= 3)) {
		
		for (var i = 0; i < paramAirportDataArray.length; i++) {
			
			var item = paramAirportDataArray[i];
			if (item[ "iata"] === paramIataCode) {
				
				//	return the airport record; terminate the for-loop.
				return item;
			}
		}
		// if no data found, throw an exception
		throw {
			name: "NoDataFoundError",
			message: 'No data found for airport "' + paramIataCode + '".'
		}
	} else {
		throw new SyntaxError("getAirportDetail() - Invalid function parameters.");
	}
}

// ------------------------------------------------------------------------------------------
// Function:  	getAirportList()
//
// Purpose:		Read array of airport data and return summary records for those matching the
//				continent and country (ISO) code parameters.
// ------------------------------------------------------------------------------------------
exports.getAirportList = function (paramAirportDataArray, paramContinentCode, paramCountryCode) {
	
	debugger;
	
	var varAirportList =[];
	
	if ((paramAirportDataArray) && (paramAirportDataArray.length > 0) && (paramContinentCode.length >= 2) && (paramCountryCode.length >= 2)) {
		
		for (var i = 0; i < paramAirportDataArray.length; i++) {
			
			var varAirportRecord = paramAirportDataArray[i];
			if (varAirportRecord[ "continent"] === paramContinentCode && varAirportRecord[ "iso"] === paramCountryCode) {
				
				// construct the summary record
				var varAirport = {
					continent: varAirportRecord[ "continent"],
					iso: varAirportRecord[ "iso"],
					iata: varAirportRecord[ "iata"],
					name: varAirportRecord[ "name"]
				};
				
				// Add the new record to the array
				varAirportList.push(varAirport);
			}
		}
		if (varAirportList.length > 0) {
			return varAirportList;
		} else {
			throw {
				name: "NoDataFoundError",
				message: 'No data found for airport "' + paramIataCode + '".'
			}
		}
	} else {
		throw new SyntaxError("getAirportList() - Invalid function parameters.");
	}
}