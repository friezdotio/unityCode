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
		<div class="block block-tabs_block span8 cf">
			<div class="block block-text_block span12 first cf">
				<div class="title-wrapper">
					<h3 class="widget-title">All Tags</h3>
					<div class="clear"></div>
				</div>
				<div class="wcontainer">
					<div class="tagcloud">
						<cfloop array="#rc.tags#" index="local.tag">
							<a href="#buildURL(action='talk.tag',queryString='tag=#local.tag.getName()#')#">#local.tag.getName()#</a>
						</cfloop>
					</div>
					<div class="clear">&nbsp;</div>
				</div>
			</div>
			<div class="block block-text_block span12 first cf">
				<div class="title-wrapper">
					<h3 class="widget-title">Popular Tags</h3>
					<div class="clear"></div>
				</div>
				<div class="wcontainer">
					<div class="tagcloud">
						<cfloop array="#rc.popularTags#" index="local.tag">
							<a href="#buildURL(action='talk.tag',queryString='tag=#local.tag#')#">#local.tag#</a>
						</cfloop>
					</div>
					<div class="clear">&nbsp;</div>
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
