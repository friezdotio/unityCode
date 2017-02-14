component extends="baseServices" {

	public any function get(){
		return entityLoad("permission");
    }

	 public function getByPK(numeric id) {
        return entityLoadByPk("permission", arguments.id);
    }

}