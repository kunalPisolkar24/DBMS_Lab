 
var mapFunction = function() {
  emit(this.product, this.quantity * this.price);
};
var reduceFunction = function(key, values) {
  return Array.sum(values);
};
db.sales.mapReduce(
  mapFunction,
  reduceFunction,
  {
    out: "total_revenue"  // Store results in a new collection
  }
);
{ "_id" : "Widget A", "value" : 159.9 }
{ "_id" : "Widget B", "value" : 102.5 }
{ "_id" : "Widget C", "value" : 324.3 }
