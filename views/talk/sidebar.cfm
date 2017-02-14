
<cfoutput>
	<cfif session.user.isLoggedin>
		<div class="first widget">
			<div>
				<a href="#buildURL('talk.add')#">
					<input type="button" class="button-green button-medium" style="width:100%;" value="Create a New Talk">
				</a>
			</div>
		</div>
	</cfif>
	<div class="widget">
		<div class="title-wrapper">
			<h3 class="widget-title">Popular Tags</h3>
			<div class="clear"></div>
		</div>
		<div class="wcontainer">
			<div class="tagcloud">
				<cfloop array="#rc.sidebarTags#" index="local.tag">
					<a href="#buildURL(action='talk.tag',queryString='tag=#local.tag#')#">#local.tag#</a>
				</cfloop>
			</div>
		</div>
	</div>
	<div class="widget">
		<div class="title-wrapper">
			<h3 class="widget-title"> Popular Talks</h3>
			<div class="clear"></div>
		</div>
		<div class="wcontainer">
			<ul class="review">
				<cfloop array="#rc.sidebarPopularTalks#" index="local.talk">
					<li>
						<div class="info">
							<a href="#buildURL(action='talk.view', queryString='talkid=#local.talk.getTalkID()#')#"><strong>#local.talk.getTitle()#</strong></a><br>
							<small>
								<i class="icon-tag"></i> <cfloop array="#local.talk.getTags()#" index="local.tag"><a href="#buildURL(action='talk.tag',queryString='tag=#local.tag.getName()#')#">#local.tag.getName()#</a> </cfloop><br>
								<i class="icon-calendar"></i> #dateFormat(local.talk.getLocalStart(), "mm-dd-yyyy")# - #timeFormat(local.talk.getLocalStart(), "hh:mm tt")#
							</small>
						</div>
						<div class="clear"></div>
					</li>
				</cfloop>
			</ul>
		</div>
	</div>
	<div class="widget-5 last widget">
		<div class="title-wrapper">
			<h3 class="widget-title"> Upcoming Talks</h3>
			<div class="clear"></div>
		</div>
		<div class="wcontainer">
			<ul class="review">
				<cfloop array="#rc.sidebarUpcomingTalks#" index="local.talk">
					<li>
						<div class="info">
							<a href="#buildURL(action='talk.view', queryString='talkid=#local.talk.getTalkID()#')#"><strong>#local.talk.getTitle()#</strong></a><br>
							<small>
								<i class="icon-tag"></i> <cfloop array="#local.talk.getTags()#" index="local.tag"><a href="#buildURL(action='talk.tag',queryString='tag=#local.tag.getName()#')#">#local.tag.getName()#</a> </cfloop><br>
								<i class="icon-calendar"></i> #dateFormat(local.talk.getLocalStart(), "mm-dd-yyyy")# - #timeFormat(local.talk.getLocalStart(), "hh:mm tt")#
							</small>
						</div>
						<div class="clear"></div>
					</li>
				</cfloop>
			</ul>
		</div>
	</div>
</cfoutput>

