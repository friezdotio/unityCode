component persistent="true" {

    property name="forumCategoryID" generator="native" ormtype="integer" fieldtype="id";
    property name="label" ormtype="string" length="50" notnull="true" required="true";
    property name="description" ormtype="string" length="255" notnull="false" required="false";
    property name="order" ormtype="integer" notnull="true" required="true";
    property name="isActive" ormtype="boolean" default="false" notnull="true" required="true";

	// Relationships

	property name="forumSubCategories" fieldType="one-to-many" cfc="forumSubCategory"
             type="array" cascade="all" fkcolumn="forumCategoryID"
             singularname="forumSubCategory" inverse="true" orderBy="order ASC";

	property name="permissions" fieldtype="many-to-many" cfc="permission"
    		 type="array" singularname="permission"
    		 linktable="forumPermissions" lazy="true";

    function init(){
    	return this;
    }

    public any function getActiveForumSubCategories(){

		return entityLoad("forumSubCategory",{isActive=true,forumCategory=this});

    }

}