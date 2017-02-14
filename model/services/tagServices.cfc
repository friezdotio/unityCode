component extends="baseServices" {

	public any function get(){
		return entityLoad("tag");
    }

    public any function getByPK(id){
		return entityLoadByPK("tag",arguments.id);
    }

    public any function getGrouped(){
		local.hqlObject = ORMExecuteQuery("
	      	FROM tag
	      	GROUP BY name
	      	ORDER BY name
	    ");
		return local.hqlObject;
    }

    public any function getPopular(maxResults){
    	if(len(arguments.maxResults)){
			local.hqlObject = ORMExecuteQuery("
				SELECT name
		      	FROM tag
		      	GROUP BY name
		      	ORDER BY count(name) DESC, name
		    	",{maxresults=arguments.maxResults}
			);
    	}
    	else{
    		local.hqlObject = ORMExecuteQuery("
    			SELECT name
		      	FROM tag
		      	GROUP BY name
		      	ORDER BY count(name) DESC, name
			");
    	}
		return local.hqlObject;
    }

}