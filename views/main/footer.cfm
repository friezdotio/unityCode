<cfoutput>
	<div class="span12">
		<!--- THIS WILL BE REVIEWS LATER --->
		<div class="first footer_widget span3">
			<h3>popular talks</h3>
			<ul class="review">
				<cfif arrayLen(rc.footer.popularTalks)>
					<cfloop array="#rc.footer.popularTalks#" index="local.talk">
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
				<cfelse>
					There are currently no talks.
				</cfif>
			</ul>
		</div>
		<div class="footer_widget span3">
			<h3>upcoming talks</h3>
			<ul class="review">
				<cfif arrayLen(rc.footer.upcomingTalks)>
					<cfloop array="#rc.footer.upcomingTalks#" index="local.talk">
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
				<cfelse>
					There are currently no talks.
				</cfif>
			</ul>
		</div>
		<div class="footer_widget span3">
			<h3>latest topics</h3>
			<ul>
				<cfif arrayLen(rc.footer.latestTopics)>
					<cfloop array="#rc.footer.latestTopics#" index="local.topic">
						<li><a class="bbp-forum-title" href="#buildURL(action='forum.topic', queryString='topicid=#local.topic.getForumTopicID()#')#"><i class="icon-comment"></i>#local.topic.getTitle()#</a></li>
					</cfloop>
				<cfelse>
					There are currently no topics.
				</cfif>
			</ul>
		</div>
		<div class="widget-4 last footer_widget span3">
			<h3>community projects</h3>
			<div class="wcontent wprojects">
				Projects are coming!
				<!--- <a href="##" data-toggle="tooltip" data-original-title="The swamp lord">
					<img src="/layouts/assets/img/defaults/305x305.jpg" class="attachment-post-thumbnail wp-post-image" alt="7">
				</a>
				<a href="##" data-toggle="tooltip" data-original-title="Call of the dragon">
					<img width="305" height="305" src="/layouts/assets/img/defaults/305x305.jpg" class="attachment-post-thumbnail wp-post-image" alt="6">
				</a>
				<a href="##" data-toggle="tooltip" data-original-title="Evil intentions">
					<img width="305" height="305" src="/layouts/assets/img/defaults/305x305.jpg" class="attachment-post-thumbnail wp-post-image" alt="5">
					</a>
				<a href="##" data-toggle="tooltip" data-original-title="Under the water">
					<img width="305" height="305" src="/layouts/assets/img/defaults/305x305.jpg" class="attachment-post-thumbnail wp-post-image" alt="4">
				</a>
				<a href="##" data-toggle="tooltip" data-original-title="The boss">
					<img width="305" height="305" src="/layouts/assets/img/defaults/305x305.jpg" class="attachment-post-thumbnail wp-post-image" alt="3">
				</a>
				<a href="##" data-toggle="tooltip" data-original-title="The god">
					<img width="305" height="305" src="/layouts/assets/img/defaults/305x305.jpg" class="attachment-post-thumbnail wp-post-image" alt="2">
				</a> --->
			</div>
		</div>
	</div>
	<div class="copyright span12">
		<p>© &nbsp;unityco.de is a <a href="http://friez.io" target="_blank">friez.io LLC</a> product.&nbsp;</p>
		<p style="float:right;padding-right:10px;">
			Current Timezone: <a href="#buildURL('user.dashboard')#">#rc.header.user.getTimeZone()#</a>
		</p>
	</div>
</cfoutput>