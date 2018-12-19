RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
--RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
--RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end
   

    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message)
    end

    print(author .. ': ' .. message)
end)

RegisterCommand('twt', function(source, args, rawCommand)
    local playerName = GetCharacterName(source)
    local msg = rawCommand:sub(4)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 1.1vw; margin: 1.0vw; background-color: rgba(62, 174, 244, 0.7);border-radius:12px;"><i class="fab fa-twitter" size: 7x></i> ^0@{0}^0:<br>{1}</br></div>',
        args = { playerName, msg }
    })
end, false)

--[[RegisterCommand('unicorn', function(source, args, rawCommand)
    local playerName = GetCharacterName(source)
    local msg = rawCommand:sub(11)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 1.1vw; margin: 1.0vw; background-color: rgba(216, 45, 199, 0.7);border-radius:12px;"><i class="far fa-calendar-check" size: 7x></i> ^0Unicorn:<br>{0}</br></div>',
        args = { msg }
    })
end, false)

RegisterCommand('admins',function(source, args, rawCommand)
    local name = GetCharacterName(source)
    local msg = rawCommand:sub(10)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 1.1vw; margin: 0.8vw;background-color: rgba(178, 23, 56, 0.6);border-radius:12px;"><i class="fas fa-exclamation-circle" size: 5x></i> ^0ADMIN:<br>{0}</br> </div>',
        args = { msg }
    })
end, false]]--


AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	
end
