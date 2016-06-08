package geojson;

import geojson.util.*;

@:forward
abstract MultiPolygon(GeoJsonMultiPolygon) from GeoJsonMultiPolygon to GeoJsonMultiPolygon {
	public function new(points:MultiLine)
		this = {
			type: 'MultiPolygon',
			coordinates: points,
		}
}

private typedef GeoJsonMultiPolygon = {
	type:String,
	coordinates:Array<Array<Array<Float>>>,
}