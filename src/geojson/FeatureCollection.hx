package geojson;

@:forward(features)
abstract FeatureCollection<T:Geometry.Typed<T>>(FeatureCollectionObject<T>) from FeatureCollectionObject<T> to FeatureCollectionObject<T> {
	public inline function new(features)
		this = {
			type: 'FeatureCollection',
			features: features,
		}
		
	public inline function iterator() return this.features.iterator();
}

private typedef FeatureCollectionObject<T:Geometry.Typed<T>> = {
	type:String,
	features:Array<Feature<T>>,
}