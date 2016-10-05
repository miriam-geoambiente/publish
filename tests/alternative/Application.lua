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

return {
	Application = function(unitTest)
		local emas = filePath("emas.tview", "terralib")
		local emasDir = Directory("EmasWebMap")

		local layout = Layout{
			title = "Emas",
			description = "Creates a database that can be used by the example fire-spread of base package.",
			base = "satellite",
			zoom = 14,
			center = {lat = -18.106389, long = -52.927778}
		}

		local error_func = function()
			Application()
		end
		unitTest:assertError(error_func, tableArgumentMsg())

		error_func = function()
			Application(1)
		end
		unitTest:assertError(error_func, namedArgumentsMsg())

		error_func = function()
			Application{
				arg = "void",
				project = emas,
				layout = layout
			}
		end
		unitTest:assertError(error_func, unnecessaryArgumentMsg("arg"))

		local data = {
			project = emas,
			layout = layout,
			clean = 1,
			output = emasDir
		}

		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("clean", "boolean", 1))

		data.clean = true
		data.layers = 1
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("layers", "table", 1))

		data.layers = nil
		data.output = 1
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("output", "Directory", 1))

		data.output = emasDir
		data.project = "myproject.tview"
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, "Project '"..data.project.."' was not found.")

		data.project = 1
		error_func = function()
			Application(clone(data))
		end
		unitTest:assertError(error_func, incompatibleTypeMsg("project", "Project", 1))
	end
}

