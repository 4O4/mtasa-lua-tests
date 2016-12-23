-- This test relies on CTRL+V being the only way of pasting data to GUI

showCursor(true)

local ctrlPressed = false
local editBox2Focused = false
local memo2Focused = false

local testText = "This text has exactly 119 characters, which is the max length of both both edit boxes. Try to copy it to the other one."
local testMemoText = "The same thing but with Memos having max length. 112 characters here, try to paste this text to the second Memo."

local window = GuiWindow(300, 300, 700, 350, "Test pasting text into MaxLength-limited textboxes", false)

local editBox1 = GuiEdit(10, 30, 680, 30, testText, false, window)
editBox1:setReadOnly(true)
editBox1:setMaxLength(119)

local editBox2 = GuiEdit(10, 70, 680, 30, "", false, window)
editBox2:setMaxLength(119)

local label = GuiLabel(10, 110, 680, 30, "", false, window)
label.horizontalAlign = "Center"


local memo1 = GuiMemo(10, 170, 680, 60, testMemoText, false, window)
memo1:setReadOnly(true)
memo1:setProperty("MaxTextLength", 112)

local memo2 = GuiMemo(10, 240, 680, 60, "", false, window)
memo2:setProperty("MaxTextLength", 112)
outputChatBox(string.len(memo2:getText()))

local label2 = GuiLabel(10, 310, 680, 30, "", false, window)
label2.horizontalAlign = "Center"


function trackFocus()
	function getState()
		return eventName == "onClientGUIFocus" and true or false
	end

	if source == editBox2 then
		editBox2Focused = getState()
	elseif source == memo2 then
		memo2Focused = getState()
	end
end
addEventHandler("onClientGUIFocus", window, trackFocus, true)

addEventHandler("onClientGUIBlur", window, trackFocus, true) 

addEventHandler("onClientKey", root, 
	function (theButton, pressed) 
	    if theButton == "lctrl" or theButton == "rctrl" then
	    	ctrlPressed = pressed
	    elseif ctrlPressed and theButton == "v" and pressed then
	    	if editBox2Focused then
		    	setTimer(
		    		function ()
				    	if editBox2.text == testText then
					    	label.text = "Test passed"
							label:setColor(0, 255, 0)
						else
							label.text = "Test failed!"
							label:setColor(255, 0, 0)
						end		    
		    		end, 
		    	100, 1)	
		    elseif memo2Focused then
		    	setTimer(
		    		function ()
				    	if memo2.text == testMemoText .. "\n" then
					    	label2.text = "Test passed"
							label2:setColor(0, 255, 0)
						else
							label2.text = "Test failed!"
							label2:setColor(255, 0, 0)
						end		    
		    		end, 
		    	100, 1)	
		    end
	    end
	end
)

addEventHandler("onClientResourceStop", resourceRoot, 
	function ()
		showCursor(false)
	end
)