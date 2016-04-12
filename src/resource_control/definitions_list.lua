local DefinitionList = {}
local ResourceDefinitions = require("resource_control.resource_definitions")



function DefinitionList.init()
    ResourceDefinitions.set("large-button", {	type = ResourceDefinitions.Type.Image,
   								    	fileName = "large-button.png",
    									width = 168,
    									height = 64
    							 	 })
    ResourceDefinitions.set("large-button-active", {	
    								type = ResourceDefinitions.Type.Image,
    								fileName = "large-button-active.png",
    								width = 168,
    								height = 64
    						 	 })
    ResourceDefinitions.set("large-button-active-pressed", {	
    								type = ResourceDefinitions.Type.Image,
    								fileName = "large-button-active-pressed.png",
    								width = 168,
    								height = 64
    						 	 })
    ResourceDefinitions.set("wall", {    
                                    type = ResourceDefinitions.Type.Image,
                                    fileName = "wall.png",
                                    width = 1200,
                                    height = 10
                                 })
    ResourceDefinitions.set("spikes", {    
                                    type = ResourceDefinitions.Type.Image,
                                    fileName = "spikes.png",
                                    width = 1200,
                                    height = 10
                                 })
    ResourceDefinitions.set("spiral", {    
                                    type = ResourceDefinitions.Type.Image,
                                    fileName = "spiral2.png",
                                    width = 300,
                                    height = 300
                                 })
    ResourceDefinitions.set("player", {    
                                type = ResourceDefinitions.Type.TiledImage,
                                fileName = "PC Computer - Duelyst - General Zirix Starstrider.png",
                                tileMapSize = {width = 14, height = 6},
                                width = 80, height = 78
                             })
    ResourceDefinitions.set("soundtrack", {	type = ResourceDefinitions.Type.Sound,
      										fileName = "Rise.wav",
    										isLooping = true,
    										volume = 1
    							 	      })
    ResourceDefinitions.set("header_font", {type = ResourceDefinitions.Type.Font,
    										fileName = "supernatural_knight.ttf",
    										glyphs = "qwertyuiopasdfghjklzxcvbnm!@#$%^&*()_+:\"{}<>?,./';[]0123456789",
    										fontSize = 26,
    										dpi = 160
    							 	       })
    ResourceDefinitions.set("default_font", {type = ResourceDefinitions.Type.Font,
    									     fileName = "allods_west.ttf",
    									     glyphs = "qwertyuiopasdfghjklzxcvbnm!@#$%^&*()_+:\"{}<>?,./';[]0123456789",
    									     fontSize = 26,
    									     dpi = 160
    							 	     })
end



return DefinitionList