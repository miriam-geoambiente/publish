-- @example Implementation of a simple emas application. It uses the data from a tview file (terralib/emas.tview).
-- There is a layout with the web page properties.
-- Each polygon is drawn using the attribute 'select'.

import("publish")

local layout = Layout{
	title = "Emas",
	description = "A small example related to a fire spread model."
}

Application{
	project = filePath("emas.tview", "publish"),
	layout = layout,
	clean = true,
	select = "river",
	color = "PuBu",
	value = {0, 1, 2},
	output = Directory("EmasWebMap")
}
