component persistent="true" {

    property name="forumPostID" generator="native" ormtype="integer" fieldtype="id";
    property name="title" ormtype="string" length="50" notnull="true" required="true";
    property name="body" ormtype="text" notnull="true" required="true";
    property name="isActive" ormtype="boolean" default="false" notnull="true" required="true";

	property name="created" ormtype="timestamp" default="#now()#";
    property name="edited" ormtype="timestamp" default="#now()#";

	// Relationships

    property name="user" fieldType="many-to-one" cfc="user";

    property name="forumTopic" fieldType="many-to-one" cfc="forumTopic"
    		 orderBy="isSticky,created DESC";

    function init(){
    	return this;
    }

    public any function getLocalCreated(){
    	return application.baseServices.timeZoneConvert(this.getCreated(),application.timezone,session.user.timezone);
    }

}