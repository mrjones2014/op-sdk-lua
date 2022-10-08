--- types This module just provides type annotations for the Lua language server
--- to provide better help in completions and signature help. Provides no functionality.

-- CLI API types

---SDK backend. Takes full command as a list-like table of arguments, and handles execution.
---@alias Backend fun(args:string[]): any

---@class AccountCli
---@field add function
---@field get function
---@field list function
---@field forget function
local AccountCli

---@class ConnectGroupCli
---@field grant function
---@field revoke function
local ConnectGroupCli

---@class ConnectServerCli
---@field create function
---@field get function
---@field edit function
---@field delete function
---@field list function
local ConnectServerCli

---@class ConnectTokenCli
---@field create function
---@field edit function
---@field delete function
---@field list function
local ConnectTokenCli

---@class ConnectVaultCli
---@field grant function
---@field revoke function
local ConnectVaultCli

---@class ConnectCli
---@field group ConnectGroupCli
---@field server ConnectServerCli
---@field token ConnectTokenCli
---@field vault ConnectVaultCli
local ConnectCli

---@class DocumentCli
---@field create function
---@field get function
---@field edit function
---@field delete function
---@field list function
local DocumentCli

---@class EventsCli
---@field create function
local EventsCli

---@class GroupUserCli
---@field grant function
---@field revoke function
---@field list function
local GroupUserCli

---@class GroupCli
---@field user GroupUserCli
---@field create function
---@field get function
---@field edit function
---@field delete function
---@field list function
local GroupCli

---@class ItemCli
---@field create function
---@field get function
---@field edit function
---@field delete function
---@field list function
---@field share function
local ItemCli

---@class UserCli
---@field create function
---@field get function
---@field edit function
---@field delete function
---@field list function
---@field provision function
---@field confirm function
---@field suspend function
---@field reactivate function
local UserCli

---@class VaultCli
---@field create function
---@field get function
---@field edit function
---@field delete function
---@field list function
local VaultCli

---@class Cli
---@field inject function
---@field read function
---@field run function
---@field signin function
---@field signout function
---@field update function
---@field whoami function
---@field account AccountCli
---@field connect ConnectCli
---@field document DocumentCli
---@field eventsCli EventsApi
---@field group GroupCli
---@field item ItemCli
---@field user UserCli
---@field vault VaultCli
local Cli

return Cli
