# geojson [![Build Status](https://travis-ci.org/kevinresol/geojson.svg?branch=master)](https://travis-ci.org/kevinresol/geojson)

GeoJSON for Haxe. 

Wraps GeoJSON objects with abstracts to provide APIs which are much easier to work with.

## Usage

```haxe
var point = new Point(1.2, 2.1);
trace(point.latitude, point.longitude);
// output: 1.2, 2.1

var lineString = new LineString([
	new Coordinates(1.2, 2.1),
	new Coordinates(1.3, 2.2),
]);
trace(lineString.points[0].latitude, lineString.points[0].longitude);
// output: 1.2, 2.1

trace(haxe.Json.stringify(point, '  '));
/* output:
{
  "type": "Point",
  "coordinates": [
    2.1,
    1.2
  ]
}
*/

trace(haxe.Json.stringify(lineString, '  '));
/* output:
{
  "type": "LineString",
  "coordinates": [
    [
      2.1,
      1.2
    ],
    [
      2.2,
      1.3
    ]
  ]
}
*/
```

More: See tests folder.