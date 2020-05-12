package;

import haxe.io.Bytes;
import geojson.util.WkbTools;
import haxe.Json;

@:asserts
class WkbTest {
	public function new() {}
	
	// @:variant("0101000000000000000000f87f000000000000f87f", '{"type":"Point","coordinates":[]}')
	@:variant("0101000000000000000000f03f0000000000000040", '{"type":"Point","coordinates":[1,2]}')
	@:variant("010200000000000000", '{"type":"LineString","coordinates":[]}')
	@:variant("010200000002000000000000000000f03f000000000000004000000000000008400000000000001040", '{"type":"LineString","coordinates":[[1,2],[3,4]]}')
	@:variant("010300000000000000", '{"type":"Polygon","coordinates":[]}')
	@:variant("01030000000100000004000000000000000000f03f00000000000000400000000000000840000000000000104000000000000014400000000000001840000000000000f03f0000000000000040", '{"type":"Polygon","coordinates":[[[1,2],[3,4],[5,6],[1,2]]]}')
	@:variant("01030000000200000004000000000000000000f03f00000000000000400000000000000840000000000000104000000000000014400000000000001840000000000000f03f000000000000004004000000000000000000264000000000000028400000000000002a400000000000002c400000000000002e40000000000000304000000000000026400000000000002840", '{"type":"Polygon","coordinates":[[[1,2],[3,4],[5,6],[1,2]],[[11,12],[13,14],[15,16],[11,12]]]}')
	@:variant("01030000000300000004000000000000000000f03f00000000000000400000000000000840000000000000104000000000000014400000000000001840000000000000f03f000000000000004004000000000000000000264000000000000028400000000000002a400000000000002c400000000000002e4000000000000030400000000000002640000000000000284004000000000000000000354000000000000036400000000000003740000000000000384000000000000039400000000000003a4000000000000035400000000000003640", '{"type":"Polygon","coordinates":[[[1,2],[3,4],[5,6],[1,2]],[[11,12],[13,14],[15,16],[11,12]],[[21,22],[23,24],[25,26],[21,22]]]}')
	@:variant("010400000000000000", '{"type":"MultiPoint","coordinates":[]}')
	@:variant("0104000000010000000101000000000000000000f03f0000000000000040", '{"type":"MultiPoint","coordinates":[[1,2]]}')
	@:variant("0104000000020000000101000000000000000000f03f0000000000000040010100000000000000000008400000000000001040", '{"type":"MultiPoint","coordinates":[[1,2],[3,4]]}')
	@:variant("010500000000000000", '{"type":"MultiLineString","coordinates":[]}')
	@:variant("010500000001000000010200000002000000000000000000f03f000000000000004000000000000008400000000000001040", '{"type":"MultiLineString","coordinates":[[[1,2],[3,4]]]}')
	@:variant("010500000002000000010200000002000000000000000000f03f000000000000004000000000000008400000000000001040010200000002000000000000000000144000000000000018400000000000001c400000000000002040", '{"type":"MultiLineString","coordinates":[[[1,2],[3,4]],[[5,6],[7,8]]]}')
	@:variant("010600000000000000", '{"type":"MultiPolygon","coordinates":[]}')
	@:variant("01060000000100000001030000000100000004000000000000000000f03f00000000000000400000000000000840000000000000104000000000000014400000000000001840000000000000f03f0000000000000040", '{"type":"MultiPolygon","coordinates":[[[[1,2],[3,4],[5,6],[1,2]]]]}')
	@:variant("01060000000200000001030000000100000004000000000000000000f03f00000000000000400000000000000840000000000000104000000000000014400000000000001840000000000000f03f000000000000004001030000000300000004000000000000000000f03f00000000000000400000000000000840000000000000104000000000000014400000000000001840000000000000f03f000000000000004004000000000000000000264000000000000028400000000000002a400000000000002c400000000000002e4000000000000030400000000000002640000000000000284004000000000000000000354000000000000036400000000000003740000000000000384000000000000039400000000000003a4000000000000035400000000000003640", '{"type":"MultiPolygon","coordinates":[[[[1,2],[3,4],[5,6],[1,2]]],[[[1,2],[3,4],[5,6],[1,2]],[[11,12],[13,14],[15,16],[11,12]],[[21,22],[23,24],[25,26],[21,22]]]]}')
	@:variant("010700000000000000", '{"type":"GeometryCollection","geometries":[]}')
	@:variant("0107000000010000000101000000000000000000f03f0000000000000040", '{"type":"GeometryCollection","geometries":[{"type":"Point","coordinates":[1,2]}]}')
	@:variant("0107000000020000000101000000000000000000f03f0000000000000040010200000002000000000000000000f03f000000000000004000000000000008400000000000001040", '{"type":"GeometryCollection","geometries":[{"type":"Point","coordinates":[1,2]},{"type":"LineString","coordinates":[[1,2],[3,4]]}]}')
	@:variant("0107000000030000000101000000000000000000f03f0000000000000040010200000002000000000000000000f03f00000000000000400000000000000840000000000000104001030000000300000004000000000000000000f03f00000000000000400000000000000840000000000000104000000000000014400000000000001840000000000000f03f000000000000004004000000000000000000264000000000000028400000000000002a400000000000002c400000000000002e4000000000000030400000000000002640000000000000284004000000000000000000354000000000000036400000000000003740000000000000384000000000000039400000000000003a4000000000000035400000000000003640", '{"type":"GeometryCollection","geometries":[{"type":"Point","coordinates":[1,2]},{"type":"LineString","coordinates":[[1,2],[3,4]]},{"type":"Polygon","coordinates":[[[1,2],[3,4],[5,6],[1,2]],[[11,12],[13,14],[15,16],[11,12]],[[21,22],[23,24],[25,26],[21,22]]]}]}')
	public function test(wkb:String, geojson:String) {
		var wkb = WkbTools.parse(hex(wkb));
		var geojson = Json.parse(geojson);
		asserts.compare(geojson, wkb);
		return asserts.done();
	}
	
	function hex(s:String) {
		var len = s.length >> 1;
		var bytes = Bytes.alloc(len);
		for(i in 0...len) bytes.set(i, Std.parseInt('0x' + s.substr(i * 2, 2)));
		return bytes;
	}
}