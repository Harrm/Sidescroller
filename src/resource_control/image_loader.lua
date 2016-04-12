local ImageLoader = {}

ImageLoader.TEXTURES_PATH = "../data/textures/"



function ImageLoader.load(definition)
	local image
	local filePath = ImageLoader.TEXTURES_PATH..definition.fileName
	
	if definition.coords ~= nil then
		image = self:loadGfxQuad2D(filePath, definition.coords)

	else
		local halfWidth = definition.width / 2
		local halfHeight = definition.height / 2
		image = ImageLoader.loadGfxQuad2D(filePath, {-halfWidth, -halfHeight, 
													  halfWidth,  halfHeight})
	end
	return image	
end



function ImageLoader.loadTiled(definition)
	if definition.tileMapSize == nil then
		error("Expected 'tileMapSize'(table {width, height}) parameter in definition")
	end

	local filePath = ImageLoader.TEXTURES_PATH..definition.fileName
	
	local rect
	if definition.width and definition.height then
		local half_width = definition.width / 2
		local half_height = definition.height / 2
		rect = {-half_width, -half_height, half_width, half_height}
	end

	local image = ImageLoader.loadTileDeck2D(filePath, {definition.tileMapSize.width, 
														definition.tileMapSize.height}, rect)
	return image
end



function ImageLoader.loadGfxQuad2D(filePath, rect)
	local image = MOAIGfxQuad2D.new()
	image:setTexture(filePath)
	image:setRect(unpack(rect))
	return image
end



function  ImageLoader.loadTileDeck2D(filePath, tileMapSize, rect)
	local image = MOAITileDeck2D.new()
	image:setTexture(filePath)
	image:setSize(unpack(tileMapSize))
	if rect then
		image:setRect(unpack(rect))
	end
	return image
end



return ImageLoader
