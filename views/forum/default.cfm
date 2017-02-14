<cfoutput>
	<div class="row">
		<div class="span12">
			<div id="bbpress-forums">
				<cfset local.catCount = 1>
				<cfloop array="#rc.categories#" index="local.category">
					<cfset local.catCount ++>
					<ul id="forums-list-0" class="bbp-forums">
						<li class="bbp-header">
							<ul class="forum-titles">
								<li class="bbp-forum-info">#local.category.getLabel()#</li>
								<li class="bbp-forum-topic-count">Topics</li>
								<li class="bbp-forum-reply-count">Posts</li>
								<li class="bbp-forum-freshness">Freshness</li>
							</ul>
						</li>
						<!-- .bbp-header -->
						<li class="bbp-body">
							<cfset local.subCatCount = 1>
							<cfloop array="#local.category.getActiveForumSubCategories()#" index="local.subcategory">
								<cfset local.subCatCount ++>
								<cfif BitAnd(local.subCatCount, 1)>
							        <cfset local.evenOrOdd = "odd">
							    <cfelse>
							        <cfset local.evenOrOdd = "even">
							    </cfif>
								<ul class="forum type-forum status-publish #local.evenOrOdd#">
									<li class="bbp-forum-info">
										<i class="icon-comments"></i>
										<a class="bbp-forum-title" href="#buildURL(action='forum.subcategory', queryString='subcategoryid=#local.subcategory.getForumSubCategoryID()#')#" title="#local.subcategory.getLabel()#">#local.subcategory.getLabel()#</a>
										<cfif len(local.subcategory.getDescription())>
											<div class="bbp-forum-content">
												<p>#local.subcategory.getDescription()#</p>
											</div>
										</cfif>
									</li>
									<li class="bbp-forum-topic-count">#local.subcategory.getTopicCount()#</li>
									<li class="bbp-forum-reply-count">#local.subcategory.getPostCount()#</li>
									<li class="bbp-forum-freshness">
										<a href="##">#local.subcategory.getLatestPostDate()#</a>
										<p class="bbp-topic-meta">
											<cfif local.subcategory.getLatestPostedUser().recordCount GT 0>
												<span class="bbp-topic-freshness-author"><a href="#buildURL(action='profile', queryString='userid=#local.subcategory.getLatestPostedUser().userid#')#" title="View #local.subcategory.getLatestPostedUser().username#'s profile" class="bbp-author-avatar" rel="nofollow">
												<img alt="" src="#local.subcategory.getLatestPostedUser().image#" class="avatar avatar-14 photo" height="14" width="14"></a>&nbsp;<a href="#buildURL(action='profile', queryString='userid=#local.subcategory.getLatestPostedUser().userid#')#" title="View #local.subcategory.getLatestPostedUser().username#'s profile" class="bbp-author-name" rel="nofollow">#local.subcategory.getLatestPostedUser().username#</a></span>
											<cfelse>
												No Topics Yet
											</cfif>
										</p>
									</li>
								</ul>
							</cfloop>
						</li>
						<!-- .bbp-body -->
						<li class="bbp-footer">
							<div class="tr">
								<p class="td colspan4">&nbsp;</p>
							</div>
							<!-- .tr -->
						</li>
						<!-- .bbp-footer -->
					</ul>
				</cfloop>
				<!-- .forums-directory -->
				<!--- <div class="bbp-search-form">
					<form role="search" method="get" id="bbp-search-form" action="##">
						<div>
							<label class="screen-reader-text hidden" for="bbp_search">Search for:</label>
							<input name="action" value="bbp-search-request" type="hidden">
							<input tabindex="101" value="" name="bbp_search" id="bbp_search" type="text">
							<input tabindex="102" class="button" id="bbp_search_submit" value="Search" type="submit">
						</div>
					</form>
				</div> --->
			</div>
			<div class="clear"></div>
		</div>
	</div>
</cfoutput>
