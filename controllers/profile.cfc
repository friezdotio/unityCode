component accessors="true" extends="base"{

    function init(fw) {
        variables.fw = fw;
    }

    /*
    	Display Pages
    */

    function default(rc) {

        param name="rc.userID" default=session.user.userid;

		rc.user = variables.userServices.getByPK(rc.userid);

		rc.pageTitle = "User Profile | #rc.user.getUsername()#";

    }


    function edit(rc) {

		if(!session.user.isLoggedIn){
			variables.fw.redirect(action='main.404',preserve='all');
		}

		rc.user = variables.userServices.getByPK(session.user.userid);
		rc.profile = rc.user.getProfile();

		rc.pageTitle = "Edit Profile | #rc.user.getUsername()#";

    }

    /*
    	Action Pages
    */

    function update(rc) {

    	rc.user = variables.userServices.getByPK(session.user.userid);
    	rc.profile = rc.user.getProfile();

		rc.pageErrors = [];

        if(len(rc.website) AND !isValid("url", rc.website)) {
            arrayAppend(rc.pageErrors, "Your website URL is invalid, check the url. (Example: http://sitename.com/)");
        }

        if(len(rc.facebook) AND !isValid("url", rc.facebook)) {
            arrayAppend(rc.pageErrors, "Your facebook URL is invalid. (Example: https://facebook.com/fbuser)");
        }

        if(len(rc.twitter) AND !isValid("url", rc.twitter)) {
            arrayAppend(rc.pageErrors, "Your Twitter URL is invalid. (https://twitter.com/twuser)");
        }

        if(len(rc.google) AND !isValid("url", rc.google)) {
            arrayAppend(rc.pageErrors, "Your Google Plus URL is invalid. (https://plus.google.com/gpuser)");
        }

        if(len(rc.linkedin) AND !isValid("url", rc.linkedin)) {
            arrayAppend(rc.pageErrors, "Your Google Plus URL is invalid. (https://linkedin.com/liuser)");
        }

        if(arrayLen(rc.pageErrors)) {
            variables.fw.redirect("profile.edit", "pageErrors");
        }

        rc.image = "";

		if(len(rc.imageUpload)){

			// image upload
	        local.imageUpload = FileUpload(ExpandPath("/layouts/assets/img/avatar/"), "imageUpload", "image/jpg,image/png","Overwrite");
	        local.imagePathOld = local.imageUpload.serverDirectory & "\" & local.imageUpload.serverfile;
	        local.imagePath = local.imageUpload.serverDirectory & "\" & session.user.userid & "." & local.imageUpload.serverfileext;
	        filemove(local.imagePathOld, local.imagePath);

		    local.scaledWidth = 100;
		    local.scaledHeight = 100;
		    local.scaledImage = ImageNew(local.imagePath);

		    imageScaleToFit(local.scaledImage, local.scaledWidth, local.scaledHeight);
		    imageWrite(local.scaledImage, local.imagePath);

	        rc.image = "/layouts/assets/img/avatar/" & session.user.userid & "." & local.imageUpload.serverfileext;


    	}

        if(arrayLen(rc.pageErrors)) {
            variables.fw.redirect("profile.edit", "pageErrors");
        }

		rc.pageSuccess = "Your profile has been updated.";

		local.profile = variables.profileServices.update(rc.profile, rc.image, rc.fullname, rc.location, rc.website, rc.aboutme, rc.facebook, rc.twitter, rc.linkedin, rc.google);

		variables.fw.redirect("profile.edit", "all");


	}
}