component persistent="true" {

    property name="tagID" generator="native" ormtype="integer" fieldtype="id";
    property name="name" ormtype="string" length="255" notnull="true" required="true";

    property name="created" ormtype="timestamp" default="#now()#";
    property name="edited" ormtype="timestamp" default="#now()#";

    // Relationships
	property name="talks" fieldtype="many-to-many" cfc="talk"
    		 type="array" singularname="user" linktable="talkTags"
    		 inverse="true" lazy="true";

    function init(){
    	return this;
    }

}