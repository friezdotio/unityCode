component extends="baseServices" {

	this.timeOffset = -60;

	public any function get(id){
		return entityLoad("talk");
    }

	public function getByPK(numeric id) {
        return entityLoadByPk("talk", arguments.id);
    }

    public function getByTag(tag,maxResults,offset) {

		if(len(arguments.offset)){
			local.hqlObject = ORMExecuteQuery("
				SELECT DISTINCT t
	    		FROM talk t
	    		JOIN t.tags tg
		      	WHERE tg.name = :tag
		      	AND t.isActive = true
		      	ORDER BY t.start ASC
		  		",{tag=arguments.tag
		       	,maxresults=arguments.maxResults
		       	,offset=arguments.offset - 1}
			);
		}
		else if(len(arguments.maxResults)){
			local.hqlObject = ORMExecuteQuery("
	    		SELECT DISTINCT t
	    		FROM talk t
	    		JOIN t.tags tg
		      	WHERE tg.name = :tag
		      	AND t.isActive = true
		      	ORDER BY t.start ASC
		      	",{tag=arguments.tag
		        ,maxresults=arguments.maxResults}
			);
		}
		else{
			local.hqlObject = ORMExecuteQuery("
	    		SELECT DISTINCT t
	    		FROM talk t
	    		JOIN t.tags tg
		      	WHERE tg.name = :tag
		      	AND t.isActive = true
		      	ORDER BY (CASE when t.isFeatured = true THEN 1 ELSE 0 END) DESC, t.start ASC
		      	",{tag=arguments.tag}
			);
		}

		return local.hqlObject;

    }

    public function getUpcoming(maxResults,offset) {

		if(len(arguments.offset)){
			local.hqlObject = ORMExecuteQuery("
	    		FROM talk
		      	WHERE start > :dateNow
		      	AND isActive = true
		      	ORDER BY (CASE when isFeatured = true THEN 1 ELSE 0 END) DESC, start ASC
		  		",{dateNow=DateAdd("n", this.timeOffset, now())
		       	,maxresults=arguments.maxResults
		       	,offset=arguments.offset - 1}
			);
		}
		else{
			local.hqlObject = ORMExecuteQuery("
	    		FROM talk
		      	WHERE start > :dateNow
		      	AND isActive = true
		      	ORDER BY (CASE when isFeatured = true THEN 1 ELSE 0 END) DESC, start ASC
		      	",{dateNow=DateAdd("n", this.timeOffset, now())
		        ,maxresults=arguments.maxResults}
			);
		}

		return local.hqlObject;
    }

     public function getPopular(maxResults,offset) {

		if(len(arguments.offset)){
			local.hqlObject = ORMExecuteQuery("
	    		FROM talk
		      	WHERE start > :dateNow
		      	AND isActive = true
		        ORDER BY (CASE when isFeatured = true THEN 1 ELSE 0 END) DESC, registrants.size
		        ",{dateNow=DateAdd("n", this.timeOffset, now())
		        ,maxresults=arguments.maxResults
		        ,offset=arguments.offset - 1}
			);
		}
		else{
			local.hqlObject = ORMExecuteQuery("
	     		FROM talk
			  	WHERE start > :dateNow
			  	AND isActive = true
			    ORDER BY (CASE when isFeatured = true THEN 1 ELSE 0 END) DESC, registrants.size
			    ",{dateNow=DateAdd("n", this.timeOffset, now())
			    ,maxresults=arguments.maxResults}
			);
		}

		return local.hqlObject;
    }

    public function getPast(maxResults,offset) {

		if(len(arguments.offset)){
			local.hqlObject = ORMExecuteQuery("
	    		FROM talk
		      	WHERE start < :dateNow
		      	AND isActive = true
		      	ORDER BY start DESC
		        ",{dateNow=DateAdd("n", this.timeOffset, now())
		        ,maxresults=arguments.maxResults
		        ,offset=arguments.offset - 1}
	    	);
		}
		else if(len(arguments.maxResults)){
			local.hqlObject = ORMExecuteQuery("
	    		FROM talk
		      	WHERE start < :dateNow
		      	AND isActive = true
		      	ORDER BY start DESC
		        ",{dateNow=DateAdd("n", this.timeOffset, now())
		        ,maxresults=arguments.maxResults}
	        );
		}

		return local.hqlObject;
    }

    public function getByPresenter(user,maxResults,offset) {

		if(len(arguments.offset)){
			local.hqlObject = ORMExecuteQuery("
	    		FROM talk
		      	WHERE isActive = true
		      	AND presenter = :user
		      	ORDER BY start ASC
		  		",{maxresults=arguments.maxResults
		       	,user=arguments.user
		       	,offset=arguments.offset - 1}
			);
		}
		else{
			local.hqlObject = ORMExecuteQuery("
	    		FROM talk
		      	WHERE isActive = true
		      	AND presenter = :user
		      	ORDER BY start ASC
		  		",{maxresults=arguments.maxResults
		       	,user=arguments.user}
			);
		}

		return local.hqlObject;
    }

    public function getByRegistrant(user,maxResults,offset) {

		if(len(arguments.offset)){
			local.hqlObject = ORMExecuteQuery("
				SELECT t
	    		FROM talk t
	    		JOIN t.registrants r
		      	WHERE r.isActive = true
		      	AND r = :user
		      	ORDER BY start ASC
		  		",{maxresults=arguments.maxResults
		       	,user=arguments.user
		       	,offset=arguments.offset - 1}
			);
		}
		else{
			local.hqlObject = ORMExecuteQuery("
				SELECT t
				FROM talk t
	    		JOIN t.registrants r
		      	WHERE r.isActive = true
		      	AND r = :user
		      	ORDER BY start ASC
		  		",{maxresults=arguments.maxResults
		       	,user=arguments.user}
			);
		}

		return local.hqlObject;
    }

    public function getActionButton(talk,user,isAdmin) {

    	local.talk = arguments.talk;
    	local.user = arguments.user;
    	local.isAdmin = arguments.isAdmin;
    	local.userSession = session.user;
    	local.isRunning = this.isTalkRunning(local.talk);
    	local.compareDay = local.talk.getCompareDay();
    	local.isFull = local.talk.getIsFull();

    	// Default Button
    	local.actionButton.url = "";
		local.actionButton.value = "Something's Happening";
		local.actionButton.target = "_self";

    	// Guest Users
    	if(!local.userSession.isLoggedin){
    		// Talks Not Running
    		if(!local.isRunning){
    			// Talks before start date
	    		if(local.talk.getStart() GT DateAdd("n", this.timeOffset, now())){
	    			local.actionButton.url = "user.signup";
	    			local.actionButton.queryString = "";
					local.actionButton.value = "Signup to RSVP";
					local.actionButton.target = "_self";
	    		}
	    		// Talks after start date
	    		else if(local.talk.getStart() LT DateAdd("n", this.timeOffset, now())){
	    			local.actionButton.url = "user.signup";
	    			local.actionButton.queryString = "";
					local.actionButton.value = "Signup to Download Talk";
					local.actionButton.target = "_self";
	    		}
    		}
    		// Talk is Running
    		if(local.isRunning){
    			local.actionButton.url = "user.signup";
    			local.actionButton.queryString = "";
				local.actionButton.value = "Sign Up Now!";
				local.actionButton.target = "_self";
    		}
    	}

    	// Admin Users
    	if(local.userSession.isLoggedin AND local.isAdmin){
    		// Talks Not Running
    		if(!local.isRunning){
    			// Talks before start date
	    		if(local.compareDay EQ -1){
	    			local.actionButton.url = "talk.add";
					local.actionButton.queryString = "talkid=#local.talk.getTalkID()#";
					local.actionButton.value = "Edit Talk";
					local.actionButton.target = "_self";
	    		}
	    		else if(local.compareDay EQ 1 OR local.talk.getStart() LTE DateAdd("n", this.timeOffset, now())){
	    			local.actionButton.url = "";
	    			local.actionButton.queryString = "";
					local.actionButton.value = "Talk has Ended";
					local.actionButton.target = "_self";
	    		}
	    		// Talks at start date
	    		else if(local.compareDay EQ 0 AND local.talk.getStart() GTE DateAdd("n", this.timeOffset, now()) AND now() GTE DateAdd("n",-10,local.talk.getStart())){
	    			local.actionButton.url = "talk.join";
					local.actionButton.queryString = "talkid=#local.talk.getTalkID()#";
					local.actionButton.value = "Start Talk";
					local.actionButton.target = "_blank";
	    		}
	    		else{
	    			local.actionButton.url = "talk.add";
					local.actionButton.queryString = "talkid=#local.talk.getTalkID()#";
					local.actionButton.value = "Edit Talk";
					local.actionButton.target = "_self";
	    		}
    		}
    		// Talk is Running
    		if(local.isRunning){
    			local.actionButton.url = "talk.join";
				local.actionButton.queryString = "talkid=#local.talk.getTalkID()#";
				local.actionButton.value = "Join Talk";
				local.actionButton.target = "_blank";
    		}
    	}

		// Presenter User
    	if(local.userSession.isLoggedin AND local.talk.getPresenter().getUserID() EQ local.userSession.userid){
    		// Talks Not Running
    		if(!local.isRunning){
    			// Talks before start date
	    		if(local.compareDay EQ -1){
	    			local.actionButton.url = "talk.add";
	    			local.actionButton.queryString = "talkid=#local.talk.getTalkID()#";
					local.actionButton.value = "Edit Talk";
					local.actionButton.target = "_self";
	    		}
	    		// Talks at start date
	    		else if(local.compareDay EQ 1 OR local.talk.getStart() LTE DateAdd("n", this.timeOffset, now())){
	    			local.actionButton.url = "";
	    			local.actionButton.queryString = "";
					local.actionButton.value = "Talk has Ended";
					local.actionButton.target = "_self";
	    		}
	    		else if(local.compareDay EQ 0 AND local.talk.getStart() GTE DateAdd("n", this.timeOffset, now()) AND now() GTE DateAdd("n",-10,local.talk.getStart())){
	    			local.actionButton.url = "talk.join";
					local.actionButton.queryString = "talkid=#local.talk.getTalkID()#";
					local.actionButton.value = "Start Talk";
					local.actionButton.target = "_blank";
	    		}
	    		else{
	    			local.actionButton.url = "talk.add";
					local.actionButton.queryString = "talkid=#local.talk.getTalkID()#";
					local.actionButton.value = "Edit Talk";
					local.actionButton.target = "_self";
	    		}
    		}
    		// Talk is Running
    		if(local.isRunning){
    			local.actionButton.url = "talk.join";
				local.actionButton.queryString = "talkid=#local.talk.getTalkID()#";
				local.actionButton.value = "Join Talk";
				local.actionButton.target = "_blank";
    		}
    	}

    	// Registered Logged In Users
    	if(local.userSession.isLoggedin AND local.talk.getPresenter().getUserID() NEQ local.userSession.userid AND local.talk.hasRegistrant(local.user)){
    		// Talks Not Running
    		if(!local.isRunning){
    			// Talks before start date
	    		if(local.compareDay EQ -1){
	    			local.actionButton.url = "";
	    			local.actionButton.queryString = "";
					local.actionButton.value = "Already RSVPed";
					local.actionButton.target = "_self";
	    		}
	    		else if(local.compareDay EQ 1 OR local.talk.getStart() LTE DateAdd("n", this.timeOffset, now())){
	    			local.actionButton.url = "";
	    			local.actionButton.queryString = "";
					local.actionButton.value = "Talk has Ended";
					local.actionButton.target = "_self";
	    		}
	    		// Talks at start date
	    		else if(local.compareDay EQ 0 AND local.talk.getStart() GTE DateAdd("n", this.timeOffset, now())){
	    			local.actionButton.url = "";
	    			local.actionButton.queryString = "";
					local.actionButton.value = "Waiting for Presenter";
					local.actionButton.target = "_self";
	    		}
	    		else{
	    			local.actionButton.url = "";
	    			local.actionButton.queryString = "";
					local.actionButton.value = "Already RSVPed";
					local.actionButton.target = "_self";
	    		}
    		}
    		// Talk is Running
    		if(local.isRunning){
    			if(local.talk.getStart() GTE NOW()){
	    			local.actionButton.url = "talk.join";
					local.actionButton.queryString = "talkid=#local.talk.getTalkID()#";
					local.actionButton.value = "Join Talk";
					local.actionButton.target = "_blank";
	    		}
	    		else if(local.talk.getStart() LT NOW()){
	    			local.actionButton.url = "";
	    			local.actionButton.queryString = "";
					local.actionButton.value = "Already RSVPed";
					local.actionButton.target = "_self";
	    		}
	    		else{
	    			local.actionButton.url = "";
	    			local.actionButton.queryString = "";
					local.actionButton.value = "Something's Happening";
					local.actionButton.target = "_self";
	    		}
    		}
    	}

    	// Unregistered Logged In Users
    	if(local.userSession.isLoggedin AND local.talk.getPresenter().getUserID() NEQ local.userSession.userid AND !local.talk.hasRegistrant(local.user)){
    		// Talks Not Running
    		if(!local.isRunning){
    			// Talk is full
    			if(local.isFull){
    				// Talks before start date
		    		if(local.compareDay EQ -1){
		    			local.actionButton.url = "";
		    			local.actionButton.queryString = "";
						local.actionButton.value = "Talk is Full";
						local.actionButton.target = "_self";
		    		}
		    		else if(local.compareDay EQ 1 OR local.talk.getStart() LTE DateAdd("n", this.timeOffset, now())){
		    			local.actionButton.url = "";
		    			local.actionButton.queryString = "";
						local.actionButton.value = "Talk has Ended";
						local.actionButton.target = "_self";
		    		}
		    		// Talks at start date
		    		else if(local.compareDay EQ 0 AND local.talk.getStart() GTE DateAdd("n", this.timeOffset, now())){
		    			local.actionButton.url = "";
		    			local.actionButton.queryString = "";
						local.actionButton.value = "Talk is Full";
						local.actionButton.target = "_self";
		    		}
		    		else{
		    			local.actionButton.url = "";
		    			local.actionButton.queryString = "";
						local.actionButton.value = "Talk is Full";
						local.actionButton.target = "_self";
		    		}
    			}
    			// Talk has slots
    			else{
    				// Talks before start date
		    		if(local.compareDay EQ -1){
		    			local.actionButton.url = "talk.rsvp";
						local.actionButton.queryString = "talkid=#local.talk.getTalkID()#";
						local.actionButton.value = "RSVP";
						local.actionButton.target = "_self";
		    		}
		    		else if(local.compareDay EQ 1 OR local.talk.getStart() LTE DateAdd("n", this.timeOffset, now())){
		    			local.actionButton.url = "";
		    			local.actionButton.queryString = "";
						local.actionButton.value = "Talk has Ended";
						local.actionButton.target = "_self";
		    		}
		    		// Talks at start date
		    		else if(local.compareDay EQ 0 AND local.talk.getStart() GTE DateAdd("n", this.timeOffset, now())){
		    			local.actionButton.url = "";
		    			local.actionButton.queryString = "";
						local.actionButton.value = "Happening Now";
						local.actionButton.target = "_self";
		    		}
		    		else{
		    			local.actionButton.url = "talk.rsvp";
						local.actionButton.queryString = "talkid=#local.talk.getTalkID()#";
						local.actionButton.value = "RSVP";
						local.actionButton.target = "_self";
		    		}
    			}
    		}
    		// Talk is Running
    		if(local.isRunning){
    			// Talk is full
    			if(local.isFull){
	    			if(local.talk.getStart() GTE NOW()){
		    			local.actionButton.url = "";
		    			local.actionButton.queryString = "";
						local.actionButton.value = "Happening Now";
						local.actionButton.target = "_self";
		    		}
		    		else if(local.talk.getStart() LT NOW()){
		    			local.actionButton.url = "";
		    			local.actionButton.queryString = "";
						local.actionButton.value = "Talk is Full";
						local.actionButton.target = "_self";
		    		}
		    		else{
		    			local.actionButton.url = "";
		    			local.actionButton.queryString = "";
						local.actionButton.value = "Something's Happening";
						local.actionButton.target = "_self";
		    		}
    			}
    			// Talk as slots
    			else{
    				if(local.talk.getStart() GTE NOW()){
		    			local.actionButton.url = "";
		    			local.actionButton.queryString = "";
						local.actionButton.value = "Happening Now";
						local.actionButton.target = "_self";
		    		}
		    		else if(local.talk.getStart() LT NOW()){
		    			local.actionButton.url = "talk.rsvp";
						local.actionButton.queryString = "talkid=#local.talk.getTalkID()#";
						local.actionButton.value = "RSVP";
						local.actionButton.target = "_self";
		    		}
		    		else{
		    			local.actionButton.url = "";
		    			local.actionButton.queryString = "";
						local.actionButton.value = "Something's Happening";
						local.actionButton.target = "_self";
		    		}
    			}
    		}
    	}

    	return local.actionButton;
    }

    public function addRSVP(user,talk) {

		transaction{
			local.talk = arguments.talk;
			local.user = arguments.user;

	    	local.talk.addRegistrant(local.user);

	    	entitySave(local.talk);


			transaction action="commit";
		}

    }

    public any function save(talk,user,server,title,shortDescription,description,tags,image,start){

		transaction{
			if(isObject(arguments.talk)){
				local.talk = arguments.talk;
			}
			else{
				local.talk = entityNew("talk");
			}

			local.talk.setTitle(arguments.title);
			local.talk.setShortDescription(arguments.shortDescription);
			local.talk.setDescription(arguments.description);
			local.talk.setIsActive(true);
			local.talk.setIsRecording(true);
			local.talk.setPresenter(arguments.user);
			local.talk.setServer(arguments.server);
			local.talk.setStart(CreateODBCDateTime(arguments.start));
			if(len(arguments.image)){
				local.talk.setImage(arguments.image);
			}

			// Removes all permissions to start fresh
			if(isObject(arguments.talk)){
				for(local.tag in local.talk.getTags()){
					entityDelete(local.tag);
				}
				local.talk.getTags().clear();
			}

			local.tags = listToArray(arguments.tags);
			for(local.tag in local.tags){
				local.objTag = entityNew("tag");
				local.objTag.setName(lcase(local.tag));
				local.talk.addTag(local.objTag);
				entitySave(local.objTag);
			}

	    	entitySave(local.talk);

			transaction action="commit";
		}

    	return local.talk.getTalkID();
    }

    /*		BBB API Methods		*/

    public function createTalk(talk){

		local.talkObj = arguments.talk;

    	local.url = local.talkObj.getServer().getURL();
    	local.salt = local.talkObj.getServer().getSalt();
    	local.call = "create";

		local.queryStringClean = "meetingID=#encodeForURL(local.talkObj.getTalkID())#";
		local.queryStringClean = local.queryStringClean & "&attendeePW=#local.talkObj.getAttendeePassword()#";
		local.queryStringClean = local.queryStringClean & "&moderatorPW=#local.talkObj.getPresenterPassword()#";
		if(local.talkObj.getIsRecording()){
			local.queryStringClean = local.queryStringClean & "&record=true";
			local.queryStringClean = local.queryStringClean & "&autoStartRecording=true";
			local.queryStringClean = local.queryStringClean & "&allowStartStopRecording=false";
		}

		local.queryStringPrepend = local.call & local.queryStringClean;
		local.queryStringAppend  = local.queryStringPrepend & local.salt;

    	local.checksum = lCase(hash(local.queryStringAppend, "SHA"));
    	local.queryStringFinal = local.queryStringClean & "&checksum=" & local.checksum;
		local.finalURL = local.url & "bigbluebutton/api/" & local.call & "?" & local.queryStringFinal;

    	cfhttp(method="POST", url="#local.finalURL#", result="local.result");

	    return xmlToStruct(xmlParse(local.result.fileContent));

    }

	public function joinTalk(talk,user,isAdmin){

		param name="arguments.isAdmin" default="false";

		local.talkObj = arguments.talk;
		local.userObj = arguments.user;
		local.isAdmin = arguments.isAdmin;

    	local.url = local.talkObj.getServer().getURL();
    	local.salt = local.talkObj.getServer().getSalt();
    	local.call = "join";

		local.queryStringClean = "fullName=#encodeForURL(local.userObj.getUsername())#";
		local.queryStringClean = local.queryStringClean & "&meetingID=#encodeForURL(local.talkObj.getTalkID())#";

		if(local.talkObj.getPresenter().getUserID() EQ local.userObj.getUserID() OR local.isAdmin){
    		local.queryStringClean = local.queryStringClean & "&password=#local.talkObj.getPresenterPassword()#";
    	}
    	else{
    		local.queryStringClean = local.queryStringClean & "&password=#local.talkObj.getAttendeePassword()#";
    	}

    	local.queryStringClean = local.queryStringClean & "&userID=#encodeForURL(local.userObj.getUserID())#";

		local.queryStringPrepend = local.call & local.queryStringClean;
		local.queryStringAppend  = local.queryStringPrepend & local.salt;

    	local.checksum = lCase(hash(local.queryStringAppend, "SHA"));
    	local.queryStringFinal = local.queryStringClean & "&checksum=" & local.checksum;
		local.finalURL = local.url & "bigbluebutton/api/" & local.call & "?" & local.queryStringFinal;

		transaction{
			if(!local.talkObj.hasAttendee(local.userObj)){
				local.talkObj.addAttendee(local.userObj);
				entitySave(local.talkObj);
			}


			transaction action="commit";
		}

	    return local.finalURL;
    }

    public function isTalkRunning(talk){

    	local.talkObj = arguments.talk;

    	local.url = local.talkObj.getServer().getURL();
    	local.salt = local.talkObj.getServer().getSalt();
    	local.call = "isMeetingRunning";

		local.queryStringClean = "meetingID=#encodeForURL(local.talkObj.getTalkID())#";

		local.queryStringPrepend = local.call & local.queryStringClean;
		local.queryStringAppend  = local.queryStringPrepend & local.salt;

    	local.checksum = lCase(hash(local.queryStringAppend, "SHA"));
    	local.queryStringFinal = local.queryStringClean & "&checksum=" & local.checksum;
		local.finalURL = local.url & "bigbluebutton/api/" & local.call & "?" & local.queryStringFinal;

    	cfhttp(method="POST", url="#local.finalURL#", result="local.result");
    	local.isRunning = xmlToStruct(xmlParse(local.result.fileContent));

    	if(structKeyExists(local.isRunning.response, "returnCode") AND local.isRunning.response.returnCode EQ "SUCCESS"){
    		return local.isRunning.response.running;
    	}

		return false;
    }

    public function getTalkInfo(talk){

    	local.talkObj = arguments.talk;

    	local.url = local.talkObj.getServer().getURL();
    	local.salt = local.talkObj.getServer().getSalt();
    	local.call = "getMeetingInfo";

		local.queryStringClean = "meetingID=#encodeForURL(local.talkObj.getTalkID())#";
		local.queryStringClean = local.queryStringClean & "password=#encodeForURL(local.talkObj.getPresenterPassword())#";

		local.queryStringPrepend = local.call & local.queryStringClean;
		local.queryStringAppend  = local.queryStringPrepend & local.salt;

    	local.checksum = lCase(hash(local.queryStringAppend, "SHA"));
    	local.queryStringFinal = local.queryStringClean & "&checksum=" & local.checksum;
		local.finalURL = local.url & "bigbluebutton/api/" & local.call & "?" & local.queryStringFinal;

    	cfhttp(method="POST", url="#local.finalURL#", result="local.result");
	    return xmlToStruct(xmlParse(local.result.fileContent));

    }

    public function getRecordings(talk){

    	local.talkObj = arguments.talk;

    	local.url = local.talkObj.getServer().getURL();
    	local.salt = local.talkObj.getServer().getSalt();
    	local.call = "getRecordings";

		local.queryStringClean = "meetingID=#local.talkObj.getTalkID()#";

		local.queryStringPrepend = local.call & local.queryStringClean;
		local.queryStringAppend  = local.queryStringPrepend & local.salt;

    	local.checksum = lCase(hash(local.queryStringAppend, "SHA"));
    	local.queryStringFinal = local.queryStringClean & "&checksum=" & local.checksum;
		local.finalURL = local.url & "bigbluebutton/api/" & local.call & "?" & local.queryStringFinal;

    	cfhttp(method="POST", url="#local.finalURL#", result="local.result");

    	local.parsedXML = xmlParse(local.result.fileContent);

		local.cleanXMLMessage = XmlSearch(local.parsedXML, "/response/messageKey");

		local.return.URL = "";
		if(arrayLen(local.cleanXMLMessage)){
    		local.return.message = local.cleanXMLMessage[1].xmlText;
		}
		else{
			local.return.message = "recordsExist";
		}

    	if(local.return.message NEQ "noRecordings"){
    		local.cleanXML = XmlSearch(local.parsedXML, "/response/recordings/recording/playback/format/url");
    		local.return.URL = local.cleanXML[1].xmlText;

    	}

	    return local.return;

    }

}