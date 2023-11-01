local table_utility = require("lib/table_utility/table_utility")

local M = {}

local phone_book = {}

function M.add_follower(adress, message_id)
  local book = phone_book[message_id] or {}
  table.insert(book, adress)
  phone_book[message_id] = book
end

function M.remove_follower(adress, message_id)
  local book = phone_book[message_id]
  local index
  if book ~= nil then 
    for i = 1, #book, 1 do
      if book[i] == adress then index = i end
    end
  end
  table_utility.remove_element(phone_book[message_id], index)
end

function M.remove_all_folowers(message_id)
  phone_book[message_id] = {}
end

function M.remove_all()
  phone_book = {}
end

function M.push_notification(message_id, message)
  local book = phone_book[message_id]
  if book ~= nil then 
    for k, v in pairs(book) do
      msg.post(v, message_id, message)
    end
  end
end


return M