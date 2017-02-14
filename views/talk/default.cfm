<cfoutput>
	<div class="row">
		<div class="span12">
			<div class="template-wrapper">
				<div class="span12 block-title centered">
					<h2>#rc.pageTitle#</h2>
					<p>#rc.pageDescription#</p>
				</div>
				<div class="span12 block-divider"></div>
			</div>
		</div>
		<div class="block block-tabs_block span8  cf">
			<div id="block_tabs_68" class="block_tabs ui-tabs ui-widget ui-widget-content ui-corner-all">
				<div class="tab-inner">
					<ul role="tablist" class="nav cf nav-tabs ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
						<li aria-selected="true" aria-labelledby="ui-id-1" aria-controls="tab-upcoming" tabindex="0" role="tab" class="ui-tabs-active ui-state-default ui-corner-top ui-state-active"><a id="ui-id-1" tabindex="-1" role="presentation" class="ui-tabs-anchor" href="##tab-upcoming">Upcoming</a></li>
						<li aria-selected="false" aria-labelledby="ui-id-2" aria-controls="tab-popular" tabindex="-1" role="tab" class="ui-state-default ui-corner-top"><a id="ui-id-2" tabindex="-1" role="presentation" class="ui-tabs-anchor" href="##tab-popular">Popular</a></li>
						<li aria-selected="false" aria-labelledby="ui-id-2" aria-controls="tab-past" tabindex="-1" role="tab" class="ui-state-default ui-corner-top"><a id="ui-id-2" tabindex="-1" role="presentation" class="ui-tabs-anchor" href="##tab-past">Past</a></li>
					</ul>
					<div aria-hidden="true" aria-expanded="true" style="display:block;background-color:transparent;margin:0;padding:0;padding-top:10px;" role="tabpanel" aria-labelledby="ui-id-1" id="tab-upcoming" class="tab tab-content ui-tabs-panel ui-widget-content ui-corner-bottom">
						<cfloop array="#rc.upcomingTalks#" index="local.talk">
							<div class="blog-post">
								<div class="blog-image right">
									<a href="#buildURL(action='talk.view', queryString='talkid=#local.talk.getTalkID()#')#"><img src="#local.talk.getImage()#" class="attachment-817x320 wp-post-image"></a>
									<div class="blog-date">
										<span class="date">#dateFormat(local.talk.getLocalStart(),"mmm-dd")#<br>#timeFormat(local.talk.getLocalStart(),"hh:mm tt")#</span>
										<!--- <div class="plove"><a href="##" class="heart-love" id="heart-love-499" title="Love this"><span class="heart-love-count"><span class="icon-heart"></span>56</span></a></div> --->
									</div>
									<!--- <div class="blog-rating">
										<div class="overall-score">
											<div class="rating r-45"></div>
										</div>
									</div> --->
									<!-- blog-rating -->
								</div>
								<!-- blog-image -->
								<div class="blog-content ">
									<h2><a href="#buildURL(action='talk.view', queryString='talkid=#local.talk.getTalkID()#')#"> #local.talk.getTitle()# </a></h2>
									<p>#local.talk.getShortDescription()#</p>
								</div>
								<!-- blog-content -->
								<div class="blog-info">
									<div class="post-pinfo">
										<span class="icon-user"></span> <a href="#buildURL(action='profile',queryString='userid=#local.talk.getPresenter().getUserID()#')#">#local.talk.getPresenter().getUsername()#</a>&nbsp;
										<!--- <span class="icon-comment"></span>  <a data-original-title="3 Comments" href="##" data-toggle="tooltip">3 Comments</a> &nbsp; --->
										<span class="icon-tags"></span> <cfloop array="#local.talk.getTags()#" index="local.tag"><a href="#buildURL(action='talk.tag',queryString='tag=#local.tag.getName()#')#">#local.tag.getName()#</a> </cfloop>
									</div>
									<!-- post-pinfo -->
									<a href="#buildURL(action='talk.view', queryString='talkid=#local.talk.getTalkID()#')#" class="button-small">Read more</a>
									<div class="clear"></div>
								</div>
								<!-- blog-info -->
							</div>
							<!-- /.blog-post -->
							<div class="block-divider"></div>
						</cfloop>
						<div class="pagination">
							<ul>
								<cfif rc.start gt 1>
									<li><a href="#buildURL(action='talk',queryString='topicid=#rc.topicid#&start=#rc.start-rc.pageSize###tab-upcoming')#" class="page-selector">«</a></li>
								</cfif>
								<cfif rc.start gt 1 OR rc.start+rc.pageSize-1 lt rc.upcomingTalksCount>
									<cfloop from="1" to="#rc.upcomingTalksTotalPages#" index="i">
										<cfset local.pageURL = i * 10 - 9>
										<cfif rc.start NEQ local.pageURL AND local.pageURL lte rc.upcomingTalksCount ><li><a href="#buildURL(action='talk',queryString='topicid=#rc.topicid#&start=#local.pageURL###tab-upcoming')#" class="inactive">#i#</a></li></cfif>
									</cfloop>
								</cfif>
								<cfif rc.start+rc.pageSize-1 lt rc.upcomingTalksCount>
									<li><a href="#buildURL(action='talk',queryString='topicid=#rc.topicid#&start=#rc.start+rc.pageSize###tab-upcoming')#" class="page-selector">»</a></li>
								</cfif>
							</ul>
						</div>
						<div class="clear"></div>
					</div>
					<div aria-hidden="true" aria-expanded="false" style="display:block;background-color:transparent;margin:0;padding:0;padding-top:10px;" role="tabpanel" aria-labelledby="ui-id-2" id="tab-popular" class="tab tab-content ui-tabs-panel ui-widget-content ui-corner-bottom">
						<cfloop array="#rc.popularTalks#" index="local.talk">
							<div class="blog-post">
								<div class="blog-image right">
									<a href="#buildURL(action='talk.view', queryString='talkid=#local.talk.getTalkID()#')#"><img src="#local.talk.getImage()#" class="attachment-817x320 wp-post-image"></a>
									<div class="blog-date">
										<span class="date">#dateFormat(local.talk.getLocalStart(),"mmm-dd")#<br>#timeFormat(local.talk.getLocalStart(),"hh:mm tt")#</span>
										<!--- <div class="plove"><a href="##" class="heart-love" id="heart-love-499" title="Love this"><span class="heart-love-count"><span class="icon-heart"></span>56</span></a></div> --->
									</div>
									<!--- <div class="blog-rating">
										<div class="overall-score">
											<div class="rating r-45"></div>
										</div>
									</div> --->
									<!-- blog-rating -->
								</div>
								<!-- blog-image -->
								<div class="blog-content ">
									<h2><a href="#buildURL(action='talk.view', queryString='talkid=#local.talk.getTalkID()#')#"> #local.talk.getTitle()# </a></h2>
									<p>#local.talk.getShortDescription()#</p>
								</div>
								<!-- blog-content -->
								<div class="blog-info">
									<div class="post-pinfo">
										<span class="icon-user"></span> <a href="#buildURL(action='profile',queryString='userid=#local.talk.getPresenter().getUserID()#')#">#local.talk.getPresenter().getUsername()#</a>&nbsp;
										<!--- <span class="icon-comment"></span>  <a data-original-title="3 Comments" href="##" data-toggle="tooltip">3 Comments</a> &nbsp; --->
										<span class="icon-tags"></span> <cfloop array="#local.talk.getTags()#" index="local.tag"><a href="#buildURL(action='talk.tag',queryString='tag=#local.tag.getName()#')#">#local.tag.getName()#</a> </cfloop>
									</div>
									<!-- post-pinfo -->
									<a href="#buildURL(action='talk.view', queryString='talkid=#local.talk.getTalkID()#')#" class="button-small">Read more</a>
									<div class="clear"></div>
								</div>
								<!-- blog-info -->
							</div>
							<!-- /.blog-post -->
							<div class="block-divider"></div>
						</cfloop>
						<div class="pagination">
							<ul>
								<cfif rc.start gt 1>
									<li><a href="#buildURL(action='talk',queryString='topicid=#rc.topicid#&start=#rc.start-rc.pageSize###tab-popular')#" class="page-selector">«</a></li>
								</cfif>
								<cfif rc.start gt 1 OR rc.start+rc.pageSize-1 lt rc.popularTalksCount>
									<cfloop from="1" to="#rc.popularTalksTotalPages#" index="i">
										<cfset local.pageURL = i * 10 - 9>
										<cfif rc.start NEQ local.pageURL AND local.pageURL lte rc.popularTalksCount ><li><a href="#buildURL(action='talk',queryString='topicid=#rc.topicid#&start=#local.pageURL###tab-popular')#" class="inactive">#i#</a></li></cfif>
									</cfloop>
								</cfif>
								<cfif rc.start+rc.pageSize-1 lt rc.popularTalksCount>
									<li><a href="#buildURL(action='talk',queryString='topicid=#rc.topicid#&start=#rc.start+rc.pageSize###tab-popula')#r" class="page-selector">»</a></li>
								</cfif>
							</ul>
						</div>
						<div class="clear"></div>
					</div>
					<div aria-hidden="true" aria-expanded="false" style="display:block;background-color:transparent;margin:0;padding:0;padding-top:10px;" role="tabpanel" aria-labelledby="ui-id-2" id="tab-past" class="tab tab-content ui-tabs-panel ui-widget-content ui-corner-bottom">
						<cfloop array="#rc.pastTalks#" index="local.talk">
							<div class="blog-post">
								<div class="blog-image right">
									<a href="#buildURL(action='talk.view', queryString='talkid=#local.talk.getTalkID()#')#"><img src="#local.talk.getImage()#" class="attachment-817x320 wp-post-image"></a>
									<div class="blog-date">
										<span class="date">#dateFormat(local.talk.getLocalStart(),"mmm-dd")#<br>#timeFormat(local.talk.getLocalStart(),"hh:mm tt")#</span>
										<!--- <div class="plove"><a href="##" class="heart-love" id="heart-love-499" title="Love this"><span class="heart-love-count"><span class="icon-heart"></span>56</span></a></div> --->
									</div>
									<!--- <div class="blog-rating">
										<div class="overall-score">
											<div class="rating r-45"></div>
										</div>
									</div> --->
									<!-- blog-rating -->
								</div>
								<!-- blog-image -->
								<div class="blog-content ">
									<h2><a href="#buildURL(action='talk.view', queryString='talkid=#local.talk.getTalkID()#')#"> #local.talk.getTitle()# </a></h2>
									<p>#local.talk.getShortDescription()#</p>
								</div>
								<!-- blog-content -->
								<div class="blog-info">
									<div class="post-pinfo">
										<span class="icon-user"></span> <a href="#buildURL(action='profile',queryString='userid=#local.talk.getPresenter().getUserID()#')#">#local.talk.getPresenter().getUsername()#</a>&nbsp;
										<!--- <span class="icon-comment"></span>  <a data-original-title="3 Comments" href="##" data-toggle="tooltip">3 Comments</a> &nbsp; --->
										<span class="icon-tags"></span> <cfloop array="#local.talk.getTags()#" index="local.tag"><a href="#buildURL(action='talk.tag',queryString='tag=#local.tag.getName()#')#">#local.tag.getName()#</a> </cfloop>
									</div>
									<!-- post-pinfo -->
									<a href="#buildURL(action='talk.view', queryString='talkid=#local.talk.getTalkID()#')#" class="button-small">Read more</a>
									<div class="clear"></div>
								</div>
								<!-- blog-info -->
							</div>
							<!-- /.blog-post -->
							<div class="block-divider"></div>
						</cfloop>
						<div class="pagination">
							<ul>
								<cfif rc.start gt 1>
									<li><a href="#buildURL(action='talk',queryString='topicid=#rc.topicid#&start=#rc.start-rc.pageSize###tab-past')#" class="page-selector">«</a></li>
								</cfif>
								<cfif rc.start gt 1 OR rc.start+rc.pageSize-1 lt rc.pastTalksCount>
									<cfloop from="1" to="#rc.pastTalksTotalPages#" index="i">
										<cfset local.pageURL = i * 10 - 9>
										<cfif rc.start NEQ local.pageURL AND local.pageURL lte rc.pastTalksCount ><li><a href="#buildURL(action='talk',queryString='topicid=#rc.topicid#&start=#local.pageURL###tab-past')#" class="inactive">#i#</a></li></cfif>
									</cfloop>
								</cfif>
								<cfif rc.start+rc.pageSize-1 lt rc.pastTalksCount>
									<li><a href="#buildURL(action='talk',queryString='topicid=#rc.topicid#&start=#rc.start+rc.pageSize###tab-popula')#r" class="page-selector">»</a></li>
								</cfif>
							</ul>
						</div>
						<div class="clear"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.span8 -->
		<div class="span4 ">
			#view('talk/sidebar')#
		</div>
		<!-- /.span4 -->
	</div>
</cfoutput>
