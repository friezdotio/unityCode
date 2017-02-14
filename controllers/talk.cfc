component accessors="true" extends="base"{

    function init(fw) {
        variables.fw = fw;
    }

    function after(rc) {

    	// Side Bar
    	rc.sideBarTags = variables.tagServices.getPopular(30);
    	rc.sideBarUpcomingTalks = variables.talkServices.getUpcoming(5);
    	rc.sideBarPopularTalks = variables.talkServices.getPopular(5);

    }

    /*
    	Display Pages
    */

    function default(rc) {

		param name="rc.start" default="1";
		param name="rc.pageSize" default="10";

		rc.pageTitle = "Talks";
		rc.pageDescription = "It's like a 24/7 developer conference!";

		rc.baseServices = variables.baseServices;

    	rc.upcomingTalks = variables.talkServices.getUpcoming(rc.start,rc.pageSize);
    	rc.popularTalks = variables.talkServices.getPopular(rc.start,rc.pageSize);
    	rc.pastTalks = variables.talkServices.getPast(rc.start,rc.pageSize);

    	// Pagination
    	rc.upcomingTalksCount = arrayLen(rc.upcomingTalks);
    	rc.upcomingTalksTotalPages = variables.forumServices.getTotalPages(rc.upcomingTalksCount);

    	rc.popularTalksCount = arrayLen(rc.popularTalks);
		rc.popularTalksTotalPages = variables.forumServices.getTotalPages(rc.popularTalksCount);

		rc.pastTalksCount = arrayLen(rc.pastTalks);
		rc.pastTalksTotalPages = variables.forumServices.getTotalPages(rc.pastTalksCount);

		rc.currentPage = variables.forumServices.getCurrentPage(rc.start);

    }

    function tag(rc) {

		param name="rc.start" default="1";
		param name="rc.pageSize" default="10";

		rc.pageTitle = "#rc.tag# Talks";
		rc.pageDescription = "It's like a 24/7 developer conference!";

    	rc.talks = variables.talkServices.getByTag(rc.tag,rc.start,rc.pageSize);

    	// Pagination
    	rc.talksCount = arrayLen(rc.talks);
    	rc.talksTotalPages = variables.forumServices.getTotalPages(rc.talksCount);

		rc.currentPage = variables.forumServices.getCurrentPage(rc.start);

    }

    function user(rc) {

		param name="rc.start" default="1";
		param name="rc.pageSize" default="10";

		if(structKeyExists(rc,"registrantID") AND len(rc.registrantID)){
			rc.user = variables.userServices.getByPk(rc.registrantID);
    		rc.talks = variables.talkServices.getByRegistrant(rc.user,rc.start,rc.pageSize);
    		rc.title = "Registered";
		}
		else if(structKeyExists(rc,"presenterID") AND len(rc.presenterID)){
			rc.user = variables.userServices.getByPk(rc.presenterID);
			rc.talks = variables.talkServices.getByPresenter(rc.user,rc.start,rc.pageSize);
			rc.title = "Presenting";
		}
		else{
			variables.fw.redirect(action='main.404',preserve='all');
		}

		rc.pageTitle = "#rc.user.getUsername()#'s #rc.title# Talks";
		rc.pageDescription = "It's like a 24/7 developer conference!";

    	// Pagination
    	rc.talksCount = arrayLen(rc.talks);
    	rc.talksTotalPages = variables.forumServices.getTotalPages(rc.talksCount);

		rc.currentPage = variables.forumServices.getCurrentPage(rc.start);

    }

    function view(rc) {

		param name="rc.start" default="1";
		param name="rc.pageSize" default="10";

		// User specific
		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.isAdmin = variables.userServices.userHasPermissions(session.user.userid,"Talk Admin");

		// Page specific
		rc.talk = variables.talkServices.getByPK(rc.talkid);
		rc.isRunning = variables.talkServices.isTalkRunning(rc.talk);
		rc.pageTitle = rc.talk.getTitle();
		rc.recordings = variables.talkServices.getRecordings(rc.talk);

		// Action button conditional logic
		rc.actionButton = variables.talkServices.getActionButton(rc.talk,rc.user,rc.isAdmin);

    }

    function add(rc) {

    	if(!session.user.isLoggedIn){
			variables.fw.redirect(action='main.404',preserve='all');
		}

    	// User specific
		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.isAdmin = variables.userServices.userHasPermissions(session.user.userid,"Talk Admin");
		rc.avaliableTags = variables.tagServices.getGrouped();

		rc.tagsJSON = [];
		for(local.tag in rc.avaliableTags){
			arrayAppend(rc.tagsJSON,local.tag.getName());
		}
		rc.tagsJSON = serializeJSON(rc.tagsJSON);

		// Page specific

		if(structKeyExists(rc, "talkid") AND len(rc.talkid)){
			rc.talk = variables.talkServices.getByPK(rc.talkid);
			rc.pageTitle = "Edit Talk | #rc.talk.getTitle()#";
			rc.title = rc.talk.getTitle();
			rc.shortDescription = rc.talk.getShortDescription();
			rc.description = rc.talk.getDescription();
			rc.image = rc.talk.getImage();
			rc.start = variables.baseServices.timeZoneConvert(rc.talk.getStart(),application.timezone,session.user.timezone);

			rc.tags = "";
			if(arrayLen(rc.talk.getTags())){
				for(local.tag in rc.talk.getTags()){
					rc.tags = ListAppend(rc.tags,local.tag.getName(),",");
				}
			}

			if(!rc.isAdmin){
				if(rc.talk.getPresenter().getUserID() NEQ session.user.userid){
					variables.fw.redirect(action='main.404',preserve='all');
				}
			}

		}
		else{
			rc.pageTitle = "New Talk";
			if(!structKeyExists(rc, "title") OR !len(rc.title)){
				rc.title = "";
			}
			if(!structKeyExists(rc, "shortDescription") OR !len(rc.shortDescription)){
				rc.shortDescription = "";
			}
			if(!structKeyExists(rc, 'description') OR !len(rc.description)){
				rc.description = "Detailed Description";
			}
			if(!structKeyExists(rc, "image") OR !len(rc.image)){
				rc.image = "";
			}
			if(!structKeyExists(rc, "start") OR !len(rc.start)){
				rc.start = variables.baseServices.timeZoneConvert(now(),application.timezone,session.user.timezone);
			}
			if(!structKeyExists(rc, "tags") OR !len(rc.tags)){
				rc.tags = "";
			}
			if(!structKeyExists(rc, "talkid") OR !len(rc.talkid)){
				rc.talkid = "";
			}
		}

    }

    /*
    	Action Pages
    */

	function join(rc) {

		rc.talk = variables.talkServices.getByPK(rc.talkid);
	    rc.user = variables.userServices.getByPK(session.user.userID);
	    rc.isAdmin = variables.userServices.userHasPermissions(session.user.userid,"Talk Admin");
	    rc.isRunning = variables.talkServices.isTalkRunning(rc.talk);

	    if(!session.user.isLoggedIn OR rc.user.getUsername() EQ "Guest"){
			variables.fw.redirect(action='user.signup');
		}

	    if(rc.talk.getPresenter().getUserID() EQ session.user.userID AND !rc.isRunning){
	    	variables.talkServices.createTalk(rc.talk);
	    }

	   	local.joinTalk = variables.talkServices.joinTalk(rc.talk,rc.user,rc.isAdmin);

	   	location(local.joinTalk, false);

    }

    function rsvp(rc) {

		rc.talk = variables.talkServices.getByPK(rc.talkid);
	    rc.user = variables.userServices.getByPK(session.user.userID);
	    rc.isFull = rc.talk.getIsFull();

	    if(!session.user.isLoggedIn OR rc.user.getUsername() EQ "Guest"){
			variables.fw.redirect(action='user.signup');
		}

		rc.pageErrors = [];

    	if(rc.talk.hasRegistrant(rc.user)){
    		 arrayAppend(rc.pageErrors, "You have already RSVPed to this talk.");
    	}

    	if(rc.isFull){
    		 arrayAppend(rc.pageErrors, "This talk is currently full.");
    	}

    	if(arrayLen(rc.pageErrors)) {
            variables.fw.redirect(action='talk.view', preserve='all');
        }

        rc.pageSuccess = "You are now RSVPed to this talk.";

		variables.talkServices.addRSVP(rc.user,rc.talk);

		variables.fw.redirect(action='talk.view', preserve='all');
    }

    function save(rc) {


    	// User specific
		rc.user = variables.userServices.getByPk(session.user.userid);

    	// Validation

    	rc.pageErrors = [];

    	if(!len(rc.title)){
    		 arrayAppend(rc.pageErrors, "Please include a title.");
    	}

    	if(!len(rc.shortDescription)){
    		 arrayAppend(rc.pageErrors, "Please include a short description.");
    	}

    	if(!len(rc.description) OR len(rc.description) LT 50){
    		 arrayAppend(rc.pageErrors, "Please include a more detailed description.");
    	}

    	if(!len(rc.start) OR rc.start LT variables.baseServices.timeZoneConvert(now(),application.timezone,session.user.timezone)){
    		 arrayAppend(rc.pageErrors, "Please make sure the start date is set in the future.");
    	}

    	if(!len(rc.tags) OR listLen(rc.tags) LT 3){
    		 arrayAppend(rc.pageErrors, "You need at least three tags.");
    	}

    	if(arrayLen(rc.pageErrors)) {
            variables.fw.redirect(action='talk.add', preserve='all');
        }

        rc.pageSuccess = "This talk has been saved.";

        // Controller Action

        rc.start = variables.baseServices.timeZoneConvert(rc.start,session.user.timezone,application.timezone);

		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.talk = "";
		if(structKeyExists(rc, "talkid") AND len(rc.talkid)){
			rc.talk = variables.talkServices.getByPK(rc.talkid);
		}

		rc.server = variables.serverServices.getByPk(1);

		if(len(rc.image)){
			// image upload
			local.imageURL = "/layouts/assets/img/talks/";
	        local.imageUpload = FileUpload(ExpandPath(imageURL), "image", "image/jpg,image/png","Overwrite");
	        local.imagePathOld = imageUpload.serverDirectory & "\" & imageUpload.serverfile;
	        local.imagePathNew = session.user.userid & randRange(1, 999999999) & "." & imageUpload.serverfileext;
	        local.imagePath = imageUpload.serverDirectory & "\" & local.imagePathNew;
	        filemove(local.imagePathOld, local.imagePath);

	        rc.image = local.imageURL & local.imagePathNew;
    	}

		local.newTalk = variables.talkServices.save(rc.talk,rc.user,rc.server,rc.title,rc.shortDescription,rc.description,rc.tags,rc.image,rc.start);

		// We need to convert the time back to the users timezone.
		rc.start = variables.baseServices.timeZoneConvert(rc.start,application.timezone,session.user.timezone);
		variables.fw.redirect(action='talk.add',queryString="talkid=#local.newTalk#",preserve='all');

    }

}