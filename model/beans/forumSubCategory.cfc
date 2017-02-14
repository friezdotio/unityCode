component persistent="true" {

    property name="forumSubCategoryID" generator="native" ormtype="integer" fieldtype="id";
    property name="label" ormtype="string" length="50" notnull="true" required="true";
    property name="description" ormtype="string" length="255" notnull="false" required="false";
    property name="order" ormtype="integer" notnull="true" required="true";
    property name="isActive" ormtype="boolean" default="false" notnull="true" required="true";

	// Relationships

	property name="forumTopics" fieldType="one-to-many" cfc="forumTopic"
             type="array" cascade="all" fkcolumn="forumSubCategoryID"
             singularname="forumTopic" inverse="true" orderBy="isSticky,created DESC";

    property name="forumCategory" fieldType="many-to-one" cfc="forumCategory"
    		 orderBy="order ASC";

    function init(){
    	return this;
    }

    public any function getPostCount(){

    	local.queryObj = new query();
		local.queryObj.setDatasource("unitycode");
		local.queryObj.setName("local.qSubCategory");
		local.queryObj.addParam(name="forumSubCategoryID",value=this.getForumSubCategoryID(),cfsqltype="cf_sql_integer");
		local.result = local.queryObj.execute(sql="SELECT p.forumPostID FROM forumSubCategory s JOIN forumTopic t ON t.forumSubCategoryID = s.forumSubCategoryID JOIN forumPost p ON p.forumTopicID = t.forumTopicID WHERE s.forumSubCategoryID = :forumSubCategoryID AND p.isActive = true AND t.isActive = true");
		local.qSubCategory = local.result.getResult();
		local.queryObj.clearParams();

		return local.qSubCategory.recordCount;
    }

    public any function getTopicCount(){

    	local.queryObj = new query();
		local.queryObj.setDatasource("unitycode");
		local.queryObj.setName("local.qSubCategory");
		local.queryObj.addParam(name="forumSubCategoryID",value=this.getForumSubCategoryID(),cfsqltype="cf_sql_integer");
		local.result = local.queryObj.execute(sql="SELECT t.forumTopicID FROM forumSubCategory s JOIN forumTopic t ON t.forumSubCategoryID = s.forumSubCategoryID WHERE s.forumSubCategoryID = :forumSubCategoryID AND t.isActive = true");
		local.qSubCategory = local.result.getResult();
		local.queryObj.clearParams();

		return local.qSubCategory.recordCount;
    }

    public any function getLatestPostedUser(){

    	local.queryObj = new query();
		local.queryObj.setDatasource("unitycode");
		local.queryObj.setName("local.qSubCategory");
		local.queryObj.addParam(name="forumSubCategoryID",value=this.getForumSubCategoryID(),cfsqltype="cf_sql_integer");
		local.result = local.queryObj.execute(sql="SELECT u.userID,u.username,u.email,u.isActive,u.created,u.edited,pr.image FROM forumSubCategory s JOIN forumTopic t ON t.forumSubCategoryID = s.forumSubCategoryID JOIN forumPost p ON p.forumTopicID = t.forumTopicID JOIN user u ON p.userid = u.userid JOIN profile pr ON pr.profileid = u.profileid WHERE s.forumSubCategoryID = :forumSubCategoryID AND p.isActive = true AND u.isActive = true ORDER BY p.created DESC LIMIT 1");
		local.qSubCategory = local.result.getResult();
		local.queryObj.clearParams();

		if(local.qSubCategory.recordCount EQ 0){
			local.queryObj = new query();
			local.queryObj.setDatasource("unitycode");
			local.queryObj.setName("local.qSubCategory");
			local.queryObj.addParam(name="forumSubCategoryID",value=this.getForumSubCategoryID(),cfsqltype="cf_sql_integer");
			local.result = local.queryObj.execute(sql="SELECT u.userID,u.username,u.email,u.isActive,u.created,u.edited,pr.image FROM forumSubCategory s JOIN forumTopic t ON t.forumSubCategoryID = s.forumSubCategoryID JOIN user u ON t.userid = u.userid JOIN profile pr ON pr.profileid = u.profileid WHERE s.forumSubCategoryID = :forumSubCategoryID AND t.isActive = true AND u.isActive = true ORDER BY t.created DESC LIMIT 1");
			local.qSubCategory = local.result.getResult();
			local.queryObj.clearParams();
		}

		return local.qSubCategory;
    }

    public any function getLatestPostDate(){

    	local.queryObj = new query();
		local.queryObj.setDatasource("unitycode");
		local.queryObj.setName("local.qSubCategory");
		local.queryObj.addParam(name="forumSubCategoryID",value=this.getForumSubCategoryID(),cfsqltype="cf_sql_integer");
		local.result = local.queryObj.execute(sql="SELECT p.created FROM forumSubCategory s JOIN forumTopic t ON t.forumSubCategoryID = s.forumSubCategoryID JOIN forumPost p ON p.forumTopicID = t.forumTopicID WHERE s.forumSubCategoryID = :forumSubCategoryID AND p.isActive = true ORDER BY p.created DESC LIMIT 1");
		local.qSubCategory = local.result.getResult();
		local.queryObj.clearParams();

		local.return = "";
		if(local.qSubCategory.recordCount GT 0){
			local.localCreated = application.baseServices.timeZoneConvert(local.qSubCategory.created,application.timezone,session.user.timezone);
			local.localNow = application.baseServices.timeZoneConvert(now(),application.timezone,session.user.timezone);
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
			local.queryObj.addParam(name="forumSubCategoryID",value=this.getForumSubCategoryID(),cfsqltype="cf_sql_integer");
			local.result = local.queryObj.execute(sql="SELECT t.created FROM forumSubCategory s JOIN forumTopic t ON t.forumSubCategoryID = s.forumSubCategoryID WHERE s.forumSubCategoryID = :forumSubCategoryID AND t.isActive = true ORDER BY t.created DESC LIMIT 1");
			local.qTopic = local.result.getResult();
			local.queryObj.clearParams();

			if(local.qTopic.recordCount GT 0){
				local.localCreated = application.baseServices.timeZoneConvert(local.qTopic.created,application.timezone,session.user.timezone);
				local.localNow = application.baseServices.timeZoneConvert(now(),application.timezone,session.user.timezone);
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

}