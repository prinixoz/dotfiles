obs = obslua

local startup_scene = "Starting Soon"
local startup_delay = 1000

function script_description()
    return [[
Automatically switches OBS to a selected scene when OBS starts.
]]
end

function script_properties()
    local props = obs.obs_properties_create()

    obs.obs_properties_add_text(
        props,
        "startup_scene",
        "Startup Scene Name",
        obs.OBS_TEXT_DEFAULT
    )

    obs.obs_properties_add_int(
        props,
        "startup_delay",
        "Startup Delay (milliseconds)",
        0,
        60000,
        100
    )

    return props
end

function script_defaults(settings)
    obs.obs_data_set_default_string(
        settings,
        "startup_scene",
        "Starting Soon"
    )

    obs.obs_data_set_default_int(
        settings,
        "startup_delay",
        1000
    )
end

function script_update(settings)
    startup_scene = obs.obs_data_get_string(
        settings,
        "startup_scene"
    )

    startup_delay = obs.obs_data_get_int(
        settings,
        "startup_delay"
    )
end

function script_load(settings)
    startup_scene = obs.obs_data_get_string(
        settings,
        "startup_scene"
    )

    startup_delay = obs.obs_data_get_int(
        settings,
        "startup_delay"
    )

    if startup_delay < 0 then
        startup_delay = 1000
    end

    obs.timer_add(
        switch_to_startup_scene,
        startup_delay
    )
end

function switch_to_startup_scene()
    obs.timer_remove(switch_to_startup_scene)

    if startup_scene == nil or startup_scene == "" then
        print("[Startup Scene] No scene name configured.")
        return
    end

    local scene = obs.obs_get_scene_by_name(startup_scene)

    if scene ~= nil then
        obs.obs_frontend_set_current_scene(scene)

        -- IMPORTANT: obs_get_scene_by_name returns obs_scene_t
        obs.obs_scene_release(scene)

        print(
            "[Startup Scene] Switched to '" ..
            startup_scene ..
            "'"
        )
    else
        print(
            "[Startup Scene] Scene '" ..
            startup_scene ..
            "' was not found."
        )
    end
end
