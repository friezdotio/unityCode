component persistent="true" {

    property name="permissionID" generator="native" ormtype="integer" fieldtype="id";
    property name="name" ormtype="string" length="255" notnull="true" required="true";

    property name="created" ormtype="timestamp" default="#now()#";
    property name="edited" ormtype="timestamp" default="#now()#";

    // Relationships
	property name="users" fieldtype="many-to-many" cfc="user"
    		 type="array" singularname="user" linktable="userPermissions"
    		 inverse="true" lazy="true";

    property name="forumCategories" fieldtype="many-to-many" cfc="forumCategory"
    		 type="array" singularname="forumCategory"
    		 inverse="true" linktable="forumPermissions" lazy="true";

    function init(){
    	return this;
    }

}