package geojson.util;

@:forward
abstract Liness(Array<Lines>) from Array<Lines> to Array<Lines> from Array<Array<Line>> {
	@:from
	public static function fromCoordinates(v:Array<Array<Array<Coordinates>>>):Liness
		return cast v;
}