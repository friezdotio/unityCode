component persistent="true" {

    property name="talkID" generator="native" ormtype="integer" fieldtype="id";
    property name="title" ormtype="string" length="50" notnull="true" required="true";
    property name="shortDescription" ormtype="string" length="255" notnull="true" required="true";
    property name="description" ormtype="text" notnull="true" required="true";
    property name="image" ormtype="string" length="255" default="/layouts/assets/img/defaults/817x320.jpg";
    property name="presenterPassword" ormtype="string" length="255" default="#RandRange(10000, 99999)#" notnull="true" required="true";
    property name="attendeePassword" ormtype="string" length="255" default="#RandRange(10000, 99999)#" notnull="true" required="true";
    property name="isFeatured" ormtype="boolean" default="false" notnull="true" required="true";
    property name="isRecording" ormtype="boolean" default="false" notnull="true" required="true";
    property name="isActive" ormtype="boolean" default="true" notnull="true" required="true";

    property name="start" ormtype="timestamp" default="#now()#";
    property name="created" ormtype="timestamp" default="#now()#";
    property name="edited" ormtype="timestamp" default="#now()#";

    property name="server" fieldType="many-to-one" cfc="server";

    property name="presenter" fieldType="many-to-one" cfc="user";

    property name="registrants" fieldtype="many-to-many" cfc="user"
    		 type="array" singularname="registrant"
    		 linktable="talkRegistrants" lazy="true";

    property name="attendees" fieldtype="many-to-many" cfc="user"
    		 type="array" singularname="attendee"
    		 linktable="talkAttendees" lazy="true";

    property name="tags" fieldtype="many-to-many" cfc="tag"
    		 type="array" singularname="tag"
    		 linktable="talkTags" lazy="true";

    function init(){
    	return this;
    }

     public any function getIsFull(){
		local.isFull = false;
		if(arrayLen(this.getRegistrants()) GTE this.getPresenter().getPackage().getMaxRegistrants()){
			local.isFull = true;
		}

		return local.isFull;
     }

	public any function getCompareDay(){
		return dateCompare(now(), this.getStart(), 'd');
	}

	public any function getLocalStart(){
		return application.baseServices.timeZoneConvert(this.getStart(),application.timezone,session.user.timezone);
	}

}