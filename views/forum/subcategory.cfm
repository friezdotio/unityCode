<cfoutput>
	<div class="row">
		<div class="span12">
			<div id="bbpress-forums">
				<div class="bbp-template-notice info">
					<p class="bbp-topic-description"><a href="#buildURL('forum')#">#rc.subcategory.getForumCategory().getLabel()#</a> / #rc.subcategory.getLabel()#</p>
				</div>
				<cfif session.user.isLoggedIn>
					<div style="margin-bottom:10px;">
						<a href="#buildURL(action='forum.newTopic',queryString='subcategoryid=#rc.subcategoryid#')#">
							<input class="button-small" type="button" value="New Topic">
						</a>
					</div>
				</cfif>
				<ul id="bbp-forum-965" class="bbp-topics">
					<li class="bbp-header">
						<ul class="forum-titles">
							<li class="bbp-topic-title">Topic</li>
							<li class="bbp-topic-voice-count"><!--- Views --->&nbsp;</li>
							<li class="bbp-topic-reply-count">Posts</li>
							<li class="bbp-topic-freshness">Freshness</li>
						</ul>
					</li>
					<li class="bbp-body">
						<cfif rc.start EQ 1>
							<cfset local.stickyCount = 1>
							<cfloop array="#rc.stickyTopics#" index="local.stickyTopic">
								<cfset local.stickyCount ++>
								<cfif BitAnd(local.stickyCount, 1)>
							        <cfset local.evenOrOdd = "odd">
							    <cfelse>
							        <cfset local.evenOrOdd = "even">
							    </cfif>
								<ul class="post-993 topic type-topic status-publish hentry odd bbp-parent-forum-965 user-id-1 instock">
									<li class="bbp-topic-title">
										<i class="icon-pushpin"></i>
										<a class="bbp-topic-permalink" href="#buildURL(action='forum.topic', queryString='topicid=#local.stickyTopic.getForumTopicID()#')#" title="#local.stickyTopic.getTitle()#">#local.stickyTopic.getTitle()#</a>
										<p class="bbp-topic-meta">
											<span class="bbp-topic-started-by">Started by: <a href="#buildURL(action='profile', queryString='userid=#local.stickyTopic.getUser().getUserID()#')#" title="View #local.stickyTopic.getUser().getUsername()#'s profile" class="bbp-author-avatar" rel="nofollow"><img alt="" src="#local.stickyTopic.getUser().getProfile().getImage()#" class="avatar avatar-14 photo"></a>&nbsp;<a href="#buildURL(action='profile', queryString='userid=#local.stickyTopic.getUser().getUserID()#')#" title="View #local.stickyTopic.getUser().getUsername()#'s profile" class="bbp-author-name" rel="nofollow">#local.stickyTopic.getUser().getUsername()#</a></span>
										</p>
									</li>
									<li class="bbp-topic-voice-count">&nbsp;</li>
									<li class="bbp-topic-reply-count">#local.stickyTopic.getPostCount()#</li>
									<li class="bbp-topic-freshness">
										<a href="##">#local.stickyTopic.getLatestPostDate()#</a>
										<p class="bbp-topic-meta">
											<span class="bbp-topic-freshness-author"><a href="#buildURL(action='profile', queryString='userid=#local.stickyTopic.getLatestPostedUser().userid#')#" title="View #local.stickyTopic.getLatestPostedUser().username#'s profile" class="bbp-author-avatar" rel="nofollow"><img alt="" src="#local.stickyTopic.getLatestPostedUser().image#" class="avatar avatar-14 photo"></a>&nbsp;<a href="#buildURL(action='profile', queryString='userid=#local.stickyTopic.getLatestPostedUser().userid#')#" title="View #local.stickyTopic.getLatestPostedUser().username#'s profile" class="bbp-author-name" rel="nofollow">#local.stickyTopic.getLatestPostedUser().username#</a></span>
										</p>
									</li>
								</ul>
							</cfloop>
						</cfif>
						<cfset local.topicCount = 1>
						<cfloop array="#rc.topics#" index="local.topic">
							<cfset local.topicCount ++>
							<cfif BitAnd(local.topicCount, 1)>
						        <cfset local.evenOrOdd = "odd">
						    <cfelse>
						        <cfset local.evenOrOdd = "even">
						    </cfif>
							<ul class="post-993 topic type-topic status-publish hentry odd bbp-parent-forum-965 user-id-1 instock">
								<li class="bbp-topic-title">
									<cfif local.topic.getIsLocked()>
										<i class="icon-lock"></i>
									<cfelse>
										<i class="icon-comment"></i>
									</cfif>
									<a class="bbp-topic-permalink" href="#buildURL(action='forum.topic', queryString='topicid=#local.topic.getForumTopicID()#')#" title="#local.topic.getTitle()#">#local.topic.getTitle()#</a>
									<p class="bbp-topic-meta">
										<span class="bbp-topic-started-by">Started by: <a href="#buildURL(action='profile', queryString='userid=#local.topic.getUser().getUserID()#')#" title="View #local.topic.getUser().getUsername()#'s profile" class="bbp-author-avatar" rel="nofollow"><img alt="" src="#local.topic.getUser().getProfile().getImage()#" class="avatar avatar-14 photo"></a>&nbsp;<a href="#buildURL(action='profile', queryString='userid=#local.topic.getUser().getUserID()#')#" title="View #local.topic.getUser().getUsername()#'s profile" class="bbp-author-name" rel="nofollow">#local.topic.getUser().getUsername()#</a></span>
									</p>
								</li>
								<li class="bbp-topic-voice-count">&nbsp;</li>
								<li class="bbp-topic-reply-count">#local.topic.getPostCount()#</li>
								<li class="bbp-topic-freshness">
									<a href="##">#local.topic.getLatestPostDate()#</a>
									<p class="bbp-topic-meta">
										<span class="bbp-topic-freshness-author"><a href="#buildURL(action='profile', queryString='userid=#local.topic.getLatestPostedUser().userid#')#" title="View #local.topic.getLatestPostedUser().username#'s profile" class="bbp-author-avatar" rel="nofollow"><img alt="" src="#local.topic.getLatestPostedUser().image#" class="avatar avatar-14 photo"></a>&nbsp;<a href="#buildURL(action='profile', queryString='userid=#local.topic.getLatestPostedUser().userid#')#" title="View #local.topic.getLatestPostedUser().username#'s profile" class="bbp-author-name" rel="nofollow">#local.topic.getLatestPostedUser().username#</a></span>
									</p>
								</li>
							</ul>
						</cfloop>
					</li>
					<li class="bbp-footer">
						<div class="tr">
							<p>
								<span class="td colspan4">&nbsp;</span>
							</p>
						</div>
						<!-- .tr -->
					</li>
				</ul>
				<!-- ##bbp-forum-965 -->
				<div class="bbp-pagination">
					<div class="bbp-pagination-count">
						Viewing Page #rc.currentPage# (of #rc.totalPages# total)
					</div>
					<div class="bbp-pagination-links">
						<cfif rc.start gt 1>
							<a href="#buildURL(action='forum.subcategory',queryString='subcategoryid=#rc.subcategoryid#&start=#rc.start-rc.pageSize#')#">Previous</a>
						</cfif>
						<cfif rc.start gt 1 OR rc.start+rc.pageSize-1 lt rc.topicsCount>
							<cfloop from="1" to="#rc.totalPages#" index="i">
								<cfset local.pageURL = i * 10 - 9>
								<cfif rc.start NEQ local.pageURL AND local.pageURL lte rc.topicsCount ><a href="#buildURL(action='forum.subcategory',queryString='subcategoryid=#rc.subcategoryid#&start=#local.pageURL#')#">#i#</a></cfif>
							</cfloop>
						</cfif>
						<cfif rc.start+rc.pageSize-1 lt rc.topicsCount>
							<a href="#buildURL(action='forum.subcategory',queryString='subcategoryid=#rc.subcategoryid#&start=#rc.start+rc.pageSize#')#">Next</a>
						</cfif>
					</div>
				</div>
				<cfif !session.user.isLoggedIn>
					<div id="no-topic-0" class="bbp-no-topic">
						<div class="bbp-template-notice">
							<p>You must be logged in to create new topics.</p>
						</div>
					</div>
				<cfelse>
					<div id="no-topic-0" class="bbp-no-topic">
						<a href="#buildURL(action='forum.newTopic',queryString='subcategoryid=#rc.subcategoryid#')#">
							<input class="button-small" type="button" value="New Topic">
						</a>
					</div>
				</cfif>
			</div>
			<div class="clear"></div>
		</div>
	</div>
</cfoutput>