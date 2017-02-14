component persistent="true" {

    property name="serverID" generator="native" ormtype="integer" fieldtype="id";
    property name="name" ormtype="string" length="50" notnull="true" required="true";
    property name="url" ormtype="string" length="255" notnull="true" required="true";
    property name="salt" ormtype="string" length="255" notnull="true" required="true";
    property name="isActive" ormtype="boolean" default="false" notnull="true" required="true";

    property name="talks" fieldType="one-to-many" cfc="talk"
             type="array" cascade="all" fkcolumn="serverID" inverse="true"
             singularname="talk";

    function init(){
    	return this;
    }

}