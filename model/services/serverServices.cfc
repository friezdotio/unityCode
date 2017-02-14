component extends="baseServices" {

	public function get(numeric id) {
        return entityLoad("server", {isActive=true});
    }

	public function getByPK(numeric id) {
        return entityLoadByPk("server", arguments.id);
    }

    // BBB API Methods

    public function testAPI(){

    	local.url = "http://69.30.202.86/";
    	local.salt = "923x3hh1qzto0f7a8k55rx9llyu8pmft";
		local.call = "getMeetings";
		local.queryStringClean = "";

		local.queryStringPrepend = local.call & local.queryStringClean;
		local.queryStringAppend  = local.queryStringPrepend & local.salt;

    	local.checksum = lCase(hash(local.queryStringAppend, "SHA"));
    	local.queryStringFinal = local.queryStringClean & "&checksum=" & local.checksum;
		local.finalURL = local.url & "bigbluebutton/api/" & local.call & "?" & local.queryStringFinal;

    	cfhttp(method="POST", url="#local.finalURL#", result="local.result");
	    return xmlToStruct(xmlParse(local.result.fileContent));

    }

    public function getTalks(server){

    	local.serverObj = arguments.server;

    	local.url = local.serverObj.getURL();
    	local.salt = local.serverObj.getSalt();
    	local.call = "getMeetings";
		local.queryStringClean = "";

		local.queryStringPrepend = local.call & local.queryStringClean;
		local.queryStringAppend  = local.queryStringPrepend & local.salt;

    	local.checksum = lCase(hash(local.queryStringAppend, "SHA"));
    	local.queryStringFinal = local.queryStringClean & "&checksum=" & local.checksum;
		local.finalURL = local.url & "bigbluebutton/api/" & local.call & "?" & local.queryStringFinal;

    	cfhttp(method="POST", url="#local.finalURL#", result="local.result");
	    return xmlParse(local.result.fileContent);

    }

}