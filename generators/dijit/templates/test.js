dojo.require("doh.runner");
//dojo.require("dojo.robot");
dojo.require("<%= dijit_full_name %>");

dojo.addOnLoad(function () {
	doh.register("<%= dijit_full_name %>", [
	function test(t) {
    t.t(false,"not implemented");
	}]);
	doh.run();
});
