component extends="baseServices" {

    variables.lock_name = "userlock";

    public function getByPK(numeric id) {
        return entityLoadByPk("user", arguments.id);
    }

    public boolean function doesUserExist(string username) {
        local.userCheck = entityLoad("user", {username=arguments.username});
        if(arrayLen(local.userCheck) == 1) return true;
        return false;
    }

    public any function getUserByUsername(string username) {
    	return entityLoad("user",{username=arguments.username});
    }

    public any function getUserPostCount(userID) {

    	local.queryObj = new query();
		local.queryObj.setDatasource("unitycode");
		local.queryObj.setName("local.qForumPost");
		local.queryObj.addParam(name="userid",value=arguments.userid,cfsqltype="cf_sql_integer");
		local.result = local.queryObj.execute(sql="SELECT forumPostID FROM forumPost WHERE userid = :userid AND isActive = true");
		local.qForumPost = local.result.getResult();
		local.queryObj.clearParams();

		local.queryObj2 = new query();
		local.queryObj2.setDatasource("unitycode");
		local.queryObj2.setName("local.qForumTopic");
		local.queryObj2.addParam(name="userid",value=arguments.userid,cfsqltype="cf_sql_integer");
		local.result = local.queryObj2.execute(sql="SELECT forumTopicID FROM forumTopic WHERE userid = :userid AND isActive = true");
		local.qForumTopic = local.result.getResult();
		local.queryObj2.clearParams();

		// use recordCount instead of sum in order to output 0 if there are no posts
    	return local.qForumPost.recordCount + local.qForumTopic.recordCount;
    }

    public any function userHasPermissions(userID,permissionName) {

    	local.queryObj = new query();
		local.queryObj.setDatasource("unitycode");
		local.queryObj.setName("local.qUser");
		local.queryObj.addParam(name="userID",value=arguments.userid,cfsqltype="cf_sql_integer");
		local.queryObj.addParam(name="permissionName",value=arguments.permissionName,cfsqltype="cf_sql_varchar");
		local.result = local.queryObj.execute(sql="SELECT u.userID FROM user u JOIN userPermissions up ON up.user_userID = u.userID JOIN permission p ON p.permissionID = up.permission_permissionID WHERE u.userid = :userid AND u.isActive = true AND p.name = :permissionName");
		local.qUser = local.result.getResult();
		local.queryObj.clearParams();

    	return local.qUser.recordCount;
    }

    public function authenicate(string username, string password) {

		local.password = hash(application.salt & trim(arguments.password), "SHA");
     	local.userCheck = entityLoad("user", {username=arguments.username, password=local.password, isActive=true});
        session.user.isLoggedIn = false;
        if(arrayLen(local.userCheck) == 1){
        	local.user = local.userCheck[1];
        	session.user.userid = local.user.getUserID();
        	session.user.username = local.user.getUsername();
        	session.user.timezone = local.user.getTimeZone();
        	session.user.isLoggedIn = true;
        }
        return session.user.isLoggedIn;
    }

    public function activationEmail(string username, string email) {

    	if(!structKeyExists(arguments, "email") AND len(arguments.email) EQ 0){
	    	local.user = this.getUserByUsername(arguments.username);
	    	arguments.email = local.user.getEmail();
    	}

    	local.userEncryptData = arguments.username & "|" & now();
		local.queryString = URLEncodedFormat(encrypt(local.userEncryptData, application.salt));
        local.userRegLink = "http://unityco.de/index.cfm?action=user.activate&key=" & local.queryString;

        savecontent variable="mailBody"{
            WriteOutput('Thank you for signing up for unityco.de, please click the link below to confirm your registration.<br><br><a href="' & local.userRegLink & '">' & local.userRegLink & '</a>');
        }

		local.mailerService = new mail();
		local.mailerService.setTo(arguments.email);
        local.mailerService.setFrom("noreply@friez.io");
        local.mailerService.setSubject("UnityCode User Activation");
        local.mailerService.addPart(type="html", charset="utf-8", wraptext="72", body=mailBody);
        local.mailerService.send();
    }

    public any function register(string username,string password, string email, string timezone) {
        lock name="#variables.lock_name#" type="exclusive" timeout=30 {

            local.password = hash(application.salt & trim(arguments.password), "SHA");

            transaction{
				// create blank profile
	            local.profile = entityNew("profile");
	            local.profile.setImage("/layouts/assets/img/avatar/blank.png");
	            local.profile.setAboutMe("I am a new member!");

	            // load up the permissions and packages
	            local.permission = entityLoad("permission",{name="User"});
	            local.packages = entityLoad("package",{name="Registered User"});
	            local.package = local.packages[1];

	            // create the user
	            local.user = entityNew("user");
	            local.user.setUsername(arguments.username);
	            local.user.setPassword(local.password);
	            local.user.setEmail(arguments.email);
	        	local.user.setTimeZone(arguments.timezone);
	            local.user.setIsActive(false);

	            // set permissions, package, and profile
	            local.user.setPackage(local.package);
	            local.user.setProfile(local.profile);

				// chose to loop over permissions since there might be more by default later
				for (i=1;i LTE ArrayLen(local.permission);i=i+1) {
					local.user.addPermission(local.permission[i]);
				}

				// save everything
				entitySave(local.profile);
				entitySave(local.user);

				transaction action="commit";
			}

			this.activationEmail(arguments.username, arguments.email);
            return local.user;
        }
    }

	public any function update(user,password,email,timeZone) {

		transaction{
	       	arguments.user.setEmail(arguments.email);
	       	arguments.user.setTimeZone(arguments.timeZone);

	       	if(len(arguments.password)){
	       		local.password = hash(application.salt & trim(arguments.password), "SHA");
	       		arguments.user.setPassword(local.password);
	       	}

	       	entitySave(arguments.user);

			transaction action="commit";
		}

       	return arguments.user;

    }

    public any function activate(string username) {
    	local.user = this.getUserByUsername(arguments.username);

        if(arrayLen(local.user) == 1){
        	transaction{
	        	local.user[1].setIsActive(true);
	        	entitySave(local.user[1]);

	        	transaction action="commit";
			}
        }

    }

}