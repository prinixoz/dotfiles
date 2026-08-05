obs = obslua

local source_list_str = ""
local source_names = {}
local last_visible_sources = {} -- Maps scene_name -> last_visible_source_name
local is_updating = false

-- Helper to split comma-separated strings
local function split_string(inputstr, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        local trimmed = str:match("^%s*(.-)%s*$")
        if #trimmed > 0 then
            table.insert(t, trimmed)
        end
    end
    return t
end

-- Timer callback scanning all scenes automatically
local function timer_cb()
    if is_updating or #source_names == 0 then
        return
    end

    local scenes = obs.obs_frontend_get_scenes()
    if scenes == nil then return end

    for _, scene_source in ipairs(scenes) do
        local scene_name = obs.obs_source_get_name(scene_source)
        local scene = obs.obs_scene_from_source(scene_source)

        if scene ~= nil then
            local newly_visible = nil
            local last_visible = last_visible_sources[scene_name] or ""

            -- Find if one of our target sources in this scene was just toggled visible
            for _, name in ipairs(source_names) do
                local item = obs.obs_scene_find_source(scene, name)
                if item ~= nil then
                    if obs.obs_sceneitem_visible(item) then
                        if name ~= last_visible then
                            newly_visible = name
                            break
                        end
                    end
                end
            end

            -- Enforce mutual exclusivity for this specific scene
            if newly_visible ~= nil then
                is_updating = true
                last_visible_sources[scene_name] = newly_visible

                for _, name in ipairs(source_names) do
                    if name ~= newly_visible then
                        local item = obs.obs_scene_find_source(scene, name)
                        if item ~= nil then
                            obs.obs_sceneitem_set_visible(item, false)
                        end
                    end
                end
                is_updating = false
            end
        end
    end

    -- Clean up source references returned by frontend
    obs.source_list_release(scenes)
end

-- Define script properties UI
function script_properties()
    local props = obs.obs_properties_create()
    obs.obs_properties_add_text(props, "sources", "Exclusive Sources Across All Scenes (comma separated)",
        obs.OBS_TEXT_DEFAULT)
    return props
end

-- Script settings updated
function script_update(settings)
    source_list_str = obs.obs_data_get_string(settings, "sources")
    source_names = split_string(source_list_str, ",")
    last_visible_sources = {}
end

-- Script description in UI
function script_description()
    return "Enforces exclusive visibility on selected sources across ALL scenes.\n" ..
        "Whenever a listed source is unhidden in ANY scene, all other listed sources in that scene are hidden automatically."
end

-- Load handler
function script_load(settings)
    obs.timer_add(timer_cb, 100)
end

-- Unload handler
function script_unload()
    obs.timer_remove(timer_cb)
end
