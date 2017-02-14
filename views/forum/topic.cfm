<cfoutput>
	<!--- <cfdump var="#rc.topic#" abort="true"> --->
	<div class="row">
		<div class="span12">
			<div id="bbpress-forums">
				<div class="bbp-template-notice info">
					<p class="bbp-topic-description"><a href="#buildURL('forum')#">#rc.topic.getForumSubCategory().getForumCategory().getLabel()#</a> / <a href="#buildURL(action='forum.subcategory', queryString='subcategoryid=#rc.topic.getForumSubCategory().getForumSubCategoryID()#')#">#rc.topic.getForumSubCategory().getLabel()#</a> / #rc.topic.getTitle()#</p>
				</div>
				<ul id="topic-993-replies" class="forums bbp-replies">
					<h1>#rc.topic.getTitle()#</h1>
					<li class="bbp-header">
						<div class="bbp-reply-author">Author</div>
						<!-- .bbp-reply-author -->
						<div class="bbp-reply-content">
							Posts
						</div>
						<!-- .bbp-reply-content -->
					</li>
					<cfif rc.start EQ 1>
						<!-- .bbp-header -->
						<li class="bbp-body">
							<div class="bbp-reply-header">
								<div class="bbp-meta">
									<span class="bbp-reply-post-date">#DateTimeFormat(rc.topic.getLocalCreated(), "MMMMM dd, yyyy 'at' hh:nn tt")#</span>
									<a href="##" class="bbp-reply-permalink">TOPIC</a>
									<span class="bbp-admin-links">
										<cfif rc.isAdmin OR rc.topic.getUser().getUserID() EQ session.user.userid>
											<a href="#buildURL(action='forum.deleteTopic',queryString='topicid=#rc.topicid#')#">Delete Topic</a> | <a href="#buildURL(action='forum.newTopic',queryString='topicid=#rc.topicid#')#">Edit Topic</a> <cfif rc.isAdmin>| <cfif !rc.topic.getIsLocked()><a href="#buildURL(action='forum.lockTopic',queryString='topicid=#rc.topicid#&lock=true')#">Lock Topic</a><cfelse><a href="#buildURL(action='forum.lockTopic',queryString='topicid=#rc.topicid#&lock=false')#">Unlock Topic</a><</cfif> | <cfif !rc.topic.getIsSticky()><a href="#buildURL(action='forum.stickyTopic',queryString='topicid=#rc.topicid#&stick=true')#">Sticky Topic</a><cfelse><a href="#buildURL(action='forum.stickyTopic',queryString='topicid=#rc.topicid#&stick=false')#">Unsticky Topic</a></cfif></cfif>
										</cfif>
									</span>
								</div>
								<!-- .bbp-meta -->
							</div>
							<!-- ##post-993 -->
							<div class="topic-1 topic type-topic status-publish hentry even">
								<div class="bbp-reply-author">
									<a href="#buildURL(action='profile',queryString='userid=#rc.topic.getUser().getUserID()#')#" title="View #rc.topic.getUser().getUsername()#'s profile" class="bbp-author-avatar" rel="nofollow"><img alt="" src="#rc.topic.getUser().getProfile().getImage()#" class="avatar avatar-80 photo"></a><br><a href="#buildURL(action='profile',queryString='userid=#rc.topic.getUser().getUserID()#')#" title="View #rc.topic.getUser().getUsername()#'s profile" class="bbp-author-name" rel="nofollow">#rc.topic.getUser().getUsername()#</a><br>
									<div class="bbp-author-role">#rc.topic.getUser().getPackage().getName()#</div>
								</div>
								<!-- .bbp-reply-author -->
								<div class="bbp-reply-content">
									#rc.topic.getBody()#
								</div>
								<!-- .bbp-reply-content -->
							</div>
							<!-- .reply -->
						</li>
						<!-- .bbp-body -->
					</cfif>
					<cfset local.postCount = 1>
					<cfloop array="#rc.posts#" index="local.post">
						<cfset local.postCount ++>
						<cfif local.post.getIsActive()>
							<li class="bbp-body">
								<div class="bbp-reply-header">
									<div class="bbp-meta">
										<span class="bbp-reply-post-date">#DateTimeFormat(local.post.getLocalCreated(), "MMMMM dd, yyyy 'at' hh:nn tt")#</span>
										<a href="##post-#local.postCount + rc.postNumber#" class="bbp-reply-permalink">###local.postCount + rc.postNumber#</a>
										<span class="bbp-admin-links">
											<cfif rc.isAdmin OR local.post.getUser().getUserID() EQ session.user.userid>
												<a href="#buildURL(action='forum.deletePost',queryString='postid=#local.post.getForumPostID()#')#">Delete Post</a> | <a href="#buildURL(action='forum.newPost',queryString='postid=#local.post.getForumPostID()#')#">Edit Post</a>
											</cfif>
										</span>
									</div>
									<!-- .bbp-meta -->
								</div>
								<!-- ##post-993 -->
								<div id="post-#local.post.getForumPostID()#" class="post-#local.postCount + rc.postNumber# post type-topic status-publish hentry odd ">
									<div class="bbp-reply-author">
										<a href="#buildURL(action='profile',queryString='userid=#rc.topic.getUser().getUserID()#')#" title="View #rc.topic.getUser().getUsername()#'s profile" class="bbp-author-avatar" rel="nofollow"><img alt="" src="#local.post.getUser().getProfile().getImage()#" class="avatar avatar-80 photo"></a><br><a href="#buildURL(action='profile',queryString='userid=#rc.topic.getUser().getUserID()#')#" title="View #rc.topic.getUser().getUsername()#'s profile" class="bbp-author-name" rel="nofollow">#local.post.getUser().getUsername()#</a><br>
										<div class="bbp-author-role">#local.post.getUser().getPackage().getName()#</div>
									</div>
									<!-- .bbp-reply-author -->
									<div class="bbp-reply-content">
										#local.post.getBody()#
									</div>
									<!-- .bbp-reply-content -->
								</div>
								<!-- .reply -->
							</li>
							<!-- .bbp-body -->
						</cfif>
					</cfloop>
					<li class="bbp-footer">
						<div class="bbp-reply-author">Author</div>
						<div class="bbp-reply-content">
							Posts
						</div>
						<!-- .bbp-reply-content -->
					</li>
					<!-- .bbp-footer -->
				</ul>
				<!-- ##topic-993-replies -->
				<div class="bbp-pagination">
					<div class="bbp-pagination-count">
						Viewing Page #rc.currentPage# (of #rc.totalPages# total)
					</div>
					<div class="bbp-pagination-links">
						<cfif rc.start gt 1>
							<a href="#buildURL(action='forum.topic',queryString='topicid=#rc.topicid#&start=#rc.start-rc.pageSize#')#">Previous</a>
						</cfif>
						<cfif rc.start gt 1 OR rc.start+rc.pageSize-1 lt rc.postsCount>
							<cfloop from="1" to="#rc.totalPages#" index="i">
								<cfset local.pageURL = i * 10 - 9>
								<cfif rc.start NEQ local.pageURL AND local.pageURL lte rc.postsCount ><a href="#buildURL(action='forum.topic',queryString='topicid=#rc.topicid#&start=#local.pageURL#')#">#i#</a></cfif>
							</cfloop>
						</cfif>
						<cfif rc.start+rc.pageSize-1 lt rc.postsCount>
							<a href="#buildURL(action='forum.topic',queryString='topicid=#rc.topicid#&start=#rc.start+rc.pageSize#')#">Next</a>
						</cfif>
					</div>
				</div>
				<cfif !session.user.isLoggedIn OR rc.topic.getIsLocked()>
					<div id="no-reply" class="bbp-no-reply">
						<cfif !session.user.isLoggedIn>
							<div class="bbp-template-notice">
								<p>You must be logged in to reply to this topic.</p>
							</div>
						<cfelse>
							<div class="bbp-template-notice">
								<p>This topic is currently locked.</p>
							</div>
						</cfif>
					</div>
				<cfelse>
					<div class="clear"></div>
					<div id="no-reply" class="bbp-no-reply" style="padding-left:40px;padding-right:40px;">
						<form method="post" action="#buildURL('forum.savePost')#">
						    <textarea name="content"></textarea>
						    <input type="hidden" name="topicid" value="#rc.topicid#">
							<input class="button-small"value="Post Reply" type="submit">
						</form>
					</div>
				</cfif>
				<div class="clear"></div>
			</div>
		</div>
	</div>
	<cfhtmlhead
	    text='
		    <script type="text/javascript">
				tinymce.init({
				    selector: "textarea",
				    menubar: "",
				    statusbar: false,
				    plugins: [
				        "advlist autolink lists link image charmap preview anchor",
				        "insertdatetime media table contextmenu paste"
				    ],
				    toolbar: "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image media"
				});
			</script>
		'>
</cfoutput>
