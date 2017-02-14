<cfoutput>
	<div class="row">
		<div class="span12 block-title centered">
			<h2>#rc.pageTitle#</h2>
			<p><a href="#buildURL('admin.forum')#">Back to Forum Admin</a></p>
		</div>
		<div class="span12 block-divider"></div>
		<form action="#buildURL('admin.saveCategory')#" id="categoryForm" class="contact" method="post" novalidate="novalidate">
			<div class="span12">
				<div class="template-wrapper">
					<div class="block block-contactform_block span7 first cf">
						<div class="title-wrapper">
							<h3 class="widget-title">CATEGORY DETAILS</h3>
							<div class="clear"></div>
						</div>
						<div class="mcontainer">
	                         <ul class="contactform controls">
		                         <li class="input-prepend">
		                             <input type="text" name="label" placeholder="Label*" id="label" value="#rc.label#" class="required requiredField" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="text" name="description" placeholder="Description*" id="description" value="#rc.description#" class="required requiredField" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="text" name="order" placeholder="Order*" id="description" value="#rc.order#" class="required requiredField" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <div class="checkbox">
									 	<label><input type="checkbox" value="true" name="isActive" <cfif len(rc.isActive) AND rc.isActive>checked="checked"</cfif>>Active</label>
									</div>
		                         </li>
		                         <li>
			                         <cfif structKeyExists(rc, "categoryid")>
			                         	<input type="hidden" name="categoryid" value="#rc.categoryid#">
			                         </cfif>
		                             <input type="submit" class="button-green button-small" style="margin:0;" value="Save Category">
		                         </li>
	                     	</ul>
						</div>
					</div>
					<div class="block block-column_block span5  cf">
						<div class="block block-text_block span5 first cf">
							<div class="title-wrapper">
								<h3 class="widget-title">Permissions</h3>
								<div class="clear"></div>
							</div>
							<div class="wcontainer">
								<cfloop array="#rc.permissions#" index="local.permission">
									<div class="checkbox">
									 	<label><input type="checkbox" value="#local.permission.getPermissionID()#" name="permissions" <cfif len(rc.permissionIDs) AND ArrayContains(rc.permissionIDs, local.permission.getPermissionID())>checked="checked"</cfif>>#local.permission.getName()#</label>
									</div>
								</cfloop>
							</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
</cfoutput>
