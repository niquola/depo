/**
 * <%= dijit_full_name %>
 * Created by <%= config.author %> 
 **/
dojo.provide("<%= dijit_full_name %>");
<% if dijit_base_class != 'null' %> 
dojo.require("<%= dijit_base_class %>"); 
<% end %>
(function () {
	//here go private vars and functions
	dojo.declare("<%= dijit_full_name %>",<%= dijit_base_class %>, {
		// summary:
		//  HERE WIDGET SUMMARY 
    
		// baseClass: [protected] String
		baseClass: "<%= dijit_style_class_name %>",
    //templateString: dojo.cache("<%= dijit_package_name %>", "templates/<%= dijit_class_name %>.html"),
    //widgetsInTemplate: true,
		//buildRendering: function () {
			//this.inherited(arguments);
		//},
		//layout: function () {
			//var cb = this._contentBox;
      //dojo.marginBox(this.containerNode, cb);
		//},
		//postCreate: function () {
			//this.inherited(arguments);
		//}
  });
});
