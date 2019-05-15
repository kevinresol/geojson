package geojson;

import haxe.DynamicAccess;

@:forward(id, geometry, properties)
abstract Feature<T:Geometry.Typed<T>>(FeatureObject<T>) from FeatureObject<T> to FeatureObject<T> {
	public inline function new(geometry, ?id, ?properties)
		this = {
			type: 'Feature',
			id: id,
			geometry: geometry,
			properties: properties,
		}
		
	public inline function get() return GeometryCollection.get(this.geometry);
}

private typedef FeatureObject<T:Geometry.Typed<T>> = {
	type:String,
	id:String,
	geometry:T,
	properties:DynamicAccess<String>,
}