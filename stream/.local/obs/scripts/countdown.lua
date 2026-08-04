obs               = obslua

-- Scene Configuration Structure
scene_configs     = {}

-- Active State Variables
cur_seconds       = 0
total_seconds     = 0
last_text         = ""
stop_text         = ""
source_name       = ""
alarm_source_name = ""
bgm_source_name   = ""
activated         = false

reset_hotkey_id   = obs.OBS_INVALID_HOTKEY_ID
stop_hotkey_id    = obs.OBS_INVALID_HOTKEY_ID

-- Helper to control a Media Source playback by Source Name
function play_media_source(name)
    if name == nil or name == "" then return end
    local source = obs.obs_get_source_by_name(name)
    if source ~= nil then
        obs.obs_source_media_restart(source)
        obs.obs_source_set_enabled(source, true)
        obs.obs_source_release(source)
    end
end

function stop_media_source(name)
    if name == nil or name == "" then return end
    local source = obs.obs_get_source_by_name(name)
    if source ~= nil then
        obs.obs_source_media_stop(source)
        obs.obs_source_release(source)
    end
end

function set_time_text()
    if source_name == "" then return end

    local seconds       = math.floor(cur_seconds % 60)
    local total_minutes = math.floor(cur_seconds / 60)
    local minutes       = math.floor(total_minutes % 60)
    local hours         = math.floor(total_minutes / 60)
    local text          = string.format("%02d:%02d:%02d", hours, minutes, seconds)

    if cur_seconds < 1 then
        text = stop_text
    end

    if text ~= last_text then
        local source = obs.obs_get_source_by_name(source_name)
        if source ~= nil then
            local settings = obs.obs_data_create()
            obs.obs_data_set_string(settings, "text", text)
            obs.obs_source_update(source, settings)
            obs.obs_data_release(settings)
            obs.obs_source_release(source)
        end
    end

    last_text = text
end

function timer_callback()
    cur_seconds = cur_seconds - 1
    if cur_seconds < 0 then
        obs.remove_current_callback()
        cur_seconds = 0

        -- Stop countdown music and start looping alarm
        stop_media_source(bgm_source_name)
        play_media_source(alarm_source_name)
    end

    set_time_text()
end

function activate(activating)
    if activated == activating then return end

    activated = activating

    if activating then
        stop_media_source(alarm_source_name)
        stop_media_source(bgm_source_name)

        cur_seconds = total_seconds
        set_time_text()

        play_media_source(bgm_source_name)
        obs.timer_add(timer_callback, 1000)
    else
        obs.timer_remove(timer_callback)
        stop_media_source(bgm_source_name)
    end
end

function scene_switch()
    local current_scene_source = obs.obs_frontend_get_current_scene()
    if current_scene_source == nil then return end

    local current_scene_name = obs.obs_source_get_name(current_scene_source)
    obs.obs_source_release(current_scene_source)

    activate(false)
    stop_media_source(alarm_source_name)

    for _, config in ipairs(scene_configs) do
        if config.scene_name == current_scene_name and config.scene_name ~= "" then
            source_name       = config.source_name
            total_seconds     = config.duration * 60
            stop_text         = config.stop_text
            alarm_source_name = config.alarm_source_name
            bgm_source_name   = config.bgm_source_name
            last_text         = ""

            activate(true)
            break
        end
    end
end

function frontend_event(event)
    if event == obs.OBS_FRONTEND_EVENT_SCENE_CHANGED then
        scene_switch()
    end
end

function reset(pressed)
    if not pressed then return end
    stop_media_source(alarm_source_name)
    activate(false)
    scene_switch()
end

function stop_alarm_hotkey(pressed)
    if not pressed then return end
    stop_media_source(alarm_source_name)
end

function reset_button_clicked(props, p)
    reset(true)
    return false
end

function stop_alarm_button_clicked(props, p)
    stop_media_source(alarm_source_name)
    return false
end

----------------------------------------------------------

