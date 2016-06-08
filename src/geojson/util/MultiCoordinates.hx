package geojson.util;

abstract MultiCoordinates(Array<Coordinates>) from Array<Coordinates> to Array<Coordinates> {
	@:to
	public inline function toFloatArray():Array<Array<Float>> {
		return [for(point in this) point.toFloatArray()];
	}
}