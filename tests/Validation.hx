package;

import tink.unit.Assert.*;
import geojson.MultiPolygon;

@:asserts
class Validation {
	public function new() {}
	
	@:variant({type: 'MultiPolygon', coordinates: []}, false)
	@:variant({type: 'MultiPolygon', coordinates: [[]]}, false)
	@:variant({type: 'MultiPolygon', coordinates: [[[]]]}, false)
	@:variant({type: 'MultiPolygon', coordinates: [[[[]]]]}, false)
	@:variant({
		type: 'MultiPolygon',
		coordinates: [[[
			[114.215168481013, 22.42437550824227],
			[114.21472873695674, 22.425806662707153],
			[114.21224273370234, 22.428079754592517],
			[114.215168481013, 22.42437550824227]
		]]],
	}, true)
	public function multiPolygon(v:Dynamic, result:Bool) {
		return assert(MultiPolygon.is(v) == result);
	}
}