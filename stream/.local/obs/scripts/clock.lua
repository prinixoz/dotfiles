obs = obslua

-- Source 1 Settings
local source1_name = ""
local source1_mode = 0
local source1_time_format = "%I:%M %p"
local source1_date_format = "%d %b %Y"
local source1_custom_format = "%c"

-- Source 2 Settings
local source2_name = ""
local source2_mode = 0
local source2_time_format = "%I:%M %p"
local source2_date_format = "%d %b %Y"
local source2_custom_format = "%c"

function script_description()
    return [[
Displays the current date/time across two independent Text sources.

Each source can be configured separately with its own display mode and formats using standard Lua os.date() format specifiers.
]]
end

local function render_text(mode, date_fmt, time_fmt, custom_fmt)
    if mode == 0 then
        return os.date(time_fmt)
    elseif mode == 1 then
        return os.date(date_fmt)
    elseif mode == 2 then
        return os.date(date_fmt) .. "\n" .. os.date(time_fmt)
    elseif mode == 3 then
        return os.date(custom_fmt)
    end
    return ""
end

local function update_source_text(name, text)
    if name == "" then
        return
    end

    local source = obs.obs_get_source_by_name(name)
    if source == nil then
        return
    end

    local settings = obs.obs_data_create()
    obs.obs_data_set_string(settings, "text", text)
    obs.obs_source_update(source, settings)

    obs.obs_data_release(settings)
    obs.obs_source_release(source)
end

function update_clock()
    -- Update Source 1
    if source1_name ~= "" then
        local text1 = render_text(source1_mode, source1_date_format, source1_time_format, source1_custom_format)
        update_source_text(source1_name, text1)
    end

    -- Update Source 2
    if source2_name ~= "" then
        local text2 = render_text(source2_mode, source2_date_format, source2_time_format, source2_custom_format)
        update_source_text(source2_name, text2)
    end
end

function add_source_properties(props, prefix, label)
    obs.obs_properties_add_text(
        props,
        prefix .. "_source",
        label .. " - Text Source Name",
        obs.OBS_TEXT_DEFAULT
    )

    local p = obs.obs_properties_add_list(
        props,
        prefix .. "_mode",
        label .. " - Display Mode",
        obs.OBS_COMBO_TYPE_LIST,
        obs.OBS_COMBO_FORMAT_INT
    )

    obs.obs_property_list_add_int(p, "Time", 0)
    obs.obs_property_list_add_int(p, "Date", 1)
    obs.obs_property_list_add_int(p, "Date + Time", 2)
    obs.obs_property_list_add_int(p, "Custom", 3)

    obs.obs_properties_add_text(
        props,
        prefix .. "_time_format",
        label .. " - Time Format",
        obs.OBS_TEXT_DEFAULT
    )

    obs.obs_properties_add_text(
        props,
        prefix .. "_date_format",
        label .. " - Date Format",
        obs.OBS_TEXT_DEFAULT
    )

    obs.obs_properties_add_text(
        props,
        prefix .. "_custom_format",
        label .. " - Custom Format",
        obs.OBS_TEXT_DEFAULT
    )
end

function script_properties()
    local props = obs.obs_properties_create()

    add_source_properties(props, "src1", "Source 1")
    add_source_properties(props, "src2", "Source 2")

    return props
end

function script_defaults(settings)
    -- Source 1 Defaults
    obs.obs_data_set_default_string(settings, "src1_time_format", "%I:%M %p")
    obs.obs_data_set_default_string(settings, "src1_date_format", "%d %b %Y")
    obs.obs_data_set_default_string(settings, "src1_custom_format", "%c")

    -- Source 2 Defaults
    obs.obs_data_set_default_string(settings, "src2_time_format", "%I:%M %p")
    obs.obs_data_set_default_string(settings, "src2_date_format", "%d %b %Y")
    obs.obs_data_set_default_string(settings, "src2_custom_format", "%c")
end

function script_update(settings)
    -- Source 1 Settings Retrieval
    source1_name = obs.obs_data_get_string(settings, "src1_source")
    source1_mode = obs.obs_data_get_int(settings, "src1_mode")
    source1_time_format = obs.obs_data_get_string(settings, "src1_time_format")
    source1_date_format = obs.obs_data_get_string(settings, "src1_date_format")
    source1_custom_format = obs.obs_data_get_string(settings, "src1_custom_format")

    -- Source 2 Settings Retrieval
    source2_name = obs.obs_data_get_string(settings, "src2_source")
    source2_mode = obs.obs_data_get_int(settings, "src2_mode")
    source2_time_format = obs.obs_data_get_string(settings, "src2_time_format")
    source2_date_format = obs.obs_data_get_string(settings, "src2_date_format")
    source2_custom_format = obs.obs_data_get_string(settings, "src2_custom_format")

    update_clock()
end

function script_load(settings)
    obs.timer_add(update_clock, 1000)
end

function script_unload()
    obs.timer_remove(update_clock)
end
