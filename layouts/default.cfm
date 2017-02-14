<cfparam name="rc.pagetitle" default="united we code">
<cfoutput>
	<!doctype html>
	<html lang="en-US">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<meta charset="utf-8">
			<title>unityCode | #rc.pagetitle#</title>
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<meta name="description" content="">
			<meta name="keywords" content="">
			<link rel="shortcut icon" href="/layouts/assets/img/favicon.png">

			<!-- CSS -->
			<link rel="stylesheet" href="/layouts/assets/style.css">
			<link rel="stylesheet" href="/layouts/assets/css/layerslider.css">
			<link rel="stylesheet" href="/layouts/assets/css/bootstrap-tagsinput.css">
			<link rel="stylesheet" href="/layouts/assets/css/layerslider.css">
			<link rel="stylesheet" id="custom-style-css"  href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700italic,700,800,800italic" type="text/css" media="all" />

			<!-- JavaScript -->
			<script type="text/javascript" src="/layouts/assets/js/jquery.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/pb-view.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/jquery.cookie.pack.js"></script>
	        <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/jquery-migrate.min.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/jquery.fancybox.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/jquery.elastic.source.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/jquery.carouFredSel-6.2.1-packed.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/jquery.ui.totop.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/jquery.validate.min.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/login-with-ajax.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/bootstrap-button.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/bootstrap-carousel.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/bootstrap-collapse.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/bootstrap-modal.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/bootstrap-tab.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/bootstrap-tooltip.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/bootstrap-transition.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/bootstrap-popover.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/bootstrap-tagsinput.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/easing.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/global.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/imagescale.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/login-with-ajax.source.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/main.js"></script>
		 	<script type="text/javascript" src="/layouts/assets/js/theme.min.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/tinymce/tinymce.min.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/transit.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/admin.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/greensock.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/layerslider.transitions.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/layerslider.kreaturamedia.jquery.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/tabs.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/parallax.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/jquery-ui-tabs-min.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/moment.min.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/combodate.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/typeahead.js"></script>
			<script type="text/javascript" src="/layouts/assets/js/appear.js"></script>


		   <!-- End JavaScript -->
		</head>
		<body class="page page-id-26 page-template page-template-tmp-no-title-php">
			<div id="main_wrapper">
				#view('main/header')#
			</div>
			<div class="page normal-page container">
				<cfif structkeyexists(rc, "pageErrors") AND arrayLen(rc.pageErrors)>
					<div class="alert alert-danger fade in">
						<b>The following errors has occured:</b><br/>
					    <ul>
						    <cfloop index="local.error" array="#rc.pageErrors#">
						        <li>#local.error#</li>
						    </cfloop>
					    </ul>
					</div>
			 	</cfif>
			 	<cfif structkeyexists(rc, "pageSuccess")>
					<div class="alert alert-success fade in">
				  	 	<strong>Success!</strong> #rc.pageSuccess#
				 	</div>
			 	</cfif>
				#body#
			</div>
			<footer class="container">
				#view('main/footer')#
			</footer>
		</body>
	</html>
</cfoutput>

<script>
	jQuery("#datepicker").datepicker();
</script>


<!--- Used while I was debugging, will make it an option later so I can toggle an app var and show this
<cfif 0>
<br/><br/><br/>
<cfdump var="#rc#" label="RC" expand="false">
</cfif>
--->
