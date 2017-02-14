<cfoutput>
	<style>
		input.password {
		    -webkit-text-security: disc;
		}
	</style>
	<div class="row">
		<div class="span12 block-title centered">
			<h2>Edit Settings</h2>
			<p><a href="#buildURL('user.dashboard')#">Back to Dashboard</a></p>
		</div>
		<div class="span12 block-divider"></div>
		<div class="span12">
			<form action="#buildURL('user.save')#" id="signupForm" class="contact" method="post" novalidate="novalidate">
				<div class="template-wrapper">
					<div class="block block-contactform_block span7 first cf">
						<div class="title-wrapper">
							<h3 class="widget-title">EDIT ACCOUNT</h3>
							<div class="clear"></div>
						</div>
						<div class="mcontainer">
	                         <ul class="contactform controls">
		                         <li class="input-prepend">
		                             <input type="text" placeholder="Email*" name="email" id="email" value="#rc.user.getEmail()#" class="required requiredField email" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="password" placeholder="New Password*" name="password" id="password" value="" class="required requiredField password" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="password" placeholder="Confirm Password*" name="password2" id="password2" value="" class="required requiredField password" style="width:95%;">
		                         </li>
		                         <li>
		                             <input type="submit" class="button-green button-small" style="width:100%;margin:0;" value="Save">
		                         </li>
	                     	</ul>
						</div>
					</div>
					<div class="block block-column_block span5  cf">
						<div class="block block-text_block span5 first cf">
							<div class="title-wrapper">
								<h3 class="widget-title">Time Zone</h3>
								<div class="clear"></div>
							</div>
							<div class="wcontainer">
								<label for="categoryid">Select a Time Zone:</label>
								<select class="form-control" id="timezone" name="timezone">
									<option value="">- SELECT -</option>
									<cfloop array="#rc.timezones#" index="local.timezone">
										<option value="#local.timezone#" <cfif rc.user.getTimeZone() EQ local.timezone>selected="selected"</cfif>>#local.timezone#</option>
									</cfloop>
								</select>
							</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
			</form>
		</div>
	</div>
</cfoutput>