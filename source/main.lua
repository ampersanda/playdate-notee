import "CoreLibs/graphics"
import "CoreLibs/keyboard"

local gfx <const> = playdate.graphics
local kbd <const> = playdate.keyboard

initial = "Type note..."
keyboard = ""

function setup()
    keyboard = playdate.datastore.read() or ""
end

setup()

function playdate.update()
    gfx.clear()

    if kbd.isVisible() ~= true and playdate.buttonIsPressed(playdate.kButtonA) then
        kbd.show(keyboard)
    end

    if keyboard == "" then
        gfx.drawText("*" .. initial .. "*", 16, 16)
        kbd.show(keyboard)
    else
        gfx.drawTextInRect(
                "*" .. keyboard .. "*", 16, 16,
                playdate.display.getWidth() - 32,
                playdate.display.getHeight() - 64
        )
    end

    gfx.drawTextAligned("*Press* Ⓐ *to edit*", playdate.display.getWidth() - 16, playdate.display.getHeight() - 32, kTextAlignment.right)
end

function kbd.textChangedCallback()
    keyboard = kbd.text
end

function kbd.keyboardWillHideCallback(ok)
    if ok then
        playdate.datastore.write(keyboard)
    else
        displayText = playdate.datastore.read() or ""
    end
end

function playdate.gameWillSleep()
    playdate.datastore.write(keyboard)
end

