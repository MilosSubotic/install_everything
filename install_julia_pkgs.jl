#!/usr/bin/env julia

import Pkg


# Problems with Plots
if true
	#TODO maybe could be optimized.
	import Pkg
	Pkg.add("Conda")
	import Conda
	Conda.update()
	Conda.add("matplotlib")
	ENV["PYTHON"]="" #TODO Try this before just Pkg.add("PyPlot")
	Pkg.add("PyPlot")
	Pkg.build("PyCall")
	Pkg.build("PyPlot")
	import PyPlot
	@show PyPlot.version
	if PyPlot.version < v"3.4"
		error("Problem in installation!")
	end

	# Test
	if false
		using Plots
		pyplot(size = (1600, 800))
		x = collect(1:5)
		y = collect(10:10:50)
		plot(x, y)
	end
end

function install_if_not_installed(pkgs::Vector{String})
	deps = Pkg.dependencies()
	#all_pkgs = String[dep.name for dep in values(deps)]
	installed_pkgs = String[
		dep.name for dep in values(deps)
			if dep.is_direct_dep && dep.version !== nothing
	]
	for pkg in pkgs
		if !(pkg in installed_pkgs)
			println("Installing $pkg...")
			Pkg.add(pkg)
		end
	end
end

install_if_not_installed(
	[
		"ArgParse", "Reexport",
		"Plots", "PyPlot", "Plotly",
		"CSV", "DataFrames",
		"DSP", "FFTW",
		"Distributions", "StatsBase", "StatsPlots",
		"LsqFit",
		"NPZ",
		"CxxWrap",
		"StaticArrays",
		"CoordinateTransformations", "Rotations",
	]
)
