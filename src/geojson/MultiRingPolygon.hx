package geojson;

import geojson.util.*;

@:forward
abstract MultiRingPolygon(GeoJsonMultiRingPolygon) from GeoJsonMultiRingPolygon to GeoJsonMultiRingPolygon {
	public function new(rings:MultiLine)
		this = {
			type: 'Polygon',
			coordinates: rings,
		}
}

private typedef GeoJsonMultiRingPolygon = {
	type:String,
	coordinates:Array<Array<Array<Float>>>,
}