component {

	public any function populateInital(){
		transaction {

			// Required Guest Package
			local.guestPackage = entityNew("package");
			local.guestPackage.setName("Guest User");
			local.guestPackage.setMaxRegistrants(0);
			local.guestPackage.setIsActive(true);
			local.guestPackage.setCreated(now());
			local.guestPackage.setEdited(now());

			// Required Registered User Package
			local.registeredPackage = entityNew("package");
			local.registeredPackage.setName("Registered User");
			local.registeredPackage.setMaxRegistrants(20);
			local.registeredPackage.setIsActive(true);
			local.registeredPackage.setCreated(now());
			local.registeredPackage.setEdited(now());

			// Required Guest Permission
			local.guestPermission = entityNew("permission");
			local.guestPermission.setName("Guest");
			local.guestPermission.setCreated(now());
			local.guestPermission.setEdited(now());

			// Required User Permission
			local.userPermission = entityNew("permission");
			local.userPermission.setName("User");
			local.userPermission.setCreated(now());
			local.userPermission.setEdited(now());

			// Required Forum Admin Permission
			local.forumAdminPermission = entityNew("permission");
			local.forumAdminPermission.setName("Forum Admin");
			local.forumAdminPermission.setCreated(now());
			local.forumAdminPermission.setEdited(now());

			// Required Talk Admin Permission
			local.talkAdminPermission = entityNew("permission");
			local.talkAdminPermission.setName("Talk Admin");
			local.talkAdminPermission.setCreated(now());
			local.talkAdminPermission.setEdited(now());

			// Required User Admin Permission
			local.userAdminPermission = entityNew("permission");
			local.userAdminPermission.setName("User Admin");
			local.userAdminPermission.setCreated(now());
			local.userAdminPermission.setEdited(now());

			// Required System Admin Permission
			local.systemAdminPermission = entityNew("permission");
			local.systemAdminPermission.setName("System Admin");
			local.systemAdminPermission.setCreated(now());
			local.systemAdminPermission.setEdited(now());

			// Required Guest Profile
			local.guestProfile = entityNew("profile");
			local.guestProfile.setImage("/layouts/assets/img/avatar/blank.png");
			local.guestProfile.setFullName("Guest User");
			local.guestProfile.setLocation("Undefined");
			local.guestProfile.setWebsite("http://unityco.de");
			local.guestProfile.setAboutMe("I am a new member!");

			// Required Admin Profile
			local.adminProfile = entityNew("profile");
			local.adminProfile.setImage("/layouts/assets/img/avatar/blank.png");
			local.adminProfile.setWebsite("http://unityco.de");

			// Required Guest User
			local.guestUser = entityNew("user");
			local.guestUser.setUsername("Guest");
			local.guestUser.setPassword("DO NOT LOG ME IN");
			local.guestUser.setEmail("noreply@unityco.de");
			local.guestUser.setIsActive(true);
			local.guestUser.setCreated(now());
			local.guestUser.setEdited(now());
			local.guestUser.setProfile(local.guestProfile);
			local.guestUser.setPackage(local.guestPackage);
			local.guestUser.addPermission(local.guestPermission);

			// Required Admin User
			local.adminUser = entityNew("user");
			local.adminUser.setUsername("admin");
			local.adminUser.setPassword(hash(application.salt & trim("admin"), "SHA"));
			local.adminUser.setEmail("admin@admin.com");
			local.adminUser.setIsActive(true);
			local.adminUser.setCreated(now());
			local.adminUser.setEdited(now());
			local.adminUser.setProfile(local.adminProfile);
			local.adminUser.setPackage(local.registeredPackage);
			local.adminUser.addPermission(local.userPermission);
			local.adminUser.addPermission(local.forumAdminPermission);
			local.adminUser.addPermission(local.talkAdminPermission);
			local.adminUser.addPermission(local.userAdminPermission);
			local.adminUser.addPermission(local.systemAdminPermission);

			/*          BETA STUFF          */

			// Beta Server Info
			local.betaServer = entityNew("server");
			local.betaServer.setName("Beta Server");
			local.betaServer.setURL("http://Server IP/");
			local.betaServer.setSalt("923x3hh1qzto0f7a8k55rx9llyu8pmft");
			local.betaServer.setIsActive(true);

			// Beta Tag Info
			local.coldfusionTag = entityNew("tag");
			local.coldfusionTag.setName("coldfusion");
			local.coldfusionTag.setCreated(now());
			local.coldfusionTag.setEdited(now());

			// Beta Talk Info
			local.betaTalk = entityNew("talk");
			local.betaTalk.setTitle("Beta Talk");
			local.betaTalk.setDescription("This is a talk about the Beta");
			local.betaTalk.setShortDescription("This is a talk about the Beta");
			local.betaTalk.setStart(now());
			local.betaTalk.setIsActive(true);
			local.betaTalk.setPresenter(local.adminUser);
			local.betaTalk.setServer(local.betaServer);
			local.betaTalk.addTag(local.coldfusionTag);

			// Save All of the Things
			entitySave(local.guestPackage);
			entitySave(local.registeredPackage);
			entitySave(local.guestPermission);
			entitySave(local.forumAdminPermission);
			entitySave(local.talkAdminPermission);
			entitySave(local.userAdminPermission);
			entitySave(local.systemAdminPermission);
			entitySave(local.userPermission);
			entitySave(local.guestProfile);
			entitySave(local.adminProfile);
			entitySave(local.guestUser);
			entitySave(local.adminUser);

			/*          BETA STUFF          */

			entitySave(local.betaServer);
			entitySave(local.coldfusionTag);
			entitySave(local.betaTalk);


			transaction action="commit";
		}
    }

    public struct function xmlToStruct( any xmlObject ) {

		var rootName = "";
		var retVal = {};
		var c = 0;

		if (structKeyExists(arguments.xmlObject,"xmlRoot")) {
			rootName = xmlObject.xmlRoot.xmlName;
			retVal[rootName] = {};
			xmlObject = xmlObject.xmlRoot;
		}

		for (c in xmlObject.xmlChildren) {
			var i = 1;
			structInsert(
				(len(rootName) > 0) ? retVal[local.rootName] : retVal,
				((!structKeyExists((len(rootName) > 0) ? retVal[local.rootName] : retVal,c.xmlName))?c.xmlName : c.xmlName & i),
				(arrayLen(c.xmlChildren) > 0) ? xmlToStruct(c) : c.xmltext,
				true
			);
			i++;
		}
		return retVal;
	}

	public any function timeZoneConvert(timeStamp,timeZoneFrom,timeZoneTo){

		// Initialize the Java Timezone objects.
	    local.JavaTimeZoneFrom = createObject("java", "java.util.TimeZone").getTimeZone(javaCast("string", arguments.timeZoneFrom));
	    local.JavaTimeZoneTo   = createObject("java", "java.util.TimeZone").getTimeZone(javaCast("string", arguments.timeZoneTo  ));

	    // Initialize the Gregorian Calendar objects.
	    local.JavaCalendarFrom = createObject("java", "java.util.GregorianCalendar").init(local.JavaTimeZoneFrom);
	    local.JavaCalendarTo   = createObject("java", "java.util.GregorianCalendar").init(local.JavaTimeZoneTo  );

	    // Initialize a formatter so we can use the output.
	    local.formatter = createObject( "java", "java.text.SimpleDateFormat").init(javaCast("string", "MM/dd/yyyy h:mm:ss aa"));

	    // Set the timezone for the formatter.

	    local.formatter.setTimeZone(local.JavaCalendarTo.getTimeZone());

	    // Set the first calendar to the specified date and time.
	    local.JavaCalendarFrom.set(
	        javaCast("int", year(arguments.timeStamp)),
	        javaCast("int", (month(arguments.timeStamp) - 1)),
	    	javaCast("int", day(arguments.timeStamp)),
	        javaCast("int", hour(arguments.timeStamp)),
	        javaCast("int", minute(arguments.timeStamp)),
	        javaCast("int", second(arguments.timeStamp))
	    );

	    // Convert the time between time zones.
	    local.JavaCalendarTo.setTimeInMillis(local.JavaCalendarFrom.getTimeInMillis());

	    // Return the formatted date in the given timezone.
	    return parseDateTime(local.formatter.format(local.JavaCalendarTo.getTime()));

	}

	public any function getTimeZones(){

		local.timezoneClass = createObject("java","java.util.TimeZone");

		/*
		    Now, get the IDs. Each ID is a simple string that represents a
		    specific location, timezone, and daylight savings time
		    combination. There are an insane number of these combinations!
		*/

		return local.timezoneClass.getAvailableIDs();

	}

}