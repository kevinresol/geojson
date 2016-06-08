package geojson.util;

import geojson.util.Line;

abstract MultiLine(Array<Line>) from Array<Line> to Array<Line> {
	@:to
	public inline function toFloatArray():Array<Array<Array<Float>>> {
		return [for(line in this) line.toFloatArray()];
	}
}