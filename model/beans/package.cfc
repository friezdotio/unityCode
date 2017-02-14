component persistent="true" {

    property name="packageID" generator="native" ormtype="integer" fieldtype="id";
    property name="name" ormtype="string" length="50" notnull="true" required="true";
    property name="maxRegistrants" ormtype="integer" notnull="true" required="true";
    property name="isActive" ormtype="boolean" default="true" notnull="true" required="true";

    property name="created" ormtype="timestamp" default="#now()#";
    property name="edited" ormtype="timestamp" default="#now()#";

    function init(){
    	return this;
    }

}