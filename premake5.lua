function table.contains(t, value)
    for _, v in ipairs(t) do
        if v == value then return true end
    end
    return false
end

local sources = {
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
}

local include_dirs = {
	vendor.ImGui.includes,
}

local external_include_dirs = {
}

if table.contains(platform.GetGraphicsFeatures(), "NP_GRAPHICS_WEBGPU") then

	table.insert(sources, "backends/imgui_impl_wgpu.h")
	table.insert(sources, "backends/imgui_impl_wgpu.cpp")
	table.insert(sources, "backends/imgui_impl_glfw.h")
	table.insert(sources, "backends/imgui_impl_glfw.cpp")

	table.insert(external_include_dirs, vendor.emscripten_glfw.includes)
	table.insert(external_include_dirs, vendor.emdawnwebgpu.includes)

end

if table.contains(platform.GetGraphicsFeatures(), "NP_GRAPHICS_OPENGL") then

	table.insert(sources, "backends/imgui_impl_opengl3.h")
	table.insert(sources, "backends/imgui_impl_opengl3.cpp")
	table.insert(sources, "backends/imgui_impl_glfw.h")
	table.insert(sources, "backends/imgui_impl_glfw.cpp")

	table.insert(external_include_dirs, vendor.GLFW.includes)

end

if table.contains(platform.GetGraphicsFeatures(), "NP_GRAPHICS_VULKAN") then

	table.insert(sources, "backends/imgui_impl_vulkan.h")
	table.insert(sources, "backends/imgui_impl_vulkan.cpp")
	table.insert(sources, "backends/imgui_impl_glfw.h")
	table.insert(sources, "backends/imgui_impl_glfw.cpp")

	table.insert(external_include_dirs, vendor.GLFW.includes)
	table.insert(external_include_dirs, vendor.Vulkan_Headers.includes)

end

if table.contains(platform.GetGraphicsFeatures(), "NP_GRAPHICS_DIRECT3D11") then

	table.insert(sources, "backends/imgui_impl_dx11.h")
	table.insert(sources, "backends/imgui_impl_dx11.cpp")
	table.insert(sources, "backends/imgui_impl_glfw.h")
	table.insert(sources, "backends/imgui_impl_glfw.cpp")

	table.insert(external_include_dirs, vendor.GLFW.includes)

end

if table.contains(platform.GetGraphicsFeatures(), "NP_GRAPHICS_DIRECT3D12") then

	table.insert(sources, "backends/imgui_impl_dx12.h")
	table.insert(sources, "backends/imgui_impl_dx12.cpp")
	table.insert(sources, "backends/imgui_impl_glfw.h")
	table.insert(sources, "backends/imgui_impl_glfw.cpp")

	table.insert(external_include_dirs, vendor.GLFW.includes)

end

if table.contains(platform.GetGraphicsFeatures(), "NP_GRAPHICS_METAL") then

	table.insert(sources, "backends/imgui_impl_metal.h")
	table.insert(sources, "backends/imgui_impl_metal.mm")
	table.insert(sources, "backends/imgui_impl_glfw.h")
	table.insert(sources, "backends/imgui_impl_glfw.cpp")

	table.insert(external_include_dirs, vendor.GLFW.includes)
	table.insert(external_include_dirs, vendor.metal_cpp.includes)

end

-- Project ImGui
solution.DefineCppStaticLibrary("ImGui", function()

	systemversion "latest"

	files(sources)

	defines
	{
		"GLFW_INCLUDE_NONE"
	}

	includedirs(include_dirs)
	externalincludedirs(external_include_dirs)

	filter "system:macosx"
		defines
		{
			"IMGUI_IMPL_METAL_CPP"
		}

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

end)