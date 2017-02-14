component accessors="true" extends="base"{

    function init(fw) {
        variables.fw = fw;
    }

    /*
    	Display Pages
    */

    function default(rc) {

		rc.pageTitle = "Tags";
		rc.pageDescription = "It's like a 24/7 developer conference!";

    	rc.tags = variables.tagServices.getGrouped();
    	rc.popularTags = variables.tagServices.getPopular(30);

    	// Side Bar
    	rc.sideBarTags = variables.tagServices.getPopular(30);
    	rc.sideBarUpcomingTalks = variables.talkServices.getUpcoming(5);
    	rc.sideBarPopularTalks = variables.talkServices.getPopular(5);

    }

    /*
    	Action Pages
    */
}