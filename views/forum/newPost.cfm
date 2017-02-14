<cfoutput>
	<style>
		input.password {
		    -webkit-text-security: disc;
		}
	</style>
	<div class="row">
		<div class="span12 block-title centered">
			<h2>#rc.pageTitle#</h2>
			<p>#rc.title#</p>
		</div>
		<!--- <div class="span12 block-divider"></div> --->
		<div class="span12">
			<div class="template-wrapper">
				<div class="block block-contactform_block span12 first cf">
					<div class="mcontainer">
			  			<form action="#buildURL('forum.savePost')#" id="signupForm" class="contact" method="post" novalidate="novalidate">
	                         <ul class="contactform controls">
		                         <li class="input-prepend">
		                             <textarea name="content" style="height:200px;">#rc.content#</textarea>
		                         </li>
		                         <li>
			                         <cfif structKeyExists(rc, "postid")>
			                         	<input type="hidden" name="postid" value="#rc.postid#">
			                         </cfif>
	                     			 <input type="hidden" name="topicid" value="#rc.topicid#">
		                             <input type="submit" class="button-green button-small" style="margin:0;" value="Post Topic">
		                         </li>
	                     	</ul>
	                	</form>
					</div>
				</div>
			</div>
			<div class="clear"></div>
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