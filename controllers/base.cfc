component accessors=true{

	property baseServices;
	property forumServices;
	property permissionServices;
	property profileServices;
	property userServices;
	property serverServices;
	property talkServices;
	property tagServices;
	property mediaServices;

	function init( fw ) {

		if (structKeyExists(arguments, "fw")){
			variables.fw = arguments.fw;
		}

		return this;
	}

}