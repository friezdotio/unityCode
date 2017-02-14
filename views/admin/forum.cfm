<cfoutput>
	<div class="row">
		<div class="span12">
			<div class="template-wrapper">
				<div class="block span12 first cf">
					<div class="span12 block-title centered">
						<h2>#rc.pageTitle#</h2>
						<p>Manage Forum Categories and Subcategories</p>
					</div>
					<div class="span12 block-divider"></div>
				</div>
				<a href="#buildURL('admin.forumCategory')#">
					<input class="button-medium" type="button" value="New Category" style="margin-bottom:10px;">
				</a>
				<div id="block-4" class="block block-tabs_block span12 first cf">
					<cfloop array="#rc.categories#" index="local.category">
						<div class="title-wrapper">
							<h3 class="widget-title">#local.category.getLabel()# | <cfif local.category.getIsActive()>Active<cfelse>Inactive</cfif></h3>
							<div class="clear"></div>
						</div>
						<div id="block_tabs_75" class="block_tabs ui-tabs ui-widget ui-widget-content ui-corner-all">
							<a href="#buildURL(action='admin.forumCategory',queryString='categoryid=#local.category.getForumCategoryID()#')#">
								<input class="button-small" type="button" value="Edit Category" style="margin-bottom:10px;margin-left:10px;float:right;">
							</a>
							<a href="#buildURL(action='admin.forumSubcategory',queryString='categoryid=#local.category.getForumCategoryID()#')#">
								<input class="button-small" type="button" value="New Subcategory" style="margin-bottom:10px;float:right;">
							</a>
							<table class="table table-striped table-bordered">
								<thead>
									<tr>
										<th>Label</th>
										<th>Description</th>
										<th>Status</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<cfloop array="#local.category.getForumSubCategories()#" index="local.subcategory">
										<tr>
											<td>#local.subcategory.getLabel()#</td>
											<td>#local.subcategory.getDescription()#</td>
											<td><cfif local.subcategory.getIsActive()>Active<cfelse>Inactive</cfif></td>
											<td><a href="#buildURL(action='admin.forumSubcategory',queryString='subcategoryid=#local.subcategory.getForumSubCategoryID()#')#">Edit</a></td>
										</tr>
									</cfloop>
								</tbody>
							</table>
						</div>
					</cfloop>
				</div>
			</div>
		</div>
	</div>
</cfoutput>
