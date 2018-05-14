local gui = require 'yue.gui'
local backend = require 'gui.backend'
local get_report = require 'share.report'
local lang = require 'share.lang'
local ui = require 'gui.new.template'

local function count_report_height(text)
    local n = 1
    for _ in text:gmatch '\n' do
        n = n + 1
    end
    return n * 21
end

local template = ui.container {
    style = { FlexGrow = 1 },
    ui.scroll {
        style = { FlexGrow = 1, Margin = 2 },
        hpolicy = 'never',
        vpolicy = 'never',
        width = 0,
        bind = {
            height = 'report.height'
        },
        ui.container {
            style = { FlexGrow = 1 },
            ui.label {
                style = { FlexGrow = 1 },
                font = { size = 18 },
                text_color = '#CCC',
                align = 'start',
                bind = {
                    text = 'report.text'
                },
            },
        },
    },
    ui.button {
        title = lang.ui.BACK,
        style = { Bottom = 0, Height = 28, Margin = 5 },
        font = { size = 16 },
        on = {
            click = function()
                window:show_page('convert')
            end
        }
    }
}

local view, data = ui.create(template, {
    report = {
        text = '',
        height = 0,
    }
})

function view:on_show()
    local text = get_report(backend.report)
    data.report.text = text
    data.report.height = count_report_height(text)
end

return view
