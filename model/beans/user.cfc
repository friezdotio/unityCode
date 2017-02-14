component persistent="true" {

    property name="userID" generator="native" ormtype="integer" fieldtype="id";
    property name="username" ormtype="string" length="50" notnull="true" required="true";
    property name="password" ormtype="string" length="255" notnull="true" required="true";
    property name="email" ormtype="string" length="255" notnull="true" required="true";
    property name="timeZone" ormtype="string" length="255" default="UTC";
    property name="isActive" ormtype="boolean" default="false" notnull="true" required="true";

    property name="created" ormtype="timestamp" default="#now()#";
    property name="edited" ormtype="timestamp" default="#now()#";

	// Relationships
    property name="profile" fieldType="one-to-one" cfc="profile"
             cascade="all" fkcolumn="profileID" lazy="true";

	property name="permissions" fieldtype="many-to-many" cfc="permission"
    		 type="array" singularname="permission"
    		 linktable="userPermissions" lazy="true";

    property name="forumPosts" fieldType="one-to-many" cfc="forumPost"
             type="array" cascade="all" fkcolumn="userID" inverse="true"
             singularname="forumPost";

    property name="forumTopics" fieldType="one-to-many" cfc="forumTopic"
             type="array" cascade="all" fkcolumn="userID" inverse="true"
             singularname="forumTopic";

	property name="package" fieldType="many-to-one" cfc="package"
             cascade="all" fkcolumn="packageID" ormtype="int" lazy="true";

    property name="presentingTalks" fieldType="one-to-many" cfc="talk"
             type="array" cascade="all" fkcolumn="userID" inverse="true"
             singularname="PresentingTalk";

    property name="registeredTalks" fieldtype="many-to-many" cfc="talk"
    		 type="array" singularname="registeredTalk" inverse="true"
    		 linktable="talkRegistrants" lazy="true";

	property name="attendingTalks" fieldtype="many-to-many" cfc="talk"
    		 type="array" singularname="attendingTalk" inverse="true"
    		 linktable="talkAttendees" lazy="true";

    function init(){
    	return this;
    }

}