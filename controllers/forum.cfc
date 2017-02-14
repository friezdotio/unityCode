component accessors="true" extends="base"{

    function init(fw) {
        variables.fw = fw;
    }

    /*
    	Display Pages
    */

    function default(rc) {

    	rc.pageTitle = "Forums";

    	// Header variables
	    rc.header.user = variables.userServices.getByPK(session.user.userid);

		// User specific
		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.isAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

		// Forum specific
		rc.categories = variables.forumServices.getForumCategoriesByUserID(session.user.userid);

    }

    function subcategory(rc) {

		param name="rc.start" default="1";
		param name="rc.pageSize" default="10";

		// User specific
		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.isAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

		// Forum specific
		rc.subcategory = variables.forumServices.getForumSubCategoryByPK(rc.subcategoryid);
		rc.topics = variables.forumServices.getForumTopicsPagination(rc.subcategory,rc.start,rc.pageSize);
		rc.topicsCount = variables.forumServices.getForumTopicsTotal(rc.subcategory);
		rc.stickyTopics = variables.forumServices.getStickyForumTopics(rc.subcategory);

		rc.pageTitle = "Forums | #rc.subcategory.getLabel()#";

		// Determines the current page by grabbing the tenth of the start URL.
		rc.currentPage = variables.forumServices.getCurrentPage(rc.start);

		// Total number of pages, divided by 10 of the entire post count, then grab the ceiling
		rc.totalPages = variables.forumServices.getTotalPages(rc.topicsCount);

		// Redirects if subcategory is not active
		if(!rc.subcategory.getIsActive()){
			variables.fw.redirect(action='main.404',preserve='all');
		}

    }

    function topic(rc) {

    	param name="rc.start" default="1";
		param name="rc.pageSize" default="10";

		// User specific
		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.isAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

		// Forum specific
		rc.topic = variables.forumServices.getForumTopicByPK(rc.topicid);
		rc.posts = variables.forumServices.getForumPostsPagination(rc.topic,rc.start,rc.pageSize);
		rc.postsCount = variables.forumServices.getForumPostsTotal(rc.topic);
		rc.subCategoryID = rc.topic.getForumSubCategory().getForumSubCategoryID();

		rc.pageTitle = "Forums | #rc.topic.getTitle()#";

		// Determines the current page by grabbing the tenth of the start URL.
		rc.currentPage = variables.forumServices.getCurrentPage(rc.start);

		// Total number of pages, divided by 10 of the entire post count, then grab the ceiling
		rc.totalPages = variables.forumServices.getTotalPages(rc.postsCount);

		// This is user to grab the actual post number for each post
		rc.postNumber = variables.forumServices.getPostNumber(rc.currentPage);

		// Redirects if topic is not active
		if(!rc.topic.getIsActive()){
			variables.fw.redirect(action='main.404',preserve='all');
		}

    }

    function newTopic(rc) {

		if(structKeyExists(rc, "topicid")){

			rc.topic = variables.forumServices.getForumTopicByPK(rc.topicid);
			rc.subCategory = rc.topic.getForumSubCategory();
			rc.subCategoryID = rc.subCategory.getForumSubCategoryID();
			rc.title = rc.topic.getTitle();
			rc.content = rc.topic.getBody();
			rc.pageTitle = "Edit Topic | #rc.title#";

			rc.isAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

			if(!rc.isAdmin){
				if(rc.topic.getUser().getUserID() NEQ session.user.userid){
					variables.fw.redirect(action='main.404',preserve='all');
				}
			}

		}
		else{
    		rc.subCategory = variables.forumServices.getForumSubCategoryByPK(rc.subCategoryID);
    		rc.title = "";
			rc.content = "";
			rc.pageTitle = "New Topic";
		}

		// Redirects if topic is not active
		if(!rc.subCategory.getIsActive()){
			variables.fw.redirect(action='main.404',preserve='all');
		}

    }

    function newPost(rc) {

		if(structKeyExists(rc, "postid")){

			rc.post = variables.forumServices.getForumPostByPK(rc.postid);
			rc.topic = rc.post.getForumTopic();
			rc.topicid = rc.post.getForumTopic().getForumTopicID();
			rc.title = rc.post.getTitle();
			rc.content = rc.post.getBody();
			rc.pageTitle = "Edit Post | #rc.title#";

			rc.isAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

			if(!rc.isAdmin){
				if(rc.topic.getUser().getUserID() NEQ session.user.userid){
					variables.fw.redirect(action='main.404',preserve='all');
				}
			}

		}

		// Redirects if topic is not active
		if(!rc.topic.getIsActive()){
			variables.fw.redirect(action='main.404',preserve='all');
		}

    }

    /*
		Action Pages
    */

    function savePost(rc) {

    	// Validation

    	rc.pageErrors = [];

    	if(!len(rc.content)){
    		 arrayAppend(rc.pageErrors, "You cannot submit a blank post.");
    	}

    	if(arrayLen(rc.pageErrors)) {
            variables.fw.redirect(action='forum.topic', preserve='all');
        }

        rc.pageSuccess = "Your post has been submitted.";

    	// Controller Action

		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.topic = variables.forumServices.getForumTopicByPK(rc.topicid);
		rc.post = "";
		if(structKeyExists(rc, "postid")){
			rc.post = variables.forumServices.getForumPostByPK(rc.postid);
		}

		rc.postsCount = variables.forumServices.getForumPostsTotal(rc.topic);
		rc.postsCount ++;
		rc.totalPages = variables.forumServices.getTotalPages(rc.postsCount);
		rc.startCount = variables.forumServices.getStartCount(rc.totalPages);

		local.newPost = variables.forumServices.savePost(rc.topic,rc.user,rc.content,rc.post);

		variables.fw.redirect(action='forum.topic',queryString="start=#rc.startCount###post-#local.newPost#", preserve='all');

    }

    function saveTopic(rc) {

    	// Validation

    	rc.pageErrors = [];

    	if(!len(rc.title)){
    		 arrayAppend(rc.pageErrors, "Please include a title to your post.");
    	}

    	if(!len(rc.content)){
    		 arrayAppend(rc.pageErrors, "You cannot submit a blank topic.");
    	}

    	if(arrayLen(rc.pageErrors)) {
            variables.fw.redirect(action='forum.subcategory', preserve='all');
        }

        rc.pageSuccess = "Your topic has been submitted.";

        // Controller Action

		rc.user = variables.userServices.getByPk(session.user.userid);
		rc.subCategory = variables.forumServices.getForumSubCategoryByPK(rc.subCategoryID);
		rc.topic = "";
		if(structKeyExists(rc, "topicid")){
			rc.topic = variables.forumServices.getForumTopicByPK(rc.topicid);
		}

		local.newTopic = variables.forumServices.saveTopic(rc.subCategory,rc.user,rc.title,rc.content,rc.topic);
		variables.fw.redirect(action='forum.topic',queryString="topicid=#local.newTopic#",preserve='all');


    }

    function deleteTopic(rc) {

    	if(structKeyExists(rc, "topicid")){

    		rc.isAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

			if(rc.isAdmin OR rc.topic.getUser().getUserID() EQ session.user.userid){

				rc.pageSuccess = "The topic has been deleted.";

	    		rc.topic = variables.forumServices.getForumTopicByPK(rc.topicid);
				variables.forumServices.softDeleteForumEntity(rc.topic);
				rc.subcategoryid = rc.topic.getForumSubCategory().getForumSubCategoryID();

				variables.fw.redirect(action='forum.subcategory',preserve='all');

			}

			variables.fw.redirect(action='main.404',preserve='all');

    	}

    	variables.fw.redirect(action='main.404',preserve='all');

    }

    function deletePost(rc) {

    	if(structKeyExists(rc, "postid")){

    		rc.isAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

			if(rc.isAdmin OR rc.topic.getUser().getUserID() EQ session.user.userid){

				rc.pageSuccess = "The post has been deleted.";

	    		rc.post = variables.forumServices.getForumPostByPK(rc.postid);
	    		rc.topicid = rc.post.getForumTopic().getForumTopicID();
				variables.forumServices.softDeleteForumEntity(rc.post);

				variables.fw.redirect(action='forum.topic',preserve='all');

			}

			variables.fw.redirect(action='main.404',preserve='all');

    	}

    	variables.fw.redirect(action='main.404',preserve='all');

    }

    function lockTopic(rc) {

		rc.isAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

    	if(structKeyExists(rc, "topicid") AND rc.isAdmin){

			if(rc.lock){
    			rc.pageSuccess = "This topic is now locked.";
			}
			else{
				rc.pageSuccess = "This topic is now unlocked.";
			}

    		rc.topic = variables.forumServices.getForumTopicByPK(rc.topicid);
			variables.forumServices.lockForumEntity(rc.topic, rc.lock);

			variables.fw.redirect(action='forum.topic',preserve='all');

    	}

    	variables.fw.redirect(action='main.404',preserve='all');

    }

    function stickyTopic(rc) {

		rc.isAdmin = variables.userServices.userHasPermissions(session.user.userid,"Forum Admin");

    	if(structKeyExists(rc, "topicid") AND rc.isAdmin){

    		if(rc.stick){
    			rc.pageSuccess = "This topic is now a sticky.";
			}
			else{
				rc.pageSuccess = "This topic is no longer a sticky.";
			}

    		rc.topic = variables.forumServices.getForumTopicByPK(rc.topicid);
			variables.forumServices.stickyForumEntity(rc.topic, rc.stick);

			variables.fw.redirect(action='forum.topic',preserve='all');

    	}

    	variables.fw.redirect(action='main.404',preserve='all');

    }

}