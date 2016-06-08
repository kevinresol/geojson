package geojson;

import geojson.util.*;

@:forward
abstract Point(GeoJsonPoint) from GeoJsonPoint to GeoJsonPoint {
	public function new(point:Coordinates)
		this = {
			type: 'Point',
			coordinates: point,
		}
}

private typedef GeoJsonPoint = {
	type:String,
	coordinates:Array<Float>,
}