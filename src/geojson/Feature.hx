package geojson;

import haxe.DynamicAccess;

@:forward(id, geometry, properties)
abstract Feature<T:Geometry.Typed<T>>(FeatureObject<T>) from FeatureObject<T> to FeatureObject<T> {
	public inline function new(geometry, ?properties:DynamicAccess<Any>, ?id:String) {
		this = {
			type: 'Feature',
			geometry: geometry,
			properties: properties,
		}
		if(id != null) this.id = id;
	}
		
	public inline function get() return GeometryCollection.get(this.geometry);
}

private typedef FeatureObject<T:Geometry.Typed<T>> = {
	type:String,
	geometry:T,
	properties:DynamicAccess<Any>,
	?id:String,
}