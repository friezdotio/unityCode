component accessors="true" extends="base"{

    function init(fw) {
        variables.fw = fw;
    }

    /*
    	Display Pages
    */

    function default(rc) {

    	variables.fw.redirect(action='user.dashboard',preserve='all');

    }

    function forum(rc) {

    	rc.pageTitle = "Forum Admin";

		// User specific
		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.isForumAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

		if(!rc.isForumAdmin){
			variables.fw.redirect(action='main.404',preserve='all');
		}

		// Page specific
		rc.categories = variables.forumServices.getAllForumCategories();

    }

    function forumCategory(rc) {

    	// User specific
		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.isForumAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

		// Page specific
		rc.permissions = variables.permissionServices.get();

		if(!rc.isForumAdmin){
			variables.fw.redirect(action='main.404',preserve='all');
		}

		if(structKeyExists(rc, "categoryid")){
			rc.category = variables.forumServices.getForumCategoryByPK(rc.categoryid);
			rc.pageTitle = "Edit Category | #rc.category.getLabel()#";
			rc.label = rc.category.getLabel();
			rc.description = rc.category.getDescription();
			rc.order = rc.category.getOrder();
			rc.isActive = rc.category.getIsActive();

			// Converts PermissionIDs to an array
			local.currentPermissions = rc.category.getPermissions();
			local.count = 0;
			rc.permissionIDs = [];
			for(local.permission in local.currentPermissions){
			    local.count = local.count + 1;
			    rc.permissionIDs[local.count] = local.permission.getPermissionID();
			}

		}
		else{
			rc.pageTitle = "New Category";
			rc.label = "";
			rc.description = "";
			rc.order = "";
			rc.isActive = "";
			rc.permissionIDs="";
		}

    }

    function forumSubCategory(rc) {

    	// User specific
		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.isForumAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

		if(!rc.isForumAdmin){
			variables.fw.redirect(action='main.404',preserve='all');
		}

		// Page specific

		rc.categories = variables.forumServices.getForumCategories();

		if(structKeyExists(rc, "subcategoryid")){
			rc.subcategory = variables.forumServices.getForumSubCategoryByPK(rc.subcategoryid);
			rc.pageTitle = "Edit Subcategory | #rc.subcategory.getLabel()#";
			rc.label = rc.subcategory.getLabel();
			rc.description = rc.subcategory.getDescription();
			rc.order = rc.subcategory.getOrder();
			rc.isActive = rc.subcategory.getIsActive();
			rc.categoryid = rc.subcategory.getForumCategory().getForumCategoryID();
		}
		else{
			rc.pageTitle = "New Subcategory";
			rc.label = "";
			rc.description = "";
			rc.order = "";
			rc.isActive = "";
			if(!structKeyExists(rc, "categoryid")){
				rc.categoryid = "";
			}
		}

    }

    /*
		Action Pages
    */

	function saveCategory(rc) {

		// User specific
		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.isForumAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

		if(!rc.isForumAdmin){
			variables.fw.redirect(action='main.404',preserve='all');
		}

		if(!structKeyExists(rc, "isActive")){
    		rc.isActive = false;
    	}

		// Validation

    	rc.pageErrors = [];

    	if(!len(rc.label)){
    		 arrayAppend(rc.pageErrors, "Please include a label.");
    	}

    	if(!len(rc.description)){
    		 arrayAppend(rc.pageErrors, "Please include a description.");
    	}

    	if(!len(rc.order)){
    		 arrayAppend(rc.pageErrors, "Please include the order.");
    	}

    	if(!structKeyExists(rc, "permissions")){
    		 arrayAppend(rc.pageErrors, "Please choose at least one permission");
    	}

    	if(arrayLen(rc.pageErrors)) {
            variables.fw.redirect(action='admin.forumCategory', preserve='all');
        }

        rc.pageSuccess = "This category has been saved.";

        // Controller Action

		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.category = "";
		if(structKeyExists(rc, "categoryID")){
			rc.category = variables.forumServices.getForumCategoryByPK(rc.categoryID);
		}
		local.newCategory = variables.forumServices.saveCategory(rc.category,rc.label,rc.description,rc.order,rc.isActive,rc.permissions);
		variables.fw.redirect(action='admin.forumCategory',queryString="categoryid=#local.newCategory#",preserve='all');

    }

    function saveSubCategory(rc) {

    	// User specific
		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.isForumAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

		if(!rc.isForumAdmin){
			variables.fw.redirect(action='main.404',preserve='all');
		}

		if(!structKeyExists(rc, "isActive")){
    		rc.isActive = false;
    	}

    	// Validation

    	rc.pageErrors = [];

    	if(!len(rc.label)){
    		 arrayAppend(rc.pageErrors, "Please include a label.");
    	}

    	if(!len(rc.description)){
    		 arrayAppend(rc.pageErrors, "Please include a description.");
    	}

    	if(!len(rc.order)){
    		 arrayAppend(rc.pageErrors, "Please include the order.");
    	}

    	if(!len(rc.newcategoryid)){
    		 arrayAppend(rc.pageErrors, "Please choose at category.");
    	}

    	if(arrayLen(rc.pageErrors)) {
            variables.fw.redirect(action='admin.forumSubcategory', preserve='all');
        }

        rc.pageSuccess = "This subcategory has been saved.";

        // Controller Action

		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.subcategory = "";
		if(structKeyExists(rc, "subcategoryID")){
			rc.subcategory = variables.forumServices.getForumSubCategoryByPK(rc.subcategoryID);
		}
		rc.category = variables.forumServices.getForumCategoryByPK(rc.newcategoryid);
		local.newSubCategory = variables.forumServices.saveSubCategory(rc.subcategory,rc.category,rc.label,rc.description,rc.order,rc.isActive);
		variables.fw.redirect(action='admin.forumSubcategory',queryString="subcategoryid=#local.newSubCategory#",preserve='all');

    }

    function reloadApplication(rc) {

    	rc.isSystemAdmin = variables.userServices.userHasPermissions(session.user.userid,"System Admin");

    	if(rc.isSystemAdmin){
    		setupApplication();
    		ORMReload();
    	}

    	rc.pageSuccess = "The application has been reloaded.";

    	variables.fw.redirect("user.dashboard","rc");

    }

}