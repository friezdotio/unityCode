<cfoutput>
	<style>
		input.password {
		    -webkit-text-security: disc;
		}
	</style>
	<div class="row">
		<div class="span12 block-title centered">
			<h2>howdy there</h2>
			<p>Signing up is totally free!</p>
		</div>
		<div class="span12 block-divider"></div>
		<div class="span12">
			<div class="template-wrapper">
				<div class="block block-contactform_block span7 first cf">
					<div class="title-wrapper">
						<h3 class="widget-title">SIGN UP FORM</h3>
						<div class="clear"></div>
					</div>
					<form action="#buildURL('user.signupSubmit')#" id="signupForm" class="contact" method="post" novalidate="novalidate">
						<div class="mcontainer">
	                         <ul class="contactform controls">
		                         <li class="input-prepend">
		                             <input type="text" name="username" placeholder="Username*" id="username" value="#rc.username#" class="required requiredField" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="text" placeholder="Email*" name="email" id="email" value="#rc.email#" class="required requiredField email" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="password" placeholder="Password*" name="password" id="password" value="" class="required requiredField password" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="password" placeholder="Confirm Password*" name="password2" id="password2" value="" class="required requiredField password" style="width:95%;">
		                         </li>
		                         <li>
		                             <input type="submit" class="button-green button-small" style="width:100%;margin:0;" value="Sign Up">
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
											<option value="#local.timezone#" <cfif rc.timezone EQ local.timezone>selected="selected"</cfif>>#local.timezone#</option>
										</cfloop>
									</select>
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