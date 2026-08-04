obs = obslua

local source_name = ""
local mode = 0
local time_format = "%I:%M %p"
local date_format = "%d %b %Y"
local custom_format = "%c"

function script_description()
    return [[
Displays the current date/time in a Text (FreeType 2) source.

Display Modes:
• Time
• Date
• Date + Time
• Custom

You can edit the date and time formats directly from the script settings
using standard Lua os.date() format specifiers.
]]
end

function update_clock()
    if source_name == "" then
        return
    end

    local source = obs.obs_get_source_by_name(source_name)
    if source == nil then
        return
    end

    local text = ""

    if mode == 0 then
        text = os.date(time_format)
    elseif mode == 1 then
        text = os.date(date_format)
    elseif mode == 2 then
        text = os.date(date_format) .. "\n" .. os.date(time_format)
    elseif mode == 3 then
        text = os.date(custom_format)
    end

    local settings = obs.obs_data_create()
    obs.obs_data_set_string(settings, "text", text)
    obs.obs_source_update(source, settings)

    obs.obs_data_release(settings)
    obs.obs_source_release(source)
end

function script_properties()
    local props = obs.obs_properties_create()

    obs.obs_properties_add_text(
        props,
        "source",
        "Text Source Name",
        obs.OBS_TEXT_DEFAULT
    )

    local p = obs.obs_properties_add_list(
        props,
        "mode",
        "Display Mode",
        obs.OBS_COMBO_TYPE_LIST,
        obs.OBS_COMBO_FORMAT_INT
    )

    obs.obs_property_list_add_int(p, "Time", 0)
    obs.obs_property_list_add_int(p, "Date", 1)
    obs.obs_property_list_add_int(p, "Date + Time", 2)
    obs.obs_property_list_add_int(p, "Custom", 3)

    obs.obs_properties_add_text(
        props,
        "time_format",
        "Time Format",
        obs.OBS_TEXT_DEFAULT
    )

    obs.obs_properties_add_text(
        props,
        "date_format",
        "Date Format",
        obs.OBS_TEXT_DEFAULT
    )

    obs.obs_properties_add_text(
        props,
        "custom_format",
        "Custom Format",
        obs.OBS_TEXT_DEFAULT
    )

    return props
end

function script_defaults(settings)
    obs.obs_data_set_default_string(settings, "time_format", "%I:%M %p")
    obs.obs_data_set_default_string(settings, "date_format", "%d %b %Y")
    obs.obs_data_set_default_string(settings, "custom_format", "%c")
end

function script_update(settings)
    source_name = obs.obs_data_get_string(settings, "source")
    mode = obs.obs_data_get_int(settings, "mode")
    time_format = obs.obs_data_get_string(settings, "time_format")
    date_format = obs.obs_data_get_string(settings, "date_format")
    custom_format = obs.obs_data_get_string(settings, "custom_format")

    update_clock()
end

function script_load(settings)
    obs.timer_add(update_clock, 1000)
end

function script_unload()
    obs.timer_remove(update_clock)
end
