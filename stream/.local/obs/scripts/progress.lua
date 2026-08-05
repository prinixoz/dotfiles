obs = obslua

-- Global Script Properties
p_before_text = "Progress: "
p_max_count = 10
p_after_text = ""
p_source_name = ""
current_count = 1

-- Hotkey IDs
hotkey_inc_id = obs.OBS_INVALID_HOTKEY_ID
hotkey_dec_id = obs.OBS_INVALID_HOTKEY_ID

----------------------------------------------------
-- Helper Functions
----------------------------------------------------

-- Function to update the text source in OBS
function update_text_source()
    if p_source_name == "" or p_source_name == nil then
        return
    end

    local source = obs.obs_get_source_by_name(p_source_name)
    if source ~= nil then
        local settings = obs.obs_data_create()

        -- Format the text string: "Before [Current/Max] After"
        local formatted_text = string.format("%s%d/%d%s", p_before_text, current_count, p_max_count, p_after_text)

        obs.obs_data_set_string(settings, "text", formatted_text)
        obs.obs_source_update(source, settings)

        obs.obs_data_release(settings)
        obs.obs_source_release(source)
    end
end

-- Hotkey Actions
function increment_counter(pressed)
    if pressed then
        -- Allows going beyond p_max_count (e.g., 6/5)
        current_count = current_count + 1
        update_text_source()
    end
end

function decrement_counter(pressed)
    if pressed then
        -- Floor at 1 so it never goes below 1
        if current_count > 1 then
            current_count = current_count - 1
            update_text_source()
        end
    end
end

----------------------------------------------------
-- OBS Script Interface Definitions
----------------------------------------------------

-- Description shown in Tools -> Scripts
function script_description()
    return "Adds a progress counter to a Text source with hotkey controls.\n\n" ..
        "Set up your options below, then configure Hotkeys under OBS Settings -> Hotkeys."
end

-- GUI Properties shown in the OBS Scripts window
function script_properties()
    local props = obs.obs_properties_create()

    -- Text input before the count
    obs.obs_properties_add_text(props, "before_text", "Before Text", obs.OBS_TEXT_DEFAULT)

    -- Maximum count limit
    obs.obs_properties_add_int(props, "max_count", "Max Count", 1, 9999, 1)

    -- Text input after the count
    obs.obs_properties_add_text(props, "after_text", "After Text", obs.OBS_TEXT_DEFAULT)

    -- Dropdown list to select the Target Text Source
    local p_source = obs.obs_properties_add_list(props, "source_name", "Text Source",
        obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_STRING)

    -- Populate source dropdown with existing text sources in OBS
    local sources = obs.obs_enum_sources()
    if sources ~= nil then
        for _, source in ipairs(sources) do
            local id = obs.obs_source_get_unversioned_id(source)
            if id == "text_gdiplus" or id == "text_ft2_source" or id == "text_gdiplus_v2" then
                local name = obs.obs_source_get_name(source)
                obs.obs_property_list_add_string(p_source, name, name)
            end
        end
    end
    obs.source_list_release(sources)

    return props
end

-- Default property values
function script_defaults(settings)
    obs.obs_data_set_default_string(settings, "before_text", "Progress: ")
    obs.obs_data_set_default_int(settings, "max_count", 10)
    obs.obs_data_set_default_string(settings, "after_text", "")
end

-- Triggered whenever properties are modified in the GUI
function script_update(settings)
    p_before_text = obs.obs_data_get_string(settings, "before_text")
    p_max_count = obs.obs_data_get_int(settings, "max_count")
    p_after_text = obs.obs_data_get_string(settings, "after_text")
    p_source_name = obs.obs_data_get_string(settings, "source_name")

    -- Ensure count is at least 1 when settings change
    if current_count < 1 then
        current_count = 1
    end

    update_text_source()
end

-- Script load event: Register hotkeys
function script_load(settings)
    -- Register Increase Hotkey
    hotkey_inc_id = obs.obs_hotkey_register_frontend("progress_inc_key", "Progress Counter: Increase", increment_counter)
    local hotkey_inc_array = obs.obs_data_get_array(settings, "progress_inc_key")
    obs.obs_hotkey_load(hotkey_inc_id, hotkey_inc_array)
    obs.obs_data_array_release(hotkey_inc_array)

    -- Register Decrease Hotkey
    hotkey_dec_id = obs.obs_hotkey_register_frontend("progress_dec_key", "Progress Counter: Decrease", decrement_counter)
    local hotkey_dec_array = obs.obs_data_get_array(settings, "progress_dec_key")
    obs.obs_hotkey_load(hotkey_dec_id, hotkey_dec_array)
    obs.obs_data_array_release(hotkey_dec_array)
end

-- Script save event: Save hotkeys
function script_save(settings)
    local hotkey_inc_array = obs.obs_hotkey_save(hotkey_inc_id)
    obs.obs_data_set_array(settings, "progress_inc_key", hotkey_inc_array)
    obs.obs_data_array_release(hotkey_inc_array)

    local hotkey_dec_array = obs.obs_hotkey_save(hotkey_dec_id)
    obs.obs_data_set_array(settings, "progress_dec_key", hotkey_dec_array)
    obs.obs_data_array_release(hotkey_dec_array)
end
