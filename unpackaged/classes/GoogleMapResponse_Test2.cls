@IsTest
public class GoogleMapResponse_Test2 {
	
	static testMethod void testParse() {
		String json = '{'+
		'	\"results\": [{'+
		'		\"address_components\": [{'+
		'			\"long_name\": \"14560\",'+
		'			\"short_name\": \"14560\",'+
		'			\"types\": ['+
		'				\"street_number\"'+
		'			]'+
		'		}, {'+
		'			\"long_name\": \"North Winan Road\",'+
		'			\"short_name\": \"N Winan Rd\",'+
		'			\"types\": ['+
		'				\"route\"'+
		'			]'+
		'		}, {'+
		'			\"long_name\": \"Platte City\",'+
		'			\"short_name\": \"Platte City\",'+
		'			\"types\": ['+
		'				\"locality\",'+
		'				\"political\"'+
		'			]'+
		'		}, {'+
		'			\"long_name\": \"Carroll Township\",'+
		'			\"short_name\": \"Carroll Township\",'+
		'			\"types\": ['+
		'				\"administrative_area_level_3\",'+
		'				\"political\"'+
		'			]'+
		'		}, {'+
		'			\"long_name\": \"Platte County\",'+
		'			\"short_name\": \"Platte County\",'+
		'			\"types\": ['+
		'				\"administrative_area_level_2\",'+
		'				\"political\"'+
		'			]'+
		'		}, {'+
		'			\"long_name\": \"Missouri\",'+
		'			\"short_name\": \"MO\",'+
		'			\"types\": ['+
		'				\"administrative_area_level_1\",'+
		'				\"political\"'+
		'			]'+
		'		}, {'+
		'			\"long_name\": \"United States \",'+
		'			\"short_name\": \"US\",'+
		'			\"types\": ['+
		'				\"country\",'+
		'				\"political\"'+
		'			]'+
		'		}, {'+
		'			\"long_name\": \"64079\",'+
		'			\"short_name\": \"64079\",'+
		'			\"types\": ['+
		'				\"postal_code\"'+
		'			]'+
		'		}],'+
		'		\"formatted_address\": \"14560 N Winan Rd, Platte City, MO 64079, USA\",'+
		'		\"geometry\": {'+
		'			\"bounds\": {'+
		'				\"northeast\": {'+
		'					\"lat\": 39.3575881,'+
		'					\"lng\": -94.69531339999999'+
		'				},'+
		'				\"southwest\": {'+
		'					\"lat\": 39.3575878,'+
		'					\"lng\": -94.6953321'+
		'				}'+
		'			},'+
		'			\"location\": {'+
		'				\"lat\": 39.3575881,'+
		'				\"lng\": -94.6953321'+
		'			},'+
		'			\"location_type\": \"RANGE_INTERPOLATED\",'+
		'			\"viewport\": {'+
		'				\"northeast\": {'+
		'					\"lat\": 39.3589369302915,'+
		'					\"lng\": -94.69397376970849'+
		'				},'+
		'				\"southwest\": {'+
		'					\"lat\": 39.3562389697085,'+
		'					\"lng\": -94.6966717302915'+
		'				}'+
		'			}'+
		'		},'+
		'		\"place_id\": \"EiwxNDU2MCBOIFdpbmFuIFJkLCBQbGF0dGUgQ2l0eSwgTU8gNjQwNzksIFVTQQ\",'+
		'		\"types\": ['+
		'			\"street_address\"'+
		'		]'+
		'	}],'+
		'	\"status\": \"OK\"'+
		'}';
		GoogleMapResponse2 obj = GoogleMapResponse2.parse(json);
		System.assert(obj != null);
	}
}