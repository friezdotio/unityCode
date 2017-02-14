<cfoutput>
	<div class="container logo">
		<!-- Logo -->
		<a class="brand" href="#buildURL('main')#">
		<img src="/layouts/assets/img/logo.png" alt="logo"  />
		</a>
		<!-- End Logo -->
		<div class="clear"></div>
	</div>
	<!-- NAVBAR -->
	<div class="navbar navbar-inverse container">
		<div class="navbar-inner">
			<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<div class="nav-collapse collapse">
				<div class="menu-main-container">
					<ul class="nav">
						<li <cfif listFirst(rc.action, ".") EQ "main">class="current-menu-parent"</cfif>>
							<a href="#buildURL('main')#">Home</a>
						</li>
						<!--- COMING SOON
							<li><a href="#buildURL('main.about')#">About</a></li>
						--->
						<li <cfif listFirst(rc.action, ".") EQ "forum">class="current-menu-parent"</cfif>>
							<a href="#buildURL('forum')#">Forums</a>
						</li>
						<li <cfif listFirst(rc.action, ".") EQ "talk">class="current-menu-parent"</cfif>>
							<a href="#buildURL('talk')#">Talks</a>
						</li>
						<li <cfif listFirst(rc.action, ".") EQ "tag">class="current-menu-parent"</cfif>>
							<a href="#buildURL('tag')#">Tags</a>
						</li>
						<!--- COMING SOON
							<li><a href="#buildURL('projects')#">Projects</a></li>
						--->
						<!--- COMING SOON
							<li><a href="#buildURL('reviews')#">Code Reviews</a></li>
						--->
					</ul>
				</div>
				<cfif structKeyExists(session.user, "isLoggedIn") AND session.user.isLoggedIn>
					<a href="#buildURL('user.dashboard')#" role="button" class="account" title="Logged in as #rc.header.user.getUsername()#"><img src="/layouts/assets/img/account.png"></a>
				<cfelse>
					<a href="##myModalL" role="button" data-toggle="modal" class="account">LOGIN<!--- <img src="/layouts/assets/img/account.png"> ---></a>
				</cfif>
				<!--- COMING SOON
				<form method="post" id="header-searchform" action="#buildURL('main.search')#">
					<input autocomplete="off" value="" name="s" id="header-s" type="text">
					<input id="header-searchsubmit" value="Search" type="submit">
				</form> --->
			</div>
			<!--/.nav-collapse -->
		</div>
		<!-- /.navbar-inner -->
	</div>
	<div id="myModalL" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3>Login</h3>
		</div>
		<div class="modal-body">
			<div id="LoginWithAjax" class="default">
				<span id="LoginWithAjax_Status"></span>
				<form name="LoginWithAjax_FormHeader" id="LoginWithAjax_FormHeader" action="#buildURL('user.login')#" method="post">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tbody>
							<tr id="LoginWithAjax_Username">
								<td class="username_input">
									<input name="username" placeholder="Username" id="lwa_user_login" class="input" value="" type="text">
								</td>
							</tr>
							<tr id="LoginWithAjax_Password">
								<td class="password_input">
									<input name="password" placeholder="Password" id="lwa_user_pass" class="input" value="" type="password">
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
							</tr>
							<tr id="LoginWithAjax_Submit">
								<td id="LoginWithAjax_SubmitButton">
									<!--- <input name="rememberme" id="lwa_rememberme" value="forever" type="checkbox"> <label>Remember Me</label> --->
									<!--- <a href="##" title="Password Lost and Found">Lost your password?</a>
									<br><br> --->
									<input class="button-small"value="Log In" type="submit">
									<a class="reg-btn button-small" href="#buildURL('user.signup')#">Sign Up</a>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
</cfoutput>