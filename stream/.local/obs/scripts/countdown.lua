obs               = obslua

-- Active State Variables
cur_seconds       = 0
last_text         = ""
stop_text         = "TIME UP!"
source_name       = ""
alarm_source_name = ""
bgm_source_name   = ""
activated         = false

reset_hotkey_id   = obs.OBS_INVALID_HOTKEY_ID
stop_hotkey_id    = obs.OBS_INVALID_HOTKEY_ID

-- Time parser ONLY for full words: hours/hour, minutes/minute, seconds/second
function parse_time_from_string(name)
    if name == nil or name == "" then return 0 end

    local lower_name = string.lower(name)
    local total_sec = 0

    -- Match Full Words: "1 hour", "2 hours"
    local h = lower_name:match("(%d+)%s*hours") or lower_name:match("(%d+)%s*hour")
    if h then total_sec = total_sec + (tonumber(h) * 3600) end

    -- Match Full Words: "10 minute", "20 minutes"
    local m = lower_name:match("(%d+)%s*minutes") or lower_name:match("(%d+)%s*minute")
    if m then total_sec = total_sec + (tonumber(m) * 60) end

    -- Match Full Words: "30 second", "45 seconds"
    local s = lower_name:match("(%d+)%s*seconds") or lower_name:match("(%d+)%s*second")
    if s then total_sec = total_sec + tonumber(s) end

    return total_sec
end

-- Media Control Helpers
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

    -- Always formatted as HH:MM:SS (00:00:00)
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
        activated = false

        stop_media_source(bgm_source_name)
        play_media_source(alarm_source_name)
    end

    set_time_text()
end

function activate(activating, duration_seconds)
    if activated then
        obs.timer_remove(timer_callback)
        stop_media_source(bgm_source_name)
        activated = false
    end

    if activating and duration_seconds > 0 then
        stop_media_source(alarm_source_name)

        cur_seconds = duration_seconds
        set_time_text()

        play_media_source(bgm_source_name)
        obs.timer_add(timer_callback, 1000)
        activated = true
    end
end

function scene_switch()
    local current_scene_source = obs.obs_frontend_get_current_scene()
    if current_scene_source == nil then return end

    local current_scene_name = obs.obs_source_get_name(current_scene_source)
    obs.obs_source_release(current_scene_source)

    local duration_seconds = parse_time_from_string(current_scene_name)

    if duration_seconds > 0 then
        activate(true, duration_seconds)
    else
        activate(false, 0)
        stop_media_source(alarm_source_name)
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
    local sources = obs.obs_enum_sources()

    local text_prop = obs.obs_properties_add_list(props, "source_name", "Global Text Source", obs
    .OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
    obs.obs_property_list_add_string(text_prop, "(None)", "")

    local bgm_prop = obs.obs_properties_add_list(props, "bgm_source_name", "BGM Source (Optional)",
        obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
    obs.obs_property_list_add_string(bgm_prop, "(None)", "")

    local alarm_prop = obs.obs_properties_add_list(props, "alarm_source_name", "Alarm Source (Optional)",
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
        obs.source_list_release(sources)
    end

    obs.obs_properties_add_text(props, "stop_text", "Completion Text", obs.OBS_TEXT_DEFAULT)

    obs.obs_properties_add_button(props, "stop_alarm_button", "Stop Alarm Audio", stop_alarm_button_clicked)
    obs.obs_properties_add_button(props, "reset_button", "Reset Current Timer", reset_button_clicked)

    return props
end

function script_description()
    return
    "Starts a timer formatted as 00:00:00 when scene names contain full words: 'hour'/'hours', 'minute'/'minutes', or 'second'/'seconds'."
end

function script_update(settings)
    source_name       = obs.obs_data_get_string(settings, "source_name")
    bgm_source_name   = obs.obs_data_get_string(settings, "bgm_source_name")
    alarm_source_name = obs.obs_data_get_string(settings, "alarm_source_name")
    stop_text         = obs.obs_data_get_string(settings, "stop_text")

    scene_switch()
end

function script_defaults(settings)
    obs.obs_data_set_default_string(settings, "source_name", "")
    obs.obs_data_set_default_string(settings, "bgm_source_name", "")
    obs.obs_data_set_default_string(settings, "alarm_source_name", "")
    obs.obs_data_set_default_string(settings, "stop_text", "TIME UP!")
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
