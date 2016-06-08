package geojson;

import geojson.util.*;

@:forward
abstract Polygon(GeoJsonPolygon) from GeoJsonPolygon to GeoJsonPolygon {
	public function new(points:Line)
		this = {
			type: 'Polygon',
			coordinates: points,
		}
}

private typedef GeoJsonPolygon = {
	type:String,
	coordinates:Array<Array<Float>>,
}