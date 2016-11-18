-------------------------------------------------------------------------------------------
-- TerraME - a software platform for multiple scale spatially-explicit dynamic modeling.
-- Copyright (C) 2001-2016 INPE and TerraLAB/UFOP -- www.terrame.org

-- This code is part of the TerraME framework.
-- This framework is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.

-- You should have received a copy of the GNU Lesser General Public
-- License along with this library.

-- The authors reassure the license terms regarding the warranties.
-- They specifically disclaim any warranties, including, but not limited to,
-- the implied warranties of merchantability and fitness for a particular purpose.
-- The framework provided hereunder is on an "as is" basis, and the authors have no
-- obligation to provide maintenance, support, updates, enhancements, or modifications.
-- In no event shall INPE and TerraLAB / UFOP be held liable to any party for direct,
-- indirect, special, incidental, or consequential damages arising out of the use
-- of this software and its documentation.
--
-------------------------------------------------------------------------------------------

-- @example Creates a database that can be used by the example fire-spread of base package.

import("terralib")

project = Project{
	title = "Emas database",
	description = "A small example related to a fire spread model.",
	file = "emas.tview",
	clean = true,
	author = "Almeida, R.",
	firebreak = filePath("firebreak_lin.shp", "terralib"),
	river = filePath("River_lin.shp", "terralib"),
	limit = filePath("Limit_pol.shp", "terralib")
}

cl = Layer{
	project = project,
	file = "emas.shp",
	clean = true,
	input = "limit",
	name = "cells",
	resolution = 1500
}

cl:fill{
	operation = "presence",
	attribute = "firebreak",
	layer = "firebreak"
}

cl:fill{
	operation = "presence",
	attribute = "river",
	layer = "river"
}

cs = CellularSpace{
	project = project,
	layer = "cells"
}

Map{
	target = cs,
	select = "firebreak",
	value = {0, 1},
	color = {"white", "black"}
}

Map{
	target = cs,
	select = "river",
	value = {0, 1},
	color = {"white", "black"}
}
