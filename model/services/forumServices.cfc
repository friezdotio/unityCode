component extends="baseServices" {

	public any function getForumCategories(){
		return entityLoad("forumCategory",{isActive=true});
    }

    public any function getAllForumCategories(){
		return entityLoad("forumCategory");
    }

    public any function getForumCategoryByPK(categoryid){
		return entityLoadByPK("forumCategory", arguments.categoryid);
    }

    public any function getForumSubCategoryByPK(subcategoryid){
		return entityLoadByPK("forumSubCategory", arguments.subcategoryid);
    }

    public any function getForumTopicByPK(topicid){
		return entityLoadByPK("forumTopic", arguments.topicid);
    }

    public any function getForumPostByPK(postid){
		return entityLoadByPK("forumPost", arguments.postid);
    }

     public any function getForumTopicsPagination(subCategory,start,pageSize){
    	local.hqlObject = ORMExecuteQuery("
    		SELECT DISTINCT t
    		FROM forumTopic t
    		LEFT JOIN FETCH t.forumPosts p
	      	WHERE t.isActive = true
	      	AND t.isSticky = false
	      	AND t.forumSubCategory = :subCategory
	      	ORDER BY t.created DESC
	  		",{maxresults=arguments.pageSize
	       	,subCategory=arguments.subCategory
	       	,offset=arguments.start - 1}
		);
		return local.hqlObject;
    }

    public any function getLatestForumTopics(maxResults){
		return entityLoad("forumTopic", {isActive=true}, "created DESC", {maxresults=arguments.maxResults});
    }

    public any function getForumTopicsTotal(subCategory){

    	local.total = entityLoad("forumTopic", {forumSubCategory=arguments.subCategory,isActive=true,isSticky=false});

		return arrayLen(local.total);
    }

    public any function getStickyForumTopics(subCategory){
		return entityLoad("forumTopic", {forumSubCategory=arguments.subCategory,isActive=true,isSticky=true}, "created DESC");
    }

    public any function getForumPostsByTopic(topic){
		return entityLoad("forumPost", {forumTopic=arguments.topic,isActive=true});
    }

    public any function getForumPostsPagination(topic,start,pageSize){
		return entityLoad("forumPost", {forumTopic=arguments.topic,isActive=true}, "created ASC", {maxresults=arguments.pageSize,offset=arguments.start-1});
    }

    public any function getForumPostsTotal(topic){

    	local.total = entityLoad("forumPost", {forumTopic=arguments.topic,isActive=true});

		return arrayLen(local.total);
    }

    public any function getForumCategoriesByUserID(userid){
    	local.hqlObject = ORMExecuteQuery("
    						SELECT DISTINCT c
					      	FROM forumCategory c
					      	JOIN c.permissions p
					      	JOIN p.users u
					      	WHERE u.id = :userid
					      	AND c.isActive = true
					      	ORDER BY c.order ASC
					      ",{userid=arguments.userid});
		return local.hqlObject;
    }

    public any function getCurrentPage(start){

    	local.currentPage = arguments.start + 10;
		// This could also be achived by dividing by 10
		local.currentPage = Left(local.currentPage, len(local.currentPage)-1);

		return local.currentPage;
    }

    public any function getTotalPages(count){
		return ceiling(arguments.count / 10);
    }

	public any function getPostNumber(currentPage){

		local.postNumber = arguments.currentPage - 1;
		local.postNumber = local.postNumber * 10;

		return local.postNumber;
    }

    public any function getStartCount(totalPages){

		local.startCount = arguments.totalPages - 1;
		local.startCount = local.startCount * 10 + 1;

		return local.startCount;
    }

    public any function savePost(topic,user,body,post){

		transaction {
			if(isObject(arguments.post)){
				local.post = arguments.post;
			}
			else{
				local.post = entityNew("forumPost");
			}
			local.post.setBody(arguments.body);
			if(!isObject(arguments.body)){
				local.post.setTitle(arguments.topic.getTitle());
				local.post.setIsActive(true);
				local.post.setCreated(now());
				local.post.setEdited(now());
				local.post.setUser(arguments.user);
				local.post.setForumTopic(arguments.topic);
			}
	    	entitySave(local.post);


			transaction action="commit";
		}

		return local.post.getForumPostID();
    }

     public any function saveTopic(subCategory,user,title,body,topic){

		transaction{
			if(isObject(arguments.topic)){
				local.topic = arguments.topic;
			}
			else{
				local.topic = entityNew("forumTopic");
			}
			local.topic.setTitle(arguments.title);
			local.topic.setBody(arguments.body);
			if(!isObject(arguments.topic)){
				local.topic.setIsSticky(false);
				local.topic.setIsLocked(false);
				local.topic.setIsActive(true);
				local.topic.setCreated(now());
				local.topic.setUser(arguments.user);
				local.topic.setForumSubCategory(arguments.subCategory);
			}
			local.topic.setEdited(now());
	    	entitySave(local.topic);


			transaction action="commit";
		}

		return local.topic.getForumTopicID();
    }

    public any function saveCategory(category,label,description,order,isActive,permissions){

		transaction{
			if(isObject(arguments.category)){
				local.category = arguments.category;
			}
			else{
				local.category = entityNew("forumCategory");
			}
			local.category.setLabel(arguments.label);
			local.category.setDescription(arguments.description);
			local.category.setOrder(arguments.order);
			local.category.setIsActive(arguments.isActive);

			// Removes all permissions to start fresh
			if(isObject(arguments.category)){
				local.category.getPermissions().clear();
			}

			// Adds the permissisons from the list
			local.permissions = listToArray(arguments.permissions);
			for(local.permission in local.permissions){
			    local.objPermission = entityLoadByPK("permission",local.permission);
			    local.category.addPermission(local.objPermission);
			}

	    	entitySave(local.category);


			transaction action="commit";
		}

    	return local.category.getForumCategoryID();
    }

    public any function saveSubCategory(subcategory,category,label,description,order,isActive){

		transaction{
			if(isObject(arguments.subcategory)){
				local.subcategory = arguments.subcategory;
			}
			else{
				local.subcategory = entityNew("forumSubCategory");
			}
			local.subcategory.setLabel(arguments.label);
			local.subcategory.setDescription(arguments.description);
			local.subcategory.setOrder(arguments.order);
			local.subcategory.setIsActive(arguments.isActive);
			local.subcategory.setForumCategory(arguments.category);

	    	entitySave(local.subcategory);


			transaction action="commit";
		}

    	return local.subcategory.getForumSubCategoryID();
    }

	public any function stickyForumEntity(entity,isSticky){

		transaction{
			local.entity = arguments.entity;
			local.entity.setIsSticky(arguments.isSticky);
	    	entitySave(local.entity);


			transaction action="commit";
		}

   	}

   	public any function lockForumEntity(entity,isLocked){

		transaction{
			local.entity = arguments.entity;
			local.entity.setIsLocked(arguments.isLocked);
	    	entitySave(local.entity);


			transaction action="commit";
		}

   	}

   	public any function softDeleteForumEntity(entity){

		transaction{
			local.entity = arguments.entity;
			local.entity.setIsActive(false);
	    	entitySave(local.entity);


			transaction action="commit";
		}

   	}

}