component extends="baseServices" {

	variables.lock_name = "profilelock";

	 public function getByPK(numeric id) {
        return entityLoadByPk("profile", arguments.id);
    }

    public any function update(required any profile, string image, string fullname, string location,
    						 string website, string aboutme, string facebook,
    						 string twitter, string linkedin, string google) {
        lock name="#variables.lock_name#" type="exclusive" timeout=30 {

        	transaction{
	            if(len(arguments.image)){
	            	arguments.profile.setImage(arguments.image);
        		}
	            arguments.profile.setFullname(arguments.fullname);
	            arguments.profile.setLocation(arguments.location);
	            arguments.profile.setWebsite(arguments.website);
	            arguments.profile.setAboutme(arguments.aboutme);
	            arguments.profile.setFacebook(arguments.facebook);
	            arguments.profile.setTwitter(arguments.twitter);
	            arguments.profile.setLinkedin(arguments.linkedin);
	            arguments.profile.setGoogle(arguments.google);

	            entitySave(arguments.profile);

				transaction action="commit";
			}

            return arguments.profile;
        }
    }

}