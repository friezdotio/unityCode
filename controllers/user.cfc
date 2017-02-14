component accessors="true" extends="base"{

    function init(fw) {
        variables.fw = fw;
    }

    /*
    	Display Pages
    */

    function signup(rc){
    	param name="rc.timezone" default="";
    	param name="rc.username" default="";
    	param name="rc.email" default="";

    	rc.title = "Sign Up";

    	if(session.user.isLoggedIn){
			variables.fw.redirect("user.dashboard");
		}

		rc.timeZones = variables.userServices.getTimeZones();
    }

    function dashboard(rc) {

		if(!session.user.isLoggedIn){
			variables.fw.redirect("user.signup");
		}

		rc.user = variables.userServices.getByPK(session.user.userid);
		rc.presentingTalks = variables.talkServices.getByPresenter(rc.user,10);
		rc.registeredTalks = variables.talkServices.getByRegistrant(rc.user,10);

		rc.pageTitle = "User Dashboard | #rc.user.getUsername()#";

		rc.isForumAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");
		rc.isUserAdmin = variables.userServices.userHasPermissions(session.user.userid,"User Admin");
		rc.isSystemAdmin = variables.userServices.userHasPermissions(session.user.userid,"System Admin");

    }

    function edit(rc){

		if(!session.user.isLoggedIn){
			variables.fw.redirect("main.404");
		}

    	rc.user = variables.userServices.getByPK(session.user.userid);
    	rc.pageTitle = "Edit User | #rc.user.getUsername()#";

    	rc.timeZones = variables.userServices.getTimeZones();

    	//writeDump(var=rc.timeZones);abort;

    }

    /*
    	Action Pages
    */

    function signupSubmit(rc) {

    	// Validation

        rc.pageErrors = [];

		if(len(rc.username)){
        	rc.doesUserExist = variables.userServices.doesUserExist(rc.username);
        	if(rc.doesUserExist) {
	            arrayAppend(rc.pageErrors, "This username is already taken.");
	        }
		}

        if(!len(trim(rc.username))) {
            arrayAppend(rc.pageErrors, "You must include a username.");
        }

        if(!len(trim(rc.password))) {
            arrayAppend(rc.pageErrors, "You must include a password.");
        }

        if(!len(trim(rc.timezone))) {
            arrayAppend(rc.pageErrors, "You must select your timezone.");
        }

        if(compare(rc.password2,rc.password) NEQ 0) {
            arrayAppend(rc.pageErrors, "Your confirmation password did not match.");
        }

        if(!isValid("email", rc.email)) {
            arrayAppend(rc.pageErrors, "You must include a valid email address.");
        }

        if(arrayLen(rc.pageErrors)) {
            variables.fw.redirect("user.signup", "username,email,timezone,pageErrors");
        }

        rc.pageSuccess = "Thank you for signing up. Please check your email to activate your account.";

        // Controller Action

        variables.userServices.register(rc.username, rc.password, rc.email, rc.timezone);

        variables.fw.redirect("main.default", "pageSuccess");

    }

    function save(rc) {

    	// Validation

        rc.pageErrors = [];

        if(rc.password2 NEQ rc.password) {
            arrayAppend(rc.pageErrors, "Your confirmation password did not match.");
        }

        if(!isValid("email", rc.email)) {
            arrayAppend(rc.pageErrors, "You must include a valid email address.");
        }

        if(!len(rc.timezone)) {
            arrayAppend(rc.pageErrors, "You must choose a timezone.");
        }

        if(arrayLen(rc.pageErrors)) {
            variables.fw.redirect("user.edit", "username,email,pageErrors");
        }

        rc.pageSuccess = "Your account has been updated.";

        rc.user = variables.userServices.getByPK(session.user.userid);

        // Controller Action

        variables.userServices.update(rc.user, rc.password, rc.email, rc.timeZone);

        session.user.timeZone = rc.timeZone;

        variables.fw.redirect("user.edit", "all");

    }

    function login(rc) {

		rc.isLoggedIn = variables.userServices.authenicate(rc.username,rc.password);

		rc.pageErrors = [];

    	if(!rc.isLoggedIn){
    		 arrayAppend(rc.pageErrors, "Your username/password combination was incorrect.");
    	}

    	if(arrayLen(rc.pageErrors)) {
           variables.fw.redirect("main", "all");
        }

		rc.pageSuccess = "You are now logged in.";
		variables.fw.redirect("user.dashboard", "all");

    }

    function logout(rc) {
        structDelete(session, 'user', true);
        session.user = {};
        session.user.userid = 1;
        session.user.isloggedin = false;
        session.user.timezone = "UTC";
        variables.fw.redirect("main.default");
    }

    function activate(rc) {
		rc.key = decrypt(rc.key, application.salt);
		local.username = listFirst(rc.key,chr(124));
		local.date = listLast(rc.key, chr(124));
		if(dateDiff('d',local.date,now()) < 1){
        	rc.pageSuccess = "Your account is activate, please login.";
            variables.userServices.activate(local.username);
            variables.fw.redirect("main", "pageSuccess");
        }
        else {
        	rc.pageErrors = [];
        	arrayAppend(rc.pageErrors, "Your registration link has expired. A new one will be sent now.");
        	variables.userServices.activationEmail(local.username);
        	variables.fw.redirect("main", "pageErrors");
        }
    }

}