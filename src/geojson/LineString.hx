package geojson;

import geojson.util.*;

@:forward
abstract LineString(GeoJsonLineString) from GeoJsonLineString to GeoJsonLineString {
	public function new(line:Line)
		this = {
			type: 'LineString',
			coordinates: line,
		}
}

private typedef GeoJsonLineString = {
	type:String,
	coordinates:Array<Array<Float>>,
}