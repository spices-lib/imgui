project "ImGui"
	kind "StaticLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"imconfig.h",
		"imgui.h",
		"imgui.cpp",
		"imgui_draw.cpp",
		"imgui_internal.h",
		"imgui_widgets.cpp",
		"imstb_rectpack.h",
		"imstb_textedit.h",
		"imstb_truetype.h",
		"imgui_demo.cpp",
		"imgui_tables.cpp",

		--Vulkan Files
		"backends/imgui_impl_vulkan.h",
		"backends/imgui_impl_vulkan.cpp",
		"backends/imgui_impl_glfw.h",
		"backends/imgui_impl_glfw.cpp",
	}

	includedirs
	{
		"%{IncludeDir.ImGui}",

		--Vulkan dependence
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.VulkanSDK}",
		
	}

	filter "system:windows"
		systemversion "latest"
		cppdialect "C++17"
		staticruntime "On"

	filter "system:linux"
		pic "On"
		systemversion "latest"
		cppdialect "C++17"
		staticruntime "On"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
