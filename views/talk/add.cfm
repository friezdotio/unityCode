<style>
	.bootstrap-tagsinput{
		width: 80%;
	}
</style>
<cfoutput>
	<div class="row">
		<div class="span12 block-title centered">
			<h2>#rc.pageTitle#</h2>
			<p><a href="#buildURL('talk')#">Back to Talks</a></p>
		</div>
		<div class="span12 block-divider"></div>
		<form action="#buildURL('talk.save')#" id="subCategoryForm" class="contact" method="post" novalidate="novalidate" enctype="multipart/form-data">
			<div class="span12">
				<div class="template-wrapper">
					<div class="block block-contactform_block span7 first cf">
						<div class="title-wrapper">
							<h3 class="widget-title">TALK DETAILS</h3>
							<div class="clear"></div>
						</div>
						<div class="mcontainer">
	                         <ul class="contactform controls">
		                         <li class="input-prepend">
		                             <input type="text" name="title" placeholder="Title*" id="title" value="#rc.title#" class="required requiredField" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <input type="text" name="shortDescription" placeholder="Short Description*" id="shortDescription" value="#rc.shortDescription#" class="required requiredField" style="width:95%;">
		                         </li>
		                         <li class="input-prepend">
		                             <textarea style="height:200px;" name="description" placeholder="Detailed Description*" id="description">#rc.description#</textarea>
		                         </li>
		                         <li>
			                         <cfif structKeyExists(rc, "talkid")>
			                         	<input type="hidden" name="talkid" value="#rc.talkid#">
			                         </cfif>
		                             <input type="submit" class="button-green button-small" style="margin:0;" value="Save Talk">
		                         </li>
	                     	</ul>
						</div>
					</div>
					<div class="block block-column_block span5  cf">
						<div class="block block-text_block span5 first cf">
							<div class="title-wrapper">
								<h3 class="widget-title">START DATE</h3>
								<div class="clear"></div>
							</div>
							<div class="wcontainer">
								<input id="datetime12" data-format="MM-DD-YYYY h:mm a" data-template="MM / DD / YYYY  hh : mm a" name="start" value="#dateFormat(rc.start, "mm-dd-yyyy")# #timeFormat(rc.start, "hh:mm tt")#" type="text">
								<br>The time and date you want your talk to start.
							</div>
						</div>
					</div>
					<div class="block block-column_block span5  cf">
						<div class="block block-text_block span5 first cf">
							<div class="title-wrapper">
								<h3 class="widget-title">FEATURED IMAGE</h3>
								<div class="clear"></div>
							</div>
							<div class="wcontainer">
								<cfif len(rc.image)>
									<img src="#rc.image#" width="100px"><br>
								</cfif>
								<input name="image" class="btn" type="file" />
								<p>Please upload an 817x320 PNG or JPG.</p>
							</div>
						</div>
					</div>
					<div class="block block-column_block span5  cf">
						<div class="block block-text_block span5 first cf">
							<div class="title-wrapper">
								<h3 class="widget-title">TAGs</h3>
								<div class="clear"></div>
							</div>
							<div class="wcontainer">
								<input type="text" value="#rc.tags#" id="tags" name="tags" data-role="tagsinput" />
								<br>Please enter at least three tags.<br>Seperate tags with commas.
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
	jQuery(function(){
	    jQuery('#datetime12').combodate();
	});

	var data = <cfoutput>#rc.tagsJSON#</cfoutput>;

	var tags = new Bloodhound({
	  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
	  queryTokenizer: Bloodhound.tokenizers.whitespace,
	  local: jQuery.map(data, function (tag) {
	        return {
	            name: tag
	        };
	    })
	});
	tags.initialize();

	jQuery('#tags').tagsinput({
	  typeaheadjs: {
	    name: 'tags',
	    displayKey: 'name',
	    valueKey: 'name',
	    source: tags.ttAdapter()
	  }
	});
</script>
