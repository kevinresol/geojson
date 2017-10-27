package geojson.util;

typedef GeoJson<T, C> = {
	type:GeometryType<T>,
	coordinates:C,
}

typedef UntypedGeoJson<C> = {
	type:String,
	coordinates:C,
}