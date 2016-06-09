package geojson.util;

@:enum
abstract GeoJsonType<C>(String) to String {
	var Point:GeoJsonType<Coordinates> = 'Point';
	var LineString:GeoJsonType<Array<Coordinates>> = 'LineString';
	var Polygon:GeoJsonType<Array<Line>> = 'Polygon';
	var MultiPoint:GeoJsonType<Array<Coordinates>> = 'MultiPoint';
	var MultiLineString:GeoJsonType<Array<Line>> = 'MultiLineString';
	var MultiPolygon:GeoJsonType<Array<Lines>> = 'MultiPolygon';
}
