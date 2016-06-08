package ;

import geojson.*;
import haxe.unit.*;

class RunTests extends TestCase{

	static function main() {
		var r = new TestRunner();
		r.add(new RunTests());
		
		if(!r.run()) {
			#if sys
				Sys.exit(500);
			#end
			
			#if flash
				flash.system.System.exit(500);
			#end
		}
		
		#if flash
			flash.system.System.exit(0);//Don't forget to exit on flash!
		#end
	}
	
	inline function c(lat, long) return {latitude:lat, longitude:long}
	
	function testPoint() {
		var geo = new Point(c(1.2, 2.1));
		assertEquals('Point', geo.type);
		assertEquals(2.1, geo.coordinates[0]);
		assertEquals(1.2, geo.coordinates[1]);
	}
	
	function testMultiPoint() {
		var geo = new MultiPoint([c(1.2, 2.1),c(1.3, 2.2)]);
		assertEquals('MultiPoint', geo.type);
		assertEquals(2.1, geo.coordinates[0][0]);
		assertEquals(1.2, geo.coordinates[0][1]);
		assertEquals(2.2, geo.coordinates[1][0]);
		assertEquals(1.3, geo.coordinates[1][1]);
	}
	
	function testLineString() {
		var geo = new LineString([c(1.2, 2.1),c(1.3, 2.2)]);
		assertEquals('LineString', geo.type);
		assertEquals(2.1, geo.coordinates[0][0]);
		assertEquals(1.2, geo.coordinates[0][1]);
		assertEquals(2.2, geo.coordinates[1][0]);
		assertEquals(1.3, geo.coordinates[1][1]);
	}
	
	function testMultiLineString() {
		var geo = new MultiLineString([[c(1.2, 2.1),c(1.3, 2.2)], [c(1.4, 2.3),c(1.5, 2.4)]]);
		assertEquals('MultiLineString', geo.type);
		assertEquals(2.1, geo.coordinates[0][0][0]);
		assertEquals(1.2, geo.coordinates[0][0][1]);
		assertEquals(2.2, geo.coordinates[0][1][0]);
		assertEquals(1.3, geo.coordinates[0][1][1]);
		assertEquals(2.3, geo.coordinates[1][0][0]);
		assertEquals(1.4, geo.coordinates[1][0][1]);
		assertEquals(2.4, geo.coordinates[1][1][0]);
		assertEquals(1.5, geo.coordinates[1][1][1]);
	}
	
	function testPolygon() {
		var geo = new Polygon([c(1.2, 2.1),c(1.3, 2.2)]);
		assertEquals('Polygon', geo.type);
		assertEquals(2.1, geo.coordinates[0][0]);
		assertEquals(1.2, geo.coordinates[0][1]);
		assertEquals(2.2, geo.coordinates[1][0]);
		assertEquals(1.3, geo.coordinates[1][1]);
	}
	
	function testMultiRingPolygon() {
		var geo = new MultiRingPolygon([[c(1.2, 2.1),c(1.3, 2.2)], [c(1.4, 2.3),c(1.5, 2.4)]]);
		assertEquals('Polygon', geo.type);
		assertEquals(2.1, geo.coordinates[0][0][0]);
		assertEquals(1.2, geo.coordinates[0][0][1]);
		assertEquals(2.2, geo.coordinates[0][1][0]);
		assertEquals(1.3, geo.coordinates[0][1][1]);
		assertEquals(2.3, geo.coordinates[1][0][0]);
		assertEquals(1.4, geo.coordinates[1][0][1]);
		assertEquals(2.4, geo.coordinates[1][1][0]);
		assertEquals(1.5, geo.coordinates[1][1][1]);
	}
	
	function testMultiPolygon() {
		var geo = new MultiPolygon([[c(1.2, 2.1),c(1.3, 2.2)], [c(1.4, 2.3),c(1.5, 2.4)]]);
		assertEquals('MultiPolygon', geo.type);
		assertEquals(2.1, geo.coordinates[0][0][0]);
		assertEquals(1.2, geo.coordinates[0][0][1]);
		assertEquals(2.2, geo.coordinates[0][1][0]);
		assertEquals(1.3, geo.coordinates[0][1][1]);
		assertEquals(2.3, geo.coordinates[1][0][0]);
		assertEquals(1.4, geo.coordinates[1][0][1]);
		assertEquals(2.4, geo.coordinates[1][1][0]);
		assertEquals(1.5, geo.coordinates[1][1][1]);
	}
	
	
}