component extends="framework.one" {

    this.name = "unitycode";
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0,2,0,0);
    this.dataSource = this.name;
    this.ormEnabled = true;
    this.triggerdatamember = true;
    this.ormsettings = {
        cfclocation="./model/beans",
        dbcreate="update",
        //dbcreate="dropcreate",
        dialect="MySQL",
        //eventhandling="true",
        //eventhandler="model.beans.eventHandler",
        flushAtRequestEnd = false,
		autoManageSession=false,
        logsql="true"
    };
	if(cgi.server_name EQ "unityco.de"){
	    variables.framework = {
	        reloadApplicationOnEveryRequest = "true",
	        trace = "false",
	        generateSES = true,
	    	SESOmitIndex = true
	    };
	}
	else{
		 variables.framework = {
	        reloadApplicationOnEveryRequest = "true",
	        trace = "false",
	        generateSES = false,
	    	SESOmitIndex = false
	    };
	}

    public function setupSession() {
    	local.user = entityLoad("user",{username="Guest"});
    	session.user.userid = local.user[1].getUserID();
		session.user.isLoggedIn = false;
		session.user.timezone = local.user[1].getTimeZone();
    }

    public function setupApplication() {
        var bf = new framework.ioc("./model/services");
        setBeanFactory(bf);
        application.salt = "RollThatBeautifulBeanFootage";
        application.timezone = "Etc/GMT+5";
        application.baseServices = CreateObject("component","model.services.baseServices");
    }

    public function setupRequest() {
        if(structKeyExists(url, "init")) {
            setupApplication();
            ormReload();
            location(url="index.cfm",addToken=false);
        }
    }

    function setupView( struct rc ) {

		// Header variables
		if(structKeyExists(session.user, "userid")){
			rc.header.user = CreateObject("component","model.services.userServices").getByPK(session.user.userid);
		}

		//Footer variables
		rc.footer.upcomingTalks = CreateObject("component","model.services.talkServices").getUpcoming(3);
		rc.footer.popularTalks = CreateObject("component","model.services.talkServices").getPopular(3);
		rc.footer.latestTopics = CreateObject("component","model.services.forumServices").getLatestForumTopics(5);

	}

}
