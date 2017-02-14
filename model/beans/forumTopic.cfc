component persistent="true" {

   	property name="forumTopicID" generator="native" ormtype="integer" fieldtype="id";
    property name="title" ormtype="string" length="255" notnull="true" required="true";
    property name="body" ormtype="text" notnull="true" required="true";
    property name="isSticky" ormtype="boolean" default="false" notnull="true" required="true";
    property name="isLocked" ormtype="boolean" default="false" notnull="true" required="true";
    property name="isActive" ormtype="boolean" default="false" notnull="true" required="true";

	property name="created" ormtype="timestamp" default="#now()#";
    property name="edited" ormtype="timestamp" default="#now()#";

	// Relationships

    property name="user" fieldType="many-to-one" cfc="user";

	property name="forumSubCategory" fieldType="many-to-one" cfc="forumSubCategory"
             cascade="all" fkcolumn="forumSubCategoryID"
             orderBy="order ASC";

    property name="forumPosts" fieldType="one-to-many" cfc="forumPost"
             type="array" cascade="all" fkcolumn="forumTopicID" inverse="true"
             singularname="forumPost" orderBy="created ASC";

	function init(){
    	return this;
    }

    public any function getLatestPostedUser(){

    	local.queryObj = new query();
		local.queryObj.setDatasource("unitycode");
		local.queryObj.setName("local.qSubCategory");
		local.queryObj.addParam(name="forumTopicID",value=this.getForumTopicID(),cfsqltype="cf_sql_integer");
		local.result = local.queryObj.execute(sql="SELECT u.userID,u.username,u.email,u.isActive,u.created,u.edited,pr.image FROM forumTopic t JOIN forumPost p ON p.forumTopicID = t.forumTopicID JOIN user u ON p.userid = u.userid JOIN profile pr ON pr.profileid = u.profileid WHERE t.forumTopicID = :forumTopicID AND p.isActive = true AND u.isActive = true ORDER BY p.created DESC LIMIT 1");
		local.qSubCategory = local.result.getResult();
		local.queryObj.clearParams();

		if(local.qSubCategory.recordCount LTE 0){
			local.queryObj = new query();
			local.queryObj.setDatasource("unitycode");
			local.queryObj.setName("local.qSubCategory");
			local.queryObj.addParam(name="forumTopicID",value=this.getForumTopicID(),cfsqltype="cf_sql_integer");
			local.result = local.queryObj.execute(sql="SELECT u.userID,u.username,u.email,u.isActive,u.created,u.edited,pr.image FROM forumTopic t JOIN user u ON t.userid = u.userid JOIN profile pr ON pr.profileid = u.profileid WHERE t.forumTopicID = :forumTopicID AND u.isActive = true LIMIT 1");
			local.qSubCategory = local.result.getResult();
			local.queryObj.clearParams();
		}

		return local.qSubCategory;
    }

    public any function getLatestPostDate(){

    	local.queryObj = new query();
		local.queryObj.setDatasource("unitycode");
		local.queryObj.setName("local.qSubCategory");
		local.queryObj.addParam(name="forumTopicID",value=this.getForumTopicID(),cfsqltype="cf_sql_integer");
		local.result = local.queryObj.execute(sql="SELECT p.created FROM forumTopic t JOIN forumPost p ON p.forumTopicID = t.forumTopicID WHERE t.forumTopicID = :forumTopicID AND p.isActive = true ORDER BY p.created DESC LIMIT 1");
		local.qSubCategory = local.result.getResult();
		local.queryObj.clearParams();

		local.localNow = application.baseServices.timeZoneConvert(now(),application.timezone,session.user.timezone);
		if(local.qSubCategory.recordCount GT 0){
			local.localCreated = application.baseServices.timeZoneConvert(local.qSubCategory.created,application.timezone,session.user.timezone);
			local.return = "#DateDiff("d", local.localCreated, local.localNow)# Day(s) Ago";
			if(DateDiff("d", local.localCreated, local.localNow) LT 1){
				local.return = "#DateDiff("h", local.localCreated, local.localNow)# Hour(s) Ago";
			}
			if(DateDiff("h", local.localCreated, local.localNow) LT 1){
				local.return = "#DateDiff("n", local.localCreated, local.localNow)# Minute(s) Ago";
			}
		}
		else{
			local.queryObj = new query();
			local.queryObj.setDatasource("unitycode");
			local.queryObj.setName("local.qTopic");
			local.queryObj.addParam(name="forumTopicID",value=this.getForumTopicID(),cfsqltype="cf_sql_integer");
			local.result = local.queryObj.execute(sql="SELECT t.created FROM forumTopic t WHERE t.forumTopicID = :forumTopicID");
			local.qTopic = local.result.getResult();
			local.queryObj.clearParams();

			if(local.qTopic.recordCount GT 0){
				local.localCreated = application.baseServices.timeZoneConvert(local.qTopic.created,application.timezone,session.user.timezone);
				local.return = "#DateDiff("d", local.localCreated, local.localNow)# Day(s) Ago";
				if(DateDiff("d", local.localCreated, local.localNow) LT 1){
					local.return = "#DateDiff("h", local.localCreated, local.localNow)# Hour(s) Ago";
				}
				if(DateDiff("h", local.localCreated, local.localNow) LT 1){
					local.return = "#DateDiff("n", local.localCreated, local.localNow)# Minute(s) Ago";
				}
			}
		}
		return local.return;
    }

    public any function getPostCount(){

    	local.queryObj = new query();
		local.queryObj.setDatasource("unitycode");
		local.queryObj.setName("local.qForumTopic");
		local.queryObj.addParam(name="forumTopicID",value=this.getForumTopicID(),cfsqltype="cf_sql_integer");
		local.result = local.queryObj.execute(sql="SELECT p.forumPostID FROM forumTopic t JOIN forumPost p ON p.forumTopicID = t.forumTopicID WHERE t.forumTopicID = :forumTopicID AND p.isActive = true");
		local.qForumTopic = local.result.getResult();
		local.queryObj.clearParams();

		return local.qForumTopic.recordCount;
    }

    public any function getLocalCreated(){
    	return application.baseServices.timeZoneConvert(this.getCreated(),application.timezone,session.user.timezone);
    }

}