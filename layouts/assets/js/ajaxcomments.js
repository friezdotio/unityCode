// AJAX commenting system to fix everything, most information taken from http://www.makeuseof.com/tag/ajaxify-wordpress-comments/

if (typeof jQuery != 'undefined') {

jQuery('document').ready(function($){
var commentform=$('#commentform'); // find the comment form
commentform.prepend('<div id="comment-status" ></div>'); // add info panel before the form to provide feedback or errors
var statusdiv=$('#comment-status'); // define the infopanel

commentform.submit(function(){
//serialize and store form data in a variable
var formdata=commentform.serialize();
//Add a status message
statusdiv.html('<p class="alert alert-info">' + addict_script_vars.info +'</p>');
//Extract action URL from commentform
var formurl=commentform.attr('action');
//Post Form with data
$.ajax({
type: 'post',
url: formurl,
data: formdata,
error: function(XMLHttpRequest, textStatus, errorThrown){
var addict_script_vars = {"success":"Thanks for your comment. We appreciate your response.","error":"Please wait a while before posting your next comment!","error2":"You might have left one of the fields blank, or be posting too quickly!","info":"Processing..." };
statusdiv.html('<p class="wdpajax-error alert alert-error" >' + addict_script_vars.error2 +'</p>');
},
success: function(data, textStatus){
if(data=="success")
statusdiv.html('<p class="ajax-success alert alert-success" >' + addict_script_vars.success +'</p>');
else
statusdiv.html('<p class="ajax-error alert alert-error" >' + addict_script_vars.error +'</p>');
commentform.find('textarea[name=comment]').val('');
}
});
return false;

});
});

}