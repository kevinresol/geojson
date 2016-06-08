package geojson;

import geojson.util.*;

@:forward
abstract MultiPoint(GeoJsonMultiPoint) from GeoJsonMultiPoint to GeoJsonMultiPoint {
	public function new(points:MultiCoordinates)
		this = {
			type: 'MultiPoint',
			coordinates: points,
		}
}

private typedef GeoJsonMultiPoint = {
	type:String,
	coordinates:Array<Array<Float>>,
}