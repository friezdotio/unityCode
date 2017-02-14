<cfoutput>
	<div class="span12">
		<div class="template-wrapper">
			<div class="span12 block-title centered">
				<h2>#rc.pageTitle#</h2>
				<p><a href="#buildURL('talk')#">Back to All Talks</p>
			</div>
			<div class="span12 block-divider"></div>
		</div>
	</div>
	<div class="span8">
		<div class="blog-post">
			<div class="blog-image">
				<a href="##"><img src="#rc.talk.getImage()#" class="attachment-817x320 wp-post-image" alt="2" height="320" width="817"></a>
				<div class="blog-date">
					<span class="date">#dateFormat(rc.talk.getLocalStart(),"mmm-dd")#<br>#timeFormat(rc.talk.getLocalStart(),"hh:mm tt")#</span>
					<!--- <div class="plove"><a href="##" class="heart-love" id="heart-love-499" title="Love this"><span class="heart-love-count"><span class="icon-heart"></span>54</span></a></div> --->
				</div>
				<!--- <div class="blog-rating">
					<div class="overall-score">
						<div class="rating r-45"></div>
					</div>
				</div> --->
				<!-- blog-rating -->
			</div>
			<!-- blog-image -->
			<div style="padding-left:25px;">
				<h2>#rc.talk.getTitle()#</h2>
			</div>
			<!-- blog-content -->
			<div class="blog-info">
				<div class="post-pinfo">
					<span class="icon-user"></span> <a data-original-title="View all posts by admin" data-toggle="tooltip" href="#buildURL(action='profile',queryString='userid=#rc.talk.getPresenter().getUserID()#')#">#rc.talk.getPresenter().getUsername()#</a> &nbsp;
					<!--- <span class="icon-comment"></span>  <a data-original-title="3 Comments" href="##" data-toggle="tooltip">
					3 Comments</a> &nbsp; --->
					<cfif len(rc.recordings.url)><span class="icon-download"></span> <strong><a href="#rc.recordings.url#" target="_blank">View Recording</a></strong>&nbsp;&nbsp;</cfif>
					<span class="icon-tags"></span> <cfloop array="#rc.talk.getTags()#" index="local.tag"><a href="##">#local.tag.getName()#</a> </cfloop>
				</div>
				<div class="clear"></div>
			</div>
			<!-- /.blog-info -->
			<!-- post ratings -->
			<div class="post-review" style="background-color:transparent;">
				<cfif len(rc.actionButton.url)><a href="#buildURL(action=rc.actionButton.url, queryString=rc.actionButton.queryString)#"></cfif>
					<input type="button" class="button-green button-big" style="width:100%;" target="#rc.actionButton.target#" value="#rc.actionButton.value#">
				<cfif len(rc.actionButton.url)></a></cfif>
			</div>
			<!-- /post ratings -->
			<div class="blog-content">
				#rc.talk.getDescription()#
			</div>
			<!-- /.blog-content -->
			<div class="clear"></div>
		</div>
		<!-- /.blog-post -->
		<div class="clear"></div>
		<div class="block-divider"></div>
		<div class="author-block wcontainer">
			<img alt="" src="#rc.talk.getPresenter().getProfile().getImage()#" class="avatar avatar-250 photo" height="250" width="250">
			<div class="author-content">
				<h3>About #rc.talk.getPresenter().getUsername()#</h3>
				<p>#rc.talk.getPresenter().getProfile().getAboutMe()#</p>
			</div>
			<div class="clear"></div>
		</div>
		<!-- /author-block -->
		<!-- ##comments -->
	</div>
	<!-- /.span8 -->
	<div class="span4 ">
		#view('talk/sidebar')#
	</div>
	<!-- /.span4 -->
</cfoutput>
