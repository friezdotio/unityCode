<cfoutput>
	<div class="span12">
		<div class="template-wrapper">
			<div class="block block-page_header_block span12 first cf">
				<div class="span12 block-title centered">
					<h2>User Dashboard</h2>
					<p><a href="#buildURL('user.logout')#">LOGOUT</a></p>
				</div>
				<div class="span12 block-divider"></div>
			</div>
			<div class="block block-text_block span4 first cf">
				<div class="title-wrapper">
					<h3 class="widget-title">Profile Links</h3>
					<div class="clear"></div>
				</div>
				<div class="wcontainer">
					<p>View/Edit your user profile. This information can be viewed by the public.</p>
					<ul>
						<li><a href="#buildURL('profile')#">View Profile</a></li>
						<li><a href="#buildURL('profile.edit')#">Edit Profile</a></li>
					</ul>
				</div>
			</div>
			<div class="block block-text_block span4  cf">
				<div class="title-wrapper">
					<h3 class="widget-title">User Links</h3>
					<div class="clear"></div>
				</div>
				<div class="wcontainer">
					<p>Change your password, timezone, and other user information.</p>
					<ul>
						<li><a href="#buildURL('user.edit')#">Edit Settings</a></li>
						<li><a href="#buildURL('user.logout')#">Logout</a></li>
					</ul>
				</div>
			</div>
			<cfif rc.isForumAdmin OR rc.isUserAdmin>
				<div class="block block-text_block span4  cf">
					<div class="title-wrapper">
						<h3 class="widget-title">Admin Links</h3>
						<div class="clear"></div>
					</div>
					<div class="wcontainer">
						<p>If you're not an admin, you shouldn't be seeing this.</p>
						<ul>
							<cfif rc.isForumAdmin><li><a href="#buildURL('admin.forum')#">Forum Admin</a></li></cfif>
							<cfif rc.isUserAdmin><li><a href="#buildURL('admin.user')#">User Admin</a></li></cfif>
							<cfif rc.isSystemAdmin><li><a href="#buildURL('admin.reloadApplication')#">Reload ORM</a></li></cfif>
						</ul>
					</div>
				</div>
			</cfif>
			<div class="block block-text_block span6 first cf">
				<div class="title-wrapper">
					<h3 class="widget-title">Presenting Talks</h3>
					<div class="clear"></div>
				</div>
				<div class="widget">
					<div class="wcontainer">
						<cfif arrayLen(rc.presentingTalks)>
							<ul class="review">
								<cfloop array="#rc.presentingTalks#" index="local.talk">
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
						<cfelse>
							You are not presenting any talks.
						</cfif>
					</div>
				</div>
			</div>
			<div class="block block-text_block span6 cf">
				<div class="title-wrapper">
					<h3 class="widget-title">Registered Talks</h3>
					<div class="clear"></div>
				</div>
				<div class="widget">
					<div class="wcontainer">
						<cfif arrayLen(rc.registeredTalks)>
							<ul class="review">
								<cfloop array="#rc.registeredTalks#" index="local.talk">
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
								</ul>
							</cfloop>
						<cfelse>
							You are not registered to any talks.
						</cfif>
					</div>
				</div>
			</div>
			<!--- THIS IS FOR REVIEWS COMING SOON
			<div class="block block-text_block span4 first cf">
				<div class="title-wrapper">
					<h3 class="widget-title">Text box</h3>
					<div class="clear"></div>
				</div>
				<div class="wcontainer">
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lorem quam, adipiscing condimentum tristique vel, eleifend sed turpis. Pellentesque cursus arcu id magna euismod in elementum purus molestie. Curabitur pellentesque massa eu nulla consequat sed porttitor arcu porttitor. Quisque volutpat pharetra felis, eu cursus lorem molestie vitae. Aliquam purus velit, placerat ac faucibus at, mattis vel orci. Nulla vitae eros quam. Duis lobortis elit vitae neque gravida eu consectetur mauris rutrum. Aenean viverra dui eu lectus elementum iaculis. Quisque eu mauris quis nunc sodales faucibus et in ligula.</p>
				</div>
			</div> --->
			<div class="clear"></div>
		</div>
	</div>
</cfoutput>
