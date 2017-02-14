component persistent="true" {

    property name="profileID" generator="native" ormtype="integer" fieldtype="id";
    property name="image" ormtype="string" default="/layouts/assets/img/avatar/blank.png" length="255";
    property name="fullName" ormtype="string" length="255";
    property name="location" ormtype="string" length="255";
    property name="website"  ormtype="string" length="255";
    property name="aboutMe"  ormtype="text";
    property name="facebook" ormtype="string" length="255";
    property name="twitter" ormtype="string" length="255";
    property name="linkedin" ormtype="string" length="255";
    property name="google" ormtype="string" length="255";

    function init(){
    	return this;
    }

}