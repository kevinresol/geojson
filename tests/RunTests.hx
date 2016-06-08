package ;

import geojson.*;
import geojson.util.*;
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
	
	inline function c(lat, long) return new Coordinates(lat, long);
	
	function testPoint() {
		var geo = new Point(1.2, 2.1);
		assertEquals('Point', geo.type);
		assertEquals(2.1, geo.longitude);
		assertEquals(1.2, geo.latitude);
	}
	
	function testMultiPoint() {
		var geo = new MultiPoint([c(1.2, 2.1),c(1.3, 2.2)]);
		assertEquals('MultiPoint', geo.type);
		assertEquals(2.1, geo.points[0].longitude);
		assertEquals(1.2, geo.points[0].latitude);
		assertEquals(2.2, geo.points[1].longitude);
		assertEquals(1.3, geo.points[1].latitude);
	}
	
	function testLineString() {
		var geo = new LineString([c(1.2, 2.1),c(1.3, 2.2)]);
		assertEquals('LineString', geo.type);
		assertEquals(2.1, geo.points[0].longitude);
		assertEquals(1.2, geo.points[0].latitude);
		assertEquals(2.2, geo.points[1].longitude);
		assertEquals(1.3, geo.points[1].latitude);
	}
	
	function testMultiLineString() {
		var geo = new MultiLineString([[c(1.2, 2.1),c(1.3, 2.2)], [c(1.4, 2.3),c(1.5, 2.4)]]);
		assertEquals('MultiLineString', geo.type);
		assertEquals(2.1, geo.lines[0].points[0].longitude);
		assertEquals(1.2, geo.lines[0].points[0].latitude);
		assertEquals(2.2, geo.lines[0].points[1].longitude);
		assertEquals(1.3, geo.lines[0].points[1].latitude);
		assertEquals(2.3, geo.lines[1].points[0].longitude);
		assertEquals(1.4, geo.lines[1].points[0].latitude);
		assertEquals(2.4, geo.lines[1].points[1].longitude);
		assertEquals(1.5, geo.lines[1].points[1].latitude);
	}
	
	function testPolygon() {
		var geo = new Polygon([c(1.2, 2.1),c(1.3, 2.2)]);
		assertEquals('Polygon', geo.type);
		assertEquals(2.1, geo.points[0].longitude);
		assertEquals(1.2, geo.points[0].latitude);
		assertEquals(2.2, geo.points[1].longitude);
		assertEquals(1.3, geo.points[1].latitude);
	}
	
	function testMultiRingPolygon() {
		var geo = new MultiRingPolygon([[c(1.2, 2.1),c(1.3, 2.2)], [c(1.4, 2.3),c(1.5, 2.4)]]);
		assertEquals('Polygon', geo.type);
		assertEquals(2.1, geo.rings[0].points[0].longitude);
		assertEquals(1.2, geo.rings[0].points[0].latitude);
		assertEquals(2.2, geo.rings[0].points[1].longitude);
		assertEquals(1.3, geo.rings[0].points[1].latitude);
		assertEquals(2.3, geo.rings[1].points[0].longitude);
		assertEquals(1.4, geo.rings[1].points[0].latitude);
		assertEquals(2.4, geo.rings[1].points[1].longitude);
		assertEquals(1.5, geo.rings[1].points[1].latitude);
	}
	
	function testMultiPolygon() {
		var geo = new MultiPolygon([[c(1.2, 2.1),c(1.3, 2.2)], [c(1.4, 2.3),c(1.5, 2.4)]]);
		assertEquals('MultiPolygon', geo.type);
		assertEquals(2.1, geo.polygons[0].points[0].longitude);
		assertEquals(1.2, geo.polygons[0].points[0].latitude);
		assertEquals(2.2, geo.polygons[0].points[1].longitude);
		assertEquals(1.3, geo.polygons[0].points[1].latitude);
		assertEquals(2.3, geo.polygons[1].points[0].longitude);
		assertEquals(1.4, geo.polygons[1].points[0].latitude);
		assertEquals(2.4, geo.polygons[1].points[1].longitude);
		assertEquals(1.5, geo.polygons[1].points[1].latitude);
	}
	
	
}