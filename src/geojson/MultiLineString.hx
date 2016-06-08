package geojson;

import geojson.util.*;

@:forward
abstract MultiLineString(GeoJsonMultiLineString) from GeoJsonMultiLineString to GeoJsonMultiLineString {
	public function new(lines:MultiLine)
		this = {
			type: 'MultiLineString',
			coordinates: lines,
		}
}

private typedef GeoJsonMultiLineString = {
	type:String,
	coordinates:Array<Array<Array<Float>>>,
}