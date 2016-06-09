package geojson.util;

typedef GeoJson<T, C> = {
	type:GeoJsonGeometryType<T>,
	coordinates:C,
}