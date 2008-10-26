package com.sikelianos.utils {
  public class FlashVars {

    public function FlashVars() {
      trace ("FlashVars is a static class and should not be instantiated.")
    }

    public static function process(flash_vars) {
      var vars:Object = [];
      for (var k in flash_vars) vars[k] = flash_vars[k];
			
			// Set defaults
			var d = new Object()
      // d.backback_login = "sikelianos"
			d.backpack_xml_url = "http://zeke.sikelianos.com/portfolio/backpack_to_xml.php"
      // d.backpack_xml_url = "http://localhost:8888/backpack_to_xml.php";
      d.base_image_url = "http://sikelianos.backpackit.com/images/"

			// Fill in defaults when needed
			for (k in d) {
  			if (vars[k] == undefined) vars[k] = d[k]
			}
      
		  // Convert to real data types where necessary
      var booleans:Array = new Array()
      var numbers:Array = new Array()
      for (k in vars) {
        if (booleans.indexOf(k) > -1) vars[k] = (vars[k] == "true" || vars[k] == "1") ? true : false
        if (numbers.indexOf(k) > -1) vars[k] = Number(vars[k])
      }
			      
      return vars
    }
        
  }
}