<cfoutput>
	<style>
		input.password {
		    -webkit-text-security: disc;
		}
	</style>
	<div class="row">
		<div class="span12 block-title centered">
			<h2>Edit Profile</h2>
			<p><a href="#buildURL('user.dashboard')#">Back to Dashboard</a></p>
		</div>
		<div class="span12 block-divider"></div>
		<div class="span12">
			<form action="#buildURL('profile.update')#" id="signupForm" class="contact" method="post" novalidate="novalidate" enctype="multipart/form-data">
				<div class="template-wrapper">
					<div class="block block-contactform_block span7 first cf">
						<div class="title-wrapper">
							<h3 class="widget-title">PROFILE DETAILS</h3>
							<div class="clear"></div>
						</div>
						<div class="mcontainer">
	                         <ul class="contactform controls">
		                         <li class="input-prepend">
		                             <input type="text" placeholder="Full Name" name="fullName" id="fullName" value="#rc.profile.getFullName()#" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="text" placeholder="Location" name="location" id="location" value="#rc.profile.getLocation()#" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="text" placeholder="Website" name="website" id="website" value="#rc.profile.getWebsite()#" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="text" placeholder="About Me" name="aboutMe" id="aboutMe" value="#rc.profile.getAboutMe()#" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="text" placeholder="Facebook" name="facebook" id="facebook" value="#rc.profile.getFacebook()#" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="text" placeholder="Twitter" name="twitter" id="twitter" value="#rc.profile.getTwitter()#" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="text" placeholder="Linkedin" name="linkedin" id="linkedin" value="#rc.profile.getLinkedin()#" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="text" placeholder="Google" name="google" id="google" value="#rc.profile.getGoogle()#" style="width:95%;">
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
								<h3 class="widget-title">USER ICON</h3>
								<div class="clear"></div>
							</div>
							<div class="wcontainer">
								<cfif len(rc.profile.getImage())>
									<img src="#rc.profile.getImage()#" width="100px"><br>
								</cfif>
								<input name="imageUpload" class="btn" type="file" />
								<p>Please upload an 100x100 PNG or JPG.</p>
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