function script_properties()
    local props = obs.obs_properties_create()

    local scenes = obs.obs_frontend_get_scenes()
    local sources = obs.obs_enum_sources()

    for i = 1, 4 do
        obs.obs_properties_add_text(props, "header_" .. i, "--- SCENE CONFIGURATION " .. i .. " ---", obs.OBS_TEXT_INFO)

        local scene_prop = obs.obs_properties_add_list(props, "scene_" .. i, "Scene", obs.OBS_COMBO_TYPE_EDITABLE,
            obs.OBS_COMBO_FORMAT_STRING)
        obs.obs_property_list_add_string(scene_prop, "(None)", "")

        if scenes ~= nil then
            for _, scene in ipairs(scenes) do
                local name = obs.obs_source_get_name(scene)
                obs.obs_property_list_add_string(scene_prop, name, name)
            end
        end

        obs.obs_properties_add_int(props, "duration_" .. i, "Duration (minutes)", 1, 100000, 1)

        local text_prop = obs.obs_properties_add_list(props, "source_" .. i, "Text Source", obs.OBS_COMBO_TYPE_EDITABLE,
            obs.OBS_COMBO_FORMAT_STRING)
        obs.obs_property_list_add_string(text_prop, "(None)", "")

        local bgm_prop = obs.obs_properties_add_list(props, "bgm_source_" .. i, "Countdown BGM Source",
            obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
        obs.obs_property_list_add_string(bgm_prop, "(None)", "")

        local alarm_prop = obs.obs_properties_add_list(props, "alarm_source_" .. i, "Completion Alarm Source",
            obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
        obs.obs_property_list_add_string(alarm_prop, "(None)", "")

        if sources ~= nil then
            for _, source in ipairs(sources) do
                local name = obs.obs_source_get_name(source)
                local source_id = obs.obs_source_get_unversioned_id(source)

                if source_id == "text_gdiplus" or source_id == "text_ft2_source" or source_id == "text_gdiplus_v2" then
                    obs.obs_property_list_add_string(text_prop, name, name)
                elseif source_id == "ffmpeg_source" then
                    obs.obs_property_list_add_string(bgm_prop, name, name)
                    obs.obs_property_list_add_string(alarm_prop, name, name)
                end
            end
        end

        obs.obs_properties_add_text(props, "stop_text_" .. i, "Final Text", obs.OBS_TEXT_DEFAULT)
    end

    if scenes ~= nil then obs.source_list_release(scenes) end
    if sources ~= nil then obs.source_list_release(sources) end

    obs.obs_properties_add_button(props, "stop_alarm_button", "Stop Alarm Audio", stop_alarm_button_clicked)
    obs.obs_properties_add_button(props, "reset_button", "Reset Current Timer", reset_button_clicked)

    return props
end

function script_description()
    return "Manages scene timers and controls existing OBS Media Sources by name."
end

function script_update(settings)
    scene_configs = {}

    for i = 1, 4 do
        local sc_name   = obs.obs_data_get_string(settings, "scene_" .. i)
        local duration  = obs.obs_data_get_int(settings, "duration_" .. i)
        local src_name  = obs.obs_data_get_string(settings, "source_" .. i)
        local final_txt = obs.obs_data_get_string(settings, "stop_text_" .. i)
        local alarm_src = obs.obs_data_get_string(settings, "alarm_source_" .. i)
        local bgm_src   = obs.obs_data_get_string(settings, "bgm_source_" .. i)

        if sc_name ~= "" then
            table.insert(scene_configs, {
                scene_name        = sc_name,
                duration          = duration,
                source_name       = src_name,
                stop_text         = final_txt,
                alarm_source_name = alarm_src,
                bgm_source_name   = bgm_src
            })
        end
    end

    scene_switch()
end

function script_defaults(settings)
    for i = 1, 4 do
        obs.obs_data_set_default_string(settings, "scene_" .. i, "")
        obs.obs_data_set_default_int(settings, "duration_" .. i, 10)
        obs.obs_data_set_default_string(settings, "source_" .. i, "")
        obs.obs_data_set_default_string(settings, "stop_text_" .. i, "Starting soon (tm)")
        obs.obs_data_set_default_string(settings, "alarm_source_" .. i, "")
        obs.obs_data_set_default_string(settings, "bgm_source_" .. i, "")
    end
end

function script_save(settings)
    local hotkey_save_array = obs.obs_hotkey_save(reset_hotkey_id)
    obs.obs_data_set_array(settings, "reset_hotkey", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    local stop_hotkey_save_array = obs.obs_hotkey_save(stop_hotkey_id)
    obs.obs_data_set_array(settings, "stop_alarm_hotkey", stop_hotkey_save_array)
    obs.obs_data_array_release(stop_hotkey_save_array)
end

function script_load(settings)
    obs.obs_frontend_add_event_callback(frontend_event)

    reset_hotkey_id = obs.obs_hotkey_register_frontend("reset_timer_thingy", "Reset Timer", reset)
    local hotkey_save_array = obs.obs_data_get_array(settings, "reset_hotkey")
    obs.obs_hotkey_load(reset_hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)

    stop_hotkey_id = obs.obs_hotkey_register_frontend("stop_alarm_thingy", "Stop Timer Alarm", stop_alarm_hotkey)
    local stop_hotkey_save_array = obs.obs_data_get_array(settings, "stop_alarm_hotkey")
    obs.obs_hotkey_load(stop_hotkey_id, stop_hotkey_save_array)
    obs.obs_data_array_release(stop_hotkey_save_array)
end
