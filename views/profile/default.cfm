<cfoutput>
	<div class="row">
		<div class="span12">
			<div class="template-wrapper">
				<div class="block span12 first cf">
					<div class="block boxed full-width-section parallax_section bgpat" style="margin-right:10px;">
						<div class="light">
							<div class="block block-text_block span4 first cf">
								<div style="float:left;margin-top:-8px;margin-left:10px;">
									<img alt="" src="#rc.user.getProfile().getImage()#">
								</div>
								<div style="float:right;margin-right:20px;">
									<p><span class="fz48">#rc.user.getUserName()#</span></p>
									<p><span class="fz26">#rc.user.getPackage().getName()#</span></p>
								</div>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<div class="block block-four_block span4 first cf">
					<div class="text-container centered bgpattern charblock">
						<p style="font-size:50px;padding-top:20px;color:##fff;">#arrayLen(rc.user.getPresentingTalks())#</p>
						<h2>Presented Talks</h2>
						<p></p>
						<p><a href="#buildURL(action='talk.user',queryString='presenterid=#rc.user.getUserID()#')#" style="color:##fff;">View All User's Talks</a></p>
						<p></p>
					</div>
				</div>
				<div class="block block-four_block span4  cf">
					<div class="text-container centered bgpattern charblock">
						<p style="font-size:50px;padding-top:20px;color:##fff;">#arrayLen(rc.user.getForumPosts()) + arrayLen(rc.user.getForumTopics())#</p>
						<h2>Forum Posts</h2>
						<p></p>
						<p><a href="#buildURL('forum')#" style="color:##fff;">Go To Forums</a></p>
						<p></p>
					</div>
				</div>
				<div class="block block-four_block span4  cf">
					<div class="text-container centered bgpattern charblock">
						<p style="font-size:50px;padding-top:20px;color:##fff;">0</p>
						<h2>Coming Soon</h2>
						<p></p>
						<p>Not Available in Beta</p>
						<p></p>
					</div>
				</div>
				<div id="block-4" class="block block-text_block span6 first cf">
					<div class="title-wrapper">
						<h3 class="widget-title">About #rc.user.getUserName()#</h3>
						<div class="clear"></div>
					</div>
					<div class="wcontainer">
						<p>#rc.user.getProfile().getAboutMe()#</p>
					</div>
				</div>
				<div id="block-5" class="block block-skills_block span6  cf">
				    <div class="title-wrapper">
				        <h3 class="widget-title">Additional Information</h3>
				        <div class="clear"></div>
				    </div>
				    <div class="wcontainer">
						<p>
							<cfif len(rc.user.getProfile().getLocation())><i class="icon-map-marker "></i> #rc.user.getProfile().getLocation()#<br></cfif>
							<cfif len(rc.user.getProfile().getWebSite())><i class="icon-link "></i> <a href="#rc.user.getProfile().getWebSite()#">#rc.user.getProfile().getWebSite()#</a><br></cfif>
							<cfif len(rc.user.getProfile().getTwitter())><i class="icon-twitter-sign "></i> #rc.user.getProfile().getTwitter()#<br></cfif>
							<cfif len(rc.user.getProfile().getFacebook())><i class="icon-facebook-sign "></i> #rc.user.getProfile().getFacebook()#<br></cfif>
							<cfif len(rc.user.getProfile().getLinkedIn())><i class="icon-linkedin-sign"></i> #rc.user.getProfile().getLinkedIn()#<br></cfif>
							<cfif len(rc.user.getProfile().getGoogle())><i class="icon-google-plus-sign"></i> #rc.user.getProfile().getGoogle()#</cfif>
						</p>
					</div>
			   </div>
			</div>
		</div>
	</div>
</cfoutput>
