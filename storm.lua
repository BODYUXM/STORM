------------------------------------------------
-- This Source Was Developed By B0DY
--   This Is The ๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค   @Xx_BoDa_UXB.   --
--                - storm -                 --
--        -- https://t.me/So_ST0RM --         --
------------------------------------------------ 
DevRio  = dofile("./libs/redis.lua").connect("127.0.0.1", 6379)
serpent = dofile("./libs/serpent.lua")
JSON    = dofile("./libs/dkjson.lua")
json    = dofile("./libs/JSON.lua")
URL     = dofile("./libs/url.lua")
http    = require("socket.http") 
HTTPS   = require("ssl.https") 
https   = require("ssl.https") 
User    = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
Server  = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a') 
DirName = io.popen("echo $(cd $(dirname $0); pwd)"):read('*a'):gsub('[\n\r]+', '')
Ip      = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a'):gsub('[\n\r]+', '')
Name    = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a'):gsub('[\n\r]+', '')
Port    = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a'):gsub('[\n\r]+', '')
UpTime  = io.popen([[uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes"}']]):read('*a'):gsub('[\n\r]+', '')
--     Source Storm     --
local AutoSet = function() 
if not DevRio:get(Server.."Idstorm") then 
io.write('\27[1;35m\nุงูุงู ุงุฑุณู ุงูุฏู ุงููุทูุฑ ุงูุงุณุงุณู โคฝ โค\n\27[0;33;49m') 
local DevId = io.read():gsub(' ','') 
if tostring(DevId):match('%d+') then 
io.write('\27[1;36mุชู ุญูุธ ุงูุฏู ุงููุทูุฑ ุงูุงุณุงุณู\n27[0;39;49m') 
DevRio:set(Server.."Idstorm",DevId) 
else 
print('\27[1;31mโ โ โ โ โ โ โ โ โ\nูู ูุชู ุญูุธ ุงูุฏู ุงููุทูุฑ ุงูุงุณุงุณู ุงุฑุณูู ูุฑู ุงุฎุฑู\nโ โ โ โ โ โ โ โ โ') 
end 
os.execute('lua storm.lua') 
end 
if not DevRio:get(Server.."Tokenstorm") then 
io.write('\27[1;35m\nุงูุงู ูู ุจุงุฑุณุงู ุชููู ุงูุจูุช โคฝ โค\n\27[0;33;49m') 
local TokenBot = io.read() 
if TokenBot ~= '' then 
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe') 
if res ~= 200 then 
print('\27[1;31mโ โ โ โ โ โ โ โ โ\nุงูุชููู ุบูุฑ ุตุญูุญ ุชุงูุฏ ููู ุซู ุงุฑุณูู\nโ โ โ โ โ โ โ โ โ') 
else 
io.write('\27[1;36mุชู ุญูุธ ุชููู ุงูุจูุช ุจูุฌุงุญ\n27[0;39;49m') 
DevRio:set(Server.."Tokenstorm",TokenBot) 
end  
else 
print('\27[1;31mโ โ โ โ โ โ โ โ โ\nูู ูุชู ุญูุธ ุชููู ุงูุจูุช ุงุฑุณูู ูุฑู ุงุฎุฑู\nโ โ โ โ โ โ โ โ โ') 
end  
os.execute('lua storm.lua') 
end
local Create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Config"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)
file:close()  
end
local CreateConfigAuto = function()
Config = {
DevId = DevRio:get(Server.."Idstorm"),
TokenBot = DevRio:get(Server.."Tokenstorm"),
storm = DevRio:get(Server.."Tokenstorm"):match("(%d+)"),
SudoIds = {DevRio:get(Server.."Idstorm")},
}
Create(Config, "./config.lua") 
file = io.open("storm.sh", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/storm
token="]]..DevRio:get(Server.."Tokenstorm")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ"
echo "~ The tg File Was Not Found In The Bot Files!"
echo "โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ"
exit 1
fi
if [ ! $token ]; then
echo "โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ"
echo "~ The Token Was Not Found In The config.lua File!"
echo "โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ โ"
exit 1
fi
./tg -s ./storm.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("Run", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/storm
while(true) do
rm -fr ../.telegram-cli
screen -S storm -X kill
screen -S storm ./storm.sh
done
]]) 
file:close() 
io.popen("mkdir Files")
os.execute('chmod +x Run;./Run')
end 
CreateConfigAuto()
end
local Load_storm = function() 
local f = io.open("./config.lua", "r") 
if not f then 
AutoSet() 
else 
f:close() 
DevRio:del(Server.."Idstorm");DevRio:del(Server.."Tokenstorm")
end 
local config = loadfile("./config.lua")() 
return config 
end  
Load_storm() 
print("\27[36m"..[[          
echo "โโโโโโโโโโโโโโโโโ โโโโโโโ โโโโโโโ โโโโ   โโโโ";
eccho "โโโโโโโโโโโโโโโโโโโโโโโโโโโโโโโโโโโโโโโ โโโโโ";
echo "โโโโโโโโ   โโโ   โโโ   โโโโโโโโโโโโโโโโโโโโโโ";
echo "โโโโโโโโ   โโโ   โโโ   โโโโโโโโโโโโโโโโโโโโโโ";
echo "โโโโโโโโ   โโโ   โโโโโโโโโโโโ  โโโโโโ โโโ โโโ";
echo "โโโโโโโโ   โโโ    โโโโโโโ โโโ  โโโโโโ     โโโ";
echo "                                            ";
echo "โโโโโโโ  โโโโโโโ โโโโโโโ โโโ   โโโ           ";
echo "โโโโโโโโโโโโโโโโโโโโโโโโโโโโโ โโโโ       ";    
echo "โโโโโโโโโโโ   โโโโโโ  โโโ โโโโโโโ            ";
echo "โโโโโโโโโโโ   โโโโโโ  โโโ  โโโโโ    ";         
echo "โโโโโโโโโโโโโโโโโโโโโโโโโ   โโโ         ";
echo "โโโโโโโ  โโโโโโโ โโโโโโโ    โโโ    ";
echo "                                                         ";
  
> DEV โบ @Xx_BoDa_UXB
> CH โบ @So_ST0RM
~> DEVELOPER โบ @Xx_BoDa_UXB
                                        
]]..'\27[m'.."\n\27[35mServer Information โฌ โค \nโ โ โ โ โ โ โ โ โ โ โ โ โ\27[m\n\27[36m~ \27[mUser \27[36m: \27[10;32m"..User.."\27[m\n\27[36m~ \27[mIp \27[36m: \27[10;32m"..Ip.."\27[m\n\27[36m~ \27[mName \27[36m: \27[10;32m"..Name.."\27[m\n\27[36m~ \27[mPort \27[36m: \27[10;32m"..Port.."\27[m\n\27[36m~ \27[mUpTime \27[36m: \27[10;32m"..UpTime.."\27[m\n\27[35mโ โ โ โ โ โ โ โ โ โ โ โ โ\27[m")
Config = dofile("./config.lua")
DevId = Config.DevId
SudoIds = {Config.SudoIds,1871165209,1966856869,1962004752}
storm = Config.storm
TokenBot = Config.TokenBot
NameBot = (DevRio:get(storm..'Rio:NameBot') or 'ุณุชูุฑู')
--     Source Storm     --
FilesPrint = "\27[35m".."\nAll Source Files Started โฌ โค \nโ โ โ โ โ โ โ โ โ โ โ โ โ\n"..'\27[m'
FilesNumber = 0
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
FilesNumber = FilesNumber + 1
FilesPrint = FilesPrint.."\27[39m"..FilesNumber.."\27[36m".."~ : \27[10;32m"..v.."\27[m \n"
end
end
FilesPrint = FilesPrint.."\27[35m".."โ โ โ โ โ โ โ โ โ โ โ โ โ\n".."\27[m"
if FilesNumber ~= 0 then
print(FilesPrint)
end
--     Source Storm     --
--     Start Functions    --
function vardump(value)
print(serpent.block(value, {comment=false}))
end
--     Source Storm     --
function dl_cb(arg, data)
end
--     Source Storm     --
----------  Sudo  ----------
function Sudo(msg) 
local var = false 
for k,v in pairs(SudoIds) do 
if msg.sender_user_id_ == v then 
var = true 
end end 
if msg.sender_user_id_ == tonumber(DevId) then 
var = true 
end 
return var 
end
function SudoId(user_id) 
local var = false 
for k,v in pairs(SudoIds) do 
if user_id == v then 
var = true 
end end 
if user_id == tonumber(DevId) then 
var = true 
end 
return var 
end
--     Source Storm     --
-------  RioSudo  -------
function RioSudo(msg) 
local Status = DevRio:sismember(storm..'Rio:RioSudo:',msg.sender_user_id_) 
if Status or Sudo(msg) then  
return true  
else  
return false  
end  
end
--     Source Storm     --
-------  SecondSudo  -------
function SecondSudo(msg) 
local Status = DevRio:sismember(storm..'Rio:SecondSudo:',msg.sender_user_id_) 
if Status or RioSudo(msg) or Sudo(msg) then  
return true  
else  
return false  
end  
end
--     Source Storm     --
----------  Bot  -----------
function Bot(msg) 
local var = false  
if msg.sender_user_id_ == tonumber(storm) then  
var = true  
end  
return var  
end 
--     Source Storm     --
---------  SudoBot  --------
function SudoBot(msg) 
local Status = DevRio:sismember(storm..'Rio:SudoBot:',msg.sender_user_id_) 
if Status or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
    --     Source Storm     --
----   RioConstructor   ----
function RioConstructor(msg) 
local Status = DevRio:sismember(storm..'Rio:RioConstructor:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Storm     --
----  BasicConstructor  ----
function BasicConstructor(msg) 
local Status = DevRio:sismember(storm..'Rio:BasicConstructor:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioConstructor(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Storm     --
----    Constructor     ----
function Constructor(msg) 
local Status = DevRio:sismember(storm..'Rio:Constructor:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioConstructor(msg) or BasicConstructor(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Storm     --
---------  Manager  --------
function Manager(msg) 
local Status = DevRio:sismember(storm..'Rio:Managers:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioConstructor(msg) or BasicConstructor(msg) or Constructor(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Storm     --
----------  Admin  ---------
function Admin(msg) 
local Status = DevRio:sismember(storm..'Rio:Admins:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioConstructor(msg) or RioConstructor(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Storm     --
---------Vip Member---------
function VipMem(msg) 
local Status = DevRio:sismember(storm..'Rio:VipMem:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioConstructor(msg) or RioConstructor(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Admin(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Storm     --
--------- Cleaner ----------
function Cleaner(msg) 
local Status = DevRio:sismember(storm..'Rio:Cleaner:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioConstructor(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Storm     --
--------- CleanerNum ----------
function CleanerNum(msg) 
local Status = DevRio:sismember(storm..'Rio:CleanerNum:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or Cleaner(msg) or RioConstructor(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Storm     --
---------  Banned  ---------
local function Ban(user_id, chat_id)
if DevRio:sismember(storm..'Rio:Ban:'..chat_id, user_id) then
var = true
else
var = false
end
return var
end
--     Source Storm     --
---------  BanAll  ---------
function BanAll(user_id)
if DevRio:sismember(storm..'Rio:BanAll:', user_id) then
var = true
else
var = false
end
return var
end
--     Source Storm     --
----------  Muted  ---------
local function Muted(user_id, chat_id)
if DevRio:sismember(storm..'Rio:Muted:'..chat_id, user_id) then
var = true
else
var = false
end
return var
end
--     Source Storm     --
---------  MuteAll  --------
function MuteAll(user_id)
if DevRio:sismember(storm..'Rio:MuteAll:', user_id) then
var = true
else
var = false
end
return var
end
--     Source Storm     --
function DeleteMessage(chatid ,mid)
pcall(tdcli_function ({
ID = "DeleteMessages",
chat_id_ = chatid,
message_ids_ = mid
},function(arg,data) 
end,nil))
end
--     Source Storm     --
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
pcall(tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil))
end
--     Source Storm     --
function stormFiles(msg)
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
plugin = dofile("Files/"..v)
if plugin.storm and msg then
FilesText = plugin.storm(msg)
end
end
end
send(msg.chat_id_, msg.id_,FilesText)  
end
--     Source Storm     --
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
--     Source Storm     --
function AddFile(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if File_Name:lower():match('(%d+)') ~= storm:lower() then 
send(chat,msg.id_,"โ๏ธุนุฐุฑุง ูุฐุง ุงูููู ููุณ ุชุงุจุน ููุฐุง ุงูุจูุช")   
return false 
end
send(chat,msg.id_,"โ๏ธุฌุงุฑู ุฑูุน ุงูููู ... .")
local File = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..File.result.file_path, ''..File_Name) 
else
send(chat,msg.id_,"โ๏ธุนุฐุฑุง ุงูููู ููุณ ุจุตูุบุฉ โคฝ Json ูุฑุฌู ุฑูุน ุงูููู ุงูุตุญูุญ")
end
local info_file = io.open('./'..storm..'.json', "r"):read('*a')
local JsonInfo = JSON.decode(info_file)
vardump(JsonInfo)
DevRio:set(storm.."Rio:NameBot",JsonInfo.BotName) 
for IdGps,v in pairs(JsonInfo.GroupsList) do
DevRio:sadd(storm.."Rio:Groups",IdGps) 
DevRio:set(storm.."Rio:Lock:Bots"..IdGps,"del") DevRio:hset(storm.."Rio:Spam:Group:User"..IdGps ,"Spam:User","keed") 
LockList ={'Rio:Lock:Links','Rio:Lock:Contact','Rio:Lock:Forwards','Rio:Lock:Videos','Rio:Lock:Gifs','Rio:Lock:EditMsgs','Rio:Lock:Stickers','Rio:Lock:Farsi','Rio:Lock:Spam','Rio:Lock:WebLinks','Rio:Lock:Photo'}
for i,Lock in pairs(LockList) do
DevRio:set(storm..Lock..IdGps,true)
end
if v.RioConstructors then
for k,IdRioConstructors in pairs(v.RioConstructors) do
DevRio:sadd(storm..'Rio:RioConstructor:'..IdGps,IdRioConstructors)  
print('ุชู ุฑูุน ููุดุฆูู ุงููุฌููุนุงุช')
end
end
if v.BasicConstructors then
for k,IdBasicConstructors in pairs(v.BasicConstructors) do
DevRio:sadd(storm..'Rio:BasicConstructor:'..IdGps,IdBasicConstructors)  
print('ุชู ุฑูุน ( '..k..' ) ููุดุฆูู ุงุณุงุณููู')
end
end
if v.Constructors then
for k,IdConstructors in pairs(v.Constructors) do
DevRio:sadd(storm..'Rio:Constructor:'..IdGps,IdConstructors)  
print('ุชู ุฑูุน ( '..k..' ) ููุดุฆูู')
end
end
if v.Managers then
for k,IdManagers in pairs(v.Managers) do
DevRio:sadd(storm..'Rio:Managers:'..IdGps,IdManagers)  
print('ุชู ุฑูุน ( '..k..' ) ูุฏุฑุงุก')
end
end
if v.Admins then
for k,idmod in pairs(v.Admins) do
vardump(IdAdmins)
DevRio:sadd(storm..'Rio:Admins:'..IdGps,IdAdmins)  
print('ุชู ุฑูุน ( '..k..' ) ุงุฏูููู')
end
end
if v.Vips then
for k,IdVips in pairs(v.Vips) do
DevRio:sadd(storm..'Rio:VipMem:'..IdGps,IdVips)  
print('ุชู ุฑูุน ( '..k..' ) ูููุฒูู')
end
end
if v.LinkGroups then
if v.LinkGroups ~= "" then
DevRio:set(storm.."Rio:Groups:Links"..IdGps,v.LinkGroups)   
print('( ุชู ูุถุน ุฑูุงุจุท ุงููุฌููุนุงุช )')
end
end
if v.Welcomes then
if v.Welcomes ~= "" then
DevRio:set(storm.."Rio:Groups:Welcomes"..IdGps,v.Welcomes)   
print('( ุชู ูุถุน ุชุฑุญูุจ ุงููุฌููุนุงุช )')
end
end
end
send(chat,msg.id_,"โ๏ธุชู ุฑูุน ุงููุณุฎู ุจูุฌุงุญ \nโ๏ธุชู ุชูุนูู ุฌููุน ุงููุฌููุนุงุช \nโ๏ธุชู ุงุณุชุฑุฌุงุน ูุดุฑููู ุงููุฌููุนุงุช \nโ๏ธุชู ุงุณุชุฑุฌุงุน ุงูุงูุฑ ุงูููู ูุงููุชุญ ูู ุฌููุน ูุฌููุนุงุช ุงูุจูุช ")
end

--     Source Storm     --
function resolve_username(username,cb)
tdcli_function ({
ID = "SearchPublicChat",
username_ = username
}, cb, nil)
end
--     Source Storm     --
function getInputFile(file)
if file:match('/') then
infile = {ID = "InputFileLocal", path_ = file}
elseif file:match('^%d+$') then
infile = {ID = "InputFileId", id_ = file}
else
infile = {ID = "InputFilePersistentId", persistent_id_ = file}
end
return infile
end
--     Source Storm     --
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
--     Source Storm     --
function ChatLeave(chat_id, user_id)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = chat_id, user_id_ = user_id, status_ = { ID = "ChatMemberStatusLeft" }, }, dl_cb, nil)
end
--     Source Storm     --
function ChatKick(chat_id, user_id)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = chat_id, user_id_ = user_id, status_ = { ID = "ChatMemberStatusKicked" }, }, dl_cb, nil)
end
--     Source Storm     --
function getParseMode(parse_mode)
if parse_mode then
local mode = parse_mode:lower()
if mode == 'markdown' or mode == 'md' then
P = {ID = "TextParseModeMarkdown"}
elseif mode == 'html' then
P = {ID = "TextParseModeHTML"}
end
end
return P
end
--     Source Storm     --
function getMessage(chat_id, message_id,cb)
tdcli_function ({
ID = "GetMessage",
chat_id_ = chat_id,
message_id_ = message_id
}, cb, nil)
end
--     Source Storm     --
function sendContact(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, phone_number, first_name, last_name, user_id)
tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = reply_to_message_id, disable_notification_ = disable_notification, from_background_ = from_background, reply_markup_ = reply_markup, input_message_content_ = { ID = "InputMessageContact", contact_ = { ID = "Contact", phone_number_ = phone_number, first_name_ = first_name, last_name_ = last_name, user_id_ = user_id },},}, dl_cb, nil)
end
--     Source Storm     --
function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo, caption)
tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = reply_to_message_id, disable_notification_ = disable_notification, from_background_ = from_background, reply_markup_ = reply_markup, input_message_content_ = { ID = "InputMessagePhoto", photo_ = getInputFile(photo), added_sticker_file_ids_ = {}, width_ = 0, height_ = 0, caption_ = caption }, }, dl_cb, nil)
end
--     Source Storm     --
function Dev_Rio(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
local TextParseMode = getParseMode(parse_mode) tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = reply_to_message_id, disable_notification_ = disable_notification, from_background_ = 1, reply_markup_ = nil, input_message_content_ = { ID = "InputMessageText", text_ = text, disable_web_page_preview_ = disable_web_page_preview, clear_draft_ = 0, entities_ = {}, parse_mode_ = TextParseMode, }, }, dl_cb, nil)
end
--     Source Storm     --
function GetApi(web) 
local info, res = https.request(web) 
local req = json:decode(info) if res ~= 200 then 
return false 
end 
if not req.ok then 
return false 
end 
return req 
end 
--     Source Storm     --
function SendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..TokenBot 
local url = send_api.."/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) 
if reply_to_message_id ~= 0 then 
url = url .. "&reply_to_message_id=" .. reply_to_message_id  
end 
if markdown == "md" or markdown == "markdown" then 
url = url.."&parse_mode=Markdown&disable_web_page_preview=true" 
elseif markdown == "html" then 
url = url.."&parse_mode=HTML" 
end 
return GetApi(url) 
end
--     Source Storm     --
function SendInline(chat_id,text,keyboard,inline,reply_id) 
local response = {} 
response.keyboard = keyboard 
response.inline_keyboard = inline 
response.resize_keyboard = true 
response.one_time_keyboard = false 
response.selective = false  
local send_api = "https://api.telegram.org/bot"..TokenBot.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) 
if reply_id then 
send_api = send_api.."&reply_to_message_id="..reply_id 
end 
return GetApi(send_api) 
end
--     Source Storm     --
function EditMsg(chat_id, message_id, text, markdown) local send_api = "https://api.telegram.org/bot"..TokenBot.."/editMessageText?chat_id="..chat_id.."&message_id="..message_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true" return GetApi(send_api)  end
--     Source Storm     --
function Pin(channel_id, message_id, disable_notification) 
tdcli_function ({ 
ID = "PinChannelMessage", 
channel_id_ = getChatId(channel_id).ID, 
message_id_ = message_id, 
disable_notification_ = disable_notification 
}, function(arg ,data)
vardump(data)
end ,nil) 
end
--     Source Storm     --
local RioRank = function(msg) if SudoId(msg.sender_user_id_) then stormTeam  = "ุงููุทูุฑ" elseif RioSudo(msg) then stormTeam = "ุงููุทูุฑ" elseif SecondSudo(msg) then stormTeam = "ุงููุทูุฑ" elseif SudoBot(msg) then stormTeam = "ุงููุทูุฑ" elseif Manager(msg) then stormTeam = "ุงููุฏูุฑ" elseif Admin(msg) then stormTeam = "ุงูุงุฏูู" else stormTeam = "ุงูุนุถู" end return stormTeam end
function IdRank(user_id,chat_id) if tonumber(user_id) == tonumber(1871165209 ) then stormTeam = 'ุงููุจุฑูุฌ ุงุจูุงููุฌุฏ' elseif tonumber(user_id) == tonumber(1962004752) then stormTeam = 'ูุจุฑูุฌ ุงูุณูุฑุณ' elseif tonumber(user_id) == tonumber(1966856869) then stormTeam = 'ูุทูุฑ ุงูุณูุฑุณ' elseif tonumber(user_id) == tonumber(David) then stormTeam = 'ุงูุจูุช' elseif SudoId(user_id) then  stormTeam = 'ุงููุทูุฑ ุงูุงุณุงุณู' elseif DevRio:sismember(storm..'Rio:RioSudo:', user_id) then stormTeam = 'ุงููุทูุฑ ุงูุงุณุงุณู' elseif DevRio:sismember(storm..'Rio:SecondSudo:', user_id) then stormTeam = 'ุงููุทูุฑ ุงูุงุณุงุณูยฒ' elseif DevRio:sismember(storm..'Rio:SudoBot:', user_id) then stormTeam = DevRio:get(storm.."Rio:SudoBot:Rd"..chat_id) or 'ุงููุทูุฑ' elseif DevRio:sismember(storm..'Rio:RioConstructor:'..chat_id, user_id) then stormTeam = 'ุงููุงูู' elseif DevRio:sismember(storm..'Rio:BasicConstructor:'..chat_id, user_id) then stormTeam = DevRio:get(storm.."Rio:BasicConstructor:Rd"..chat_id) or 'ุงูููุดุฆ ุงูุงุณุงุณู' elseif DevRio:sismember(storm..'Rio:Constructor:'..chat_id, user_id) then stormTeam = DevRio:get(storm.."Rio:Constructor:Rd"..chat_id) or 'ุงูููุดุฆ' elseif DevRio:sismember(storm..'Rio:Managers:'..chat_id, user_id) then stormTeam = DevRio:get(storm.."Rio:Managers:Rd"..chat_id) or 'ุงููุฏูุฑ' elseif DevRio:sismember(storm..'Rio:Admins:'..chat_id, user_id) then stormTeam = DevRio:get(storm.."Rio:Admins:Rd"..chat_id) or 'ุงูุงุฏูู' elseif DevRio:sismember(storm..'Rio:VipMem:'..chat_id, user_id) then  stormTeam = DevRio:get(storm.."Rio:VipMem:Rd"..chat_id) or 'ุงููููุฒ' elseif DevRio:sismember(storm..'Rio:Cleaner:'..chat_id, user_id) then  stormTeam = DevRio:get(storm.."Rio:Cleaner:Rd"..chat_id) or 'ุงูููุธู' else stormTeam = DevRio:get(storm.."Rio:mem:Rd"..chat_id) or 'ุงูุนุถู' end return stormTeam end
--     Source Storm     --
function RankChecking(user_id,chat_id)
if SudoId(user_id) then
var = true  
elseif tonumber(user_id) == tonumber(storm) then  
var = true
elseif DevRio:sismember(storm..'Rio:RioSudo:', user_id) then
var = true
elseif DevRio:sismember(storm..'Rio:SecondSudo:', user_id) then
var = true  
elseif DevRio:sismember(storm..'Rio:SudoBot:', user_id) then
var = true 
elseif DevRio:sismember(storm..'Rio:RioConstructor:'..chat_id, user_id) then
var = true
elseif DevRio:sismember(storm..'Rio:BasicConstructor:'..chat_id, user_id) then
var = true
elseif DevRio:sismember(storm..'Rio:Constructor:'..chat_id, user_id) then
var = true  
elseif DevRio:sismember(storm..'Rio:Managers:'..chat_id, user_id) then
var = true  
elseif DevRio:sismember(storm..'Rio:Admins:'..chat_id, user_id) then
var = true  
elseif DevRio:sismember(storm..'Rio:VipMem:'..chat_id, user_id) then  
var = true 
else  
var = false
end  
return var
end
function RioDelAll(user_id,chat_id)
if SudoId(user_id) then
var = 'sudoid'  
elseif DevRio:sismember(storm..'Rio:RioSudo:', user_id) then
var = 'riosudo'
elseif DevRio:sismember(storm..'Rio:SecondSudo:', user_id) then
var = 'secondsudo' 
elseif DevRio:sismember(storm..'Rio:SudoBot:', user_id) then
var = 'sudobot'  
elseif DevRio:sismember(storm..'Rio:RioConstructor:'..chat_id, user_id) then
var = 'RioConstructor'
elseif DevRio:sismember(storm..'Rio:BasicConstructor:'..chat_id, user_id) then
var = 'basicconstructor'
elseif DevRio:sismember(storm..'Rio:Constructor:'..chat_id, user_id) then
var = 'constructor'
elseif DevRio:sismember(storm..'Rio:Managers:'..chat_id, user_id) then
var = 'manager'  
else  
var = 'No'
end  
return var
end 
--     Source Storm     --
local function Filters(msg, value)
local rio = (storm..'Rio:Filters:'..msg.chat_id_)
if rio then
local names = DevRio:hkeys(rio)
local value = value:gsub(' ','')
for i=1, #names do
if string.match(value:lower(), names[i]:lower()) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Storm     --
function ReplyStatus(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,dp) 
if dp.first_name_ ~= false then
local UserName = (dp.username_ or "So_ST0RM")
for gmatch in string.gmatch(dp.first_name_, "[^%s]+") do
dp.first_name_ = gmatch
end
if status == "WrongWay" then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุนุฐุฑุง ุนุฒูุฒู โคฝ ["..dp.first_name_.."](T.me/"..UserName..")".."\n"..text, 1, 'md')
return false
end
if status == "Reply" then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงูุนุถู โคฝ ["..dp.first_name_.."](T.me/"..UserName..")".."\n"..text, 1, 'md')
return false
end
if status == "ReplyBy" then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุจูุงุณุทุฉ โคฝ ["..dp.first_name_.."](T.me/"..UserName..")".."\n"..text, 1, 'md')
return false
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงูุญุณุงุจ ูุญุฐูู ูู ุจุงูุชุงูุฏ ูุงุนุฏ ุงููุญุงููู", 1, 'md')
end
end,nil)   
end
--     Source Storm     --
function GetCustomTitle(user_id,chat_id)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..chat_id..'&user_id='..user_id)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.status == "creator" then 
Status = "ุงููุงูู"
elseif GetInfo.result.status == "administrator" then 
Status = "ูุดุฑู"
else
Status = false
end
if GetInfo.result.custom_title then 
Rio = GetInfo.result.custom_title
else 
Rio = Status
end
end
return Rio
end
function Validity(msg,user_id) 
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..user_id)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.status == "creator" then
send(msg.chat_id_,msg.id_,'โ๏ธูุงูู ุงููุฌููุนู')   
return false  end 
if GetInfo.result.status == "member" then
send(msg.chat_id_,msg.id_,'โ๏ธูุฌุฑุฏ ุนุถู ููุง')   
return false  end
if GetInfo.result.status == 'left' then
send(msg.chat_id_,msg.id_,'โ๏ธุงูุดุฎุต ุบูุฑ ููุฌูุฏ ููุง')   
return false  end
if GetInfo.result.status == "administrator" then
if GetInfo.result.can_change_info == true then EDT = 'โ๏ธ' else EDT = 'โ๏ธ' end
if GetInfo.result.can_delete_messages == true then DEL = 'โ๏ธ' else DEL = 'โ๏ธ' end
if GetInfo.result.can_invite_users == true then INV = 'โ๏ธ' else INV = 'โ๏ธ' end
if GetInfo.result.can_pin_messages == true then PIN = 'โ๏ธ' else PIN = 'โ๏ธ' end
if GetInfo.result.can_restrict_members == true then BAN = 'โ๏ธ' else BAN = 'โ๏ธ' end
if GetInfo.result.can_promote_members == true then VIP = 'โ๏ธ' else VIP = 'โ๏ธ' end 
send(msg.chat_id_,msg.id_,'โ๏ธุตูุงุญูุงุช '..GetCustomTitle(user_id,msg.chat_id_)..' ูู โคฝ โค\nโ โ โ โ โ โ โ โ โ\nโ๏ธุญุฐู ุงูุฑุณุงุฆู โคฝ '..DEL..'\nโ๏ธุฏุนูุฉ ุงููุณุชุฎุฏููู โคฝ '..INV..'\nโ๏ธุญุธุฑ ุงููุณุชุฎุฏููู โคฝ '..BAN..'\nโ๏ธุชุซุจูุช ุงูุฑุณุงุฆู โคฝ '..PIN..'\nโ๏ธุชุบููุฑ ุงููุนูููุงุช โคฝ '..EDT..'\nโ๏ธุงุถุงูุฉ ูุดุฑููู โคฝ '..VIP..'\nโ โ โ โ โ โ โ โ โ')
end
end
end
--     Source Storm     --
function GetBio(chat_id)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..chat_id)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.bio then 
Rio = GetInfo.result.bio
else 
Rio = "ูุง ููุฌุฏ"
end
end
return Rio
end
--     Source Storm     --
local sendRequest = function(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra)
tdcli_function({ ID = request_id, chat_id_ = chat_id, reply_to_message_id_ = reply_to_message_id, disable_notification_ = disable_notification, from_background_ = from_background, reply_markup_ = reply_markup, input_message_content_ = input_message_content }, callback or dl_cb, extra)
end
local sendDocument = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, cb, cmd)
local input_message_content = { ID = "InputMessageDocument", document_ = getInputFile(document), caption_ = caption } sendRequest("SendMessage", chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)
local input_message_content = { ID = "InputMessageVoice", voice_ = getInputFile(voice), duration_ = duration or 0, waveform_ = waveform, caption_ = caption } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local function sendAudio(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, audio, duration, waveform, caption, cb, cmd)
local input_message_content = { ID = "InputMessageAudio", audio_ = getInputFile(audio), duration_ = duration or 0, waveform_ = waveform, caption_ = caption } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
local sendSticker = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker)
local input_message_content = { ID = "InputMessageSticker", sticker_ = getInputFile(sticker), width_ = 0, height_ = 0 } sendRequest("SendMessage", chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end 
function formsgs(msgs) 
local MsgText = ''  
if tonumber(msgs) < 100 then 
MsgText = 'ุฌุฏุง ุถุนูู' 
elseif tonumber(msgs) < 250 then 
MsgText = 'ุถุนูู' 
elseif tonumber(msgs) < 500 then 
MsgText = 'ุบูุฑ ูุชูุงุนู' 
elseif tonumber(msgs) < 750 then 
MsgText = 'ูุชูุณุท' 
elseif tonumber(msgs) < 1000 then 
MsgText = 'ูุชูุงุนู' 
elseif tonumber(msgs) < 2000 then 
MsgText = 'ููุฉ ุงูุชูุงุนู' 
elseif tonumber(msgs) < 3000 then 
MsgText = 'ููู ุงูุชูุงุนู'  
elseif tonumber(msgs) < 4000 then 
MsgText = 'ุงุณุทูุฑุฉ ุงูุชูุงุนู' 
elseif tonumber(msgs) < 5000 then 
MsgText = 'ูุชูุงุนู ูุงุฑ' 
elseif tonumber(msgs) < 6000 then 
MsgText = 'ูุฌุฏุญ ุฌุฏุญ' 
elseif tonumber(msgs) < 7000 then 
MsgText = 'ุฎูุงูู' 
elseif tonumber(msgs) < 8000 then 
MsgText = 'ุฑุจ ุงูุชูุงุนู' 
elseif tonumber(msgs) < 9000 then 
MsgText = 'ูุงูุฑ ุจุงูุชูุงุนู' 
elseif tonumber(msgs) < 0000000000 then 
MsgText = "ูุนูู ูุฑุจู" 
end 
return MsgText
end
--     Source Storm     --
function riomoned(chat_id, user_id, msg_id, text, offset, length) local tt = DevRio:get(storm..'endmsg') or '' tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = msg_id, disable_notification_ = 0, from_background_ = 1, reply_markup_ = nil, input_message_content_ = { ID = "InputMessageText", text_ = text..'\n\n'..tt, disable_web_page_preview_ = 1, clear_draft_ = 0, entities_ = {[0]={ ID="MessageEntityMentionName", offset_=offset, length_=length, user_id_=user_id }, }, }, }, dl_cb, nil) end
--     Source Storm     --
function ChCheck(msg)
local var = true 
if DevRio:get(storm.."Rio:ChId") then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getchatmember?chat_id='..DevRio:get(storm..'Rio:ChId')..'&user_id='..msg.sender_user_id_)
local data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false 
if DevRio:get(storm..'Rio:ChText') then
local ChText = DevRio:get(storm..'Rio:ChText')
send(msg.chat_id_,msg.id_,'['..ChText..']')
else
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..DevRio:get(storm.."Rio:ChId"))
local GetInfo = JSON.decode(Check)
if GetInfo.result.username then
User = "https://t.me/"..GetInfo.result.username
else
User = GetInfo.result.invite_link
end
Text = "*โ๏ธุนุฐุฑุง ูุงุชุณุชุทูุน ุงุณุชุฎุฏุงู ุงูุจูุช !\nโ๏ธุนููู ุงูุงุดุชุฑุงู ูู ุงูููุงุฉ ุงููุง :*"
keyboard = {} 
keyboard.inline_keyboard = {{{text=GetInfo.result.title,url=User}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
elseif data.ok then
return var
end
else
return var
end
end
--     Source Storm     --
function tdcli_update_callback(data)
if (data.ID == "UpdateNewCallbackQuery") then
local Chat_Id2 = data.chat_id_
local MsgId2 = data.message_id_
local DataText = data.payload_.data_
local Msg_Id2 = data.message_id_/2097152/0.5
if DataText == '/delyes' and DevRio:get(storm..'yes'..data.sender_user_id_) == 'delyes' then
DevRio:del(storm..'yes'..data.sender_user_id_, 'delyes')
DevRio:del(storm..'no'..data.sender_user_id_, 'delno')
if RankChecking(data.sender_user_id_, data.chat_id_) then
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธูุง ุงุณุชุทูุน ุทุฑุฏ โคฝ "..IdRank(data.sender_user_id_, data.chat_id_)) 
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=data.chat_id_,user_id_=data.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,da) 
if (da and da.code_ and da.code_ == 400 and da.message_ == "CHAT_ADMIN_REQUIRED") then 
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธููุณ ูุฏู ุตูุงุญูุฉ ุญุธุฑ ุงููุณุชุฎุฏููู ูุฑุฌู ุชูุนูููุง !") 
return false  
end
if (da and da.code_ and da.code_ == 3) then 
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุงูุจูุช ููุณ ุงุฏูู ูุฑุฌู ุชุฑููุชู !") 
return false  
end
if da and da.code_ and da.code_ == 400 and da.message_ == "USER_ADMIN_INVALID" then 
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธูุง ุงุณุชุทูุน ุทุฑุฏ ูุดุฑููู ุงููุฌููุนู") 
return false  
end
if da and da.ID and da.ID == "Ok" then
ChatKick(data.chat_id_, data.sender_user_id_)
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุชู ุทุฑุฏู ูู ุงููุฌููุนู") 
return false
end
end,nil)  
end
if DataText == '/delno' and DevRio:get(storm..'no'..data.sender_user_id_) == 'delno' then
DevRio:del(storm..'yes'..data.sender_user_id_, 'delyes')
DevRio:del(storm..'no'..data.sender_user_id_, 'delno')
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุชู ุงูุบุงุก ุงูุฑ ุงุทุฑุฏูู") 
end
--     Source Storm     --
if DataText == '/yesdel' and DevRio:get(storm..'yesdel'..data.sender_user_id_) == 'delyes' then
DevRio:del(storm..'yesdel'..data.sender_user_id_, 'delyes')
DevRio:del(storm..'nodel'..data.sender_user_id_, 'delno')
if DevRio:sismember(storm..'Rio:Constructor:'..data.chat_id_, data.sender_user_id_) then
constructor = 'ุงูููุดุฆูู โข ' else constructor = '' end 
if DevRio:sismember(storm..'Rio:Managers:'..data.chat_id_, data.sender_user_id_) then
Managers = 'ุงููุฏุฑุงุก โข ' else Managers = '' end
if DevRio:sismember(storm..'Rio:Admins:'..data.chat_id_, data.sender_user_id_) then
admins = 'ุงูุงุฏูููู โข ' else admins = '' end
if DevRio:sismember(storm..'Rio:VipMem:'..data.chat_id_, data.sender_user_id_) then
vipmem = 'ุงููููุฒูู โข ' else vipmem = '' end
if DevRio:sismember(storm..'Rio:Cleaner:'..data.chat_id_, data.sender_user_id_) then
cleaner = 'ุงูููุธููู โข ' else cleaner = '' end
if DevRio:sismember(storm..'User:Donky:'..data.chat_id_, data.sender_user_id_) then
donky = 'ุงููุทุงูู โข ' else donky = '' end
if DevRio:sismember(storm..'Rio:Constructor:'..data.chat_id_, data.sender_user_id_) or DevRio:sismember(storm..'Rio:Managers:'..data.chat_id_, data.sender_user_id_) or DevRio:sismember(storm..'Rio:Admins:'..data.chat_id_, data.sender_user_id_) or DevRio:sismember(storm..'Rio:VipMem:'..data.chat_id_, data.sender_user_id_) or DevRio:sismember(storm..'Rio:Cleaner:'..data.chat_id_, data.sender_user_id_) or DevRio:sismember(storm..'User:Donky:'..data.chat_id_, data.sender_user_id_) then
DevRio:srem(storm..'Rio:Constructor:'..data.chat_id_,data.sender_user_id_)
DevRio:srem(storm..'Rio:Managers:'..data.chat_id_,data.sender_user_id_)
DevRio:srem(storm..'Rio:Admins:'..data.chat_id_,data.sender_user_id_)
DevRio:srem(storm..'Rio:VipMem:'..data.chat_id_,data.sender_user_id_)
DevRio:srem(storm..'Rio:Cleaner:'..data.chat_id_,data.sender_user_id_)
DevRio:srem(storm..'User:Donky:'..data.chat_id_,data.sender_user_id_)
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุชู ุชูุฒููู ูู โคฝ โค\n~ ( "..constructor..Managers..admins..vipmem..cleaner..donky.." ) ~ \n") 
else 
if IdRank(data.sender_user_id_, data.chat_id_) == 'ุงูุนุถู' then
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธููุณ ูุฏูู ุฑุชุจู ูู ุงูุจูุช") 
else 
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธูุง ุงุณุชุทูุน ุชูุฒูู โคฝ "..IdRank(data.sender_user_id_, data.chat_id_)) 
end
end
end
if DevRio:get(storm.."Rio:NewDev"..data.sender_user_id_) then
if DataText == '/setno' then
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุชู ุงูุบุงุก ุงูุฑ ุชุบูุฑ ุงููุทูุฑ ุงูุงุณุงุณู") 
DevRio:del(storm.."Rio:NewDev"..data.sender_user_id_)
return false
end
if DataText == '/setyes' then
local NewDev = DevRio:get(storm.."Rio:NewDev"..data.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = NewDev},function(arg,dp) 
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุงููุทูุฑ ุงูุฌุฏูุฏ โคฝ ["..dp.first_name_.."](tg://user?id="..dp.id_..")\nโ๏ธุชู ุชุบูุฑ ุงููุทูุฑ ุงูุงุณุงุณู ุจูุฌุงุญ") 
end,nil)
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_},function(arg,dp) 
SendText(NewDev,"โ๏ธุจูุงุณุทุฉ โคฝ ["..dp.first_name_.."](tg://user?id="..dp.id_..")\nโ๏ธููุฏ ุงุตุจุญุช ุงูุช ูุทูุฑ ูุฐุง ุงูุจูุช",0,'md')
end,nil)
local Create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Config"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)
file:close()  
end
Config = {
DevId = NewDev,
TokenBot = TokenBot,
storm = TokenBot:match("(%d+)"),
SudoIds = {NewDev},
}
Create(Config, "./config.lua")  
DevRio:del(storm.."Rio:NewDev"..data.sender_user_id_)
dofile('storm.lua') 
end
end
if DataText == '/nodel' and DevRio:get(storm..'nodel'..data.sender_user_id_) == 'delno' then
DevRio:del(storm..'yesdel'..data.sender_user_id_, 'delyes')
DevRio:del(storm..'nodel'..data.sender_user_id_, 'delno')
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุชู ุงูุบุงุก ุงูุฑ ูุฒููู") 
end
if DataText == '/YesRolet' and DevRio:get(storm.."Rio:WittingStartRolet"..data.chat_id_..data.sender_user_id_) then
local List = DevRio:smembers(storm..'Rio:ListRolet'..data.chat_id_) 
local UserName = List[math.random(#List)]
tdcli_function ({ID="SearchPublicChat",username_ = UserName},function(arg,dp) 
DevRio:incrby(storm..'Rio:GamesNumber'..data.chat_id_..dp.id_, 5) 
end,nil) 
DevRio:del(storm..'Rio:ListRolet'..data.chat_id_) 
DevRio:del(storm.."Rio:WittingStartRolet"..data.chat_id_..data.sender_user_id_)
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธ*ุตุงุญุจ ุงูุญุธ* โคฝ ["..UserName.."]\nโ๏ธ*ูุจุฑูู ููุฏ ุฑุจุญุช ูุญุตูุช ุนูู 5 ููุงุท ููููู ุงุณุชุจุฏุงููุง ุจุงูุฑุณุงุฆู*")
end
if DataText == '/NoRolet' then
DevRio:del(storm..'Rio:ListRolet'..data.chat_id_) 
DevRio:del(storm.."Rio:NumRolet"..data.chat_id_..data.sender_user_id_) 
DevRio:del(storm.."Rio:WittingStartRolet"..data.chat_id_..data.sender_user_id_)
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุชู ุงูุบุงุก ุงููุนุจู ูุงุนุงุฏุฉ ุงููุนุจ ุงุฑุณู ุงูุงูุนุงุจ") 
end
if DataText == '/ListRolet' then
local List = DevRio:smembers(storm..'Rio:ListRolet'..data.chat_id_) 
local Text = 'โ๏ธูุงุฆูุฉ ุงูุงุนุจูู โคฝ โค\nโ โ โ โ โ โ โ โ โ\n' 
local Textt = 'โ โ โ โ โ โ โ โ โ\nโ๏ธุชู ุงูุชูุงู ุงูุนุฏุฏ ุงูููู ูู ุงูุช ูุณุชุนุฏ ุ'
for k, v in pairs(List) do 
Text = Text..k.."~ : [" ..v.."]\n"  
end 
keyboard = {} 
keyboard.inline_keyboard = {{{text="ูุนู",callback_data="/YesRolet"},{text="ูุง",callback_data="/NoRolet"}}} 
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Text..Textt).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if DataText == '/UnTkeed' then
if DevRio:sismember(storm..'Rio:Tkeed:'..Chat_Id2, data.sender_user_id_) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..Chat_Id2.."&user_id="..data.sender_user_id_.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevRio:srem(storm..'Rio:Tkeed:'..Chat_Id2, data.sender_user_id_)
DeleteMessage(Chat_Id2,{[0] = MsgId2})
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุชู ุงูุบุงุก ุชููุฏู ูู ุงููุฌููุนู ุจูุฌุงุญ .")..'&show_alert=true')
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ูุฐุง ุงูุงูุฑ ููุดู ุงูุฑูุจูุช ูููุณ ูู .")..'&show_alert=true')
end 
end
if DataText and DataText:match('/DelRed:'..tonumber(data.sender_user_id_)..'(.*)') then
local Rio = DataText:match('/DelRed:'..tonumber(data.sender_user_id_)..'(.*)')
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุงููููู โคฝ "..Rio.." ุชู ุญุฐููุง") 
DevRio:del(storm..'Rio:Text:GpTexts'..Rio..data.chat_id_)
DevRio:srem(storm..'Rio:Manager:GpRedod'..data.chat_id_,Rio)
end
if DataText and DataText:match('/EndRedod:'..tonumber(data.sender_user_id_)..'(.*)') then
local Rio = DataText:match('/EndRedod:'..tonumber(data.sender_user_id_)..'(.*)')
local List = DevRio:smembers(storm..'Rio:Text:GpTexts'..Rio..data.chat_id_)
if DevRio:get(storm..'Rio:Add:GpRedod'..data.sender_user_id_..data.chat_id_) then
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุชู ุงููุงุก ูุญูุธ โคฝ "..#List.." ูู ุงูุฑุฏูุฏ ุงููุชุนุฏุฏู ููุงูุฑ โคฝ "..Rio) 
DevRio:del(storm..'Rio:Add:GpRedod'..data.sender_user_id_..data.chat_id_)
else
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุนุฐุฑุง ุตูุงุญูุฉ ุงูุงูุฑ ููุชููู !") 
end
end
if DataText and DataText:match('/DelRedod:'..tonumber(data.sender_user_id_)..'(.*)') then
local Rio = DataText:match('/DelRedod:'..tonumber(data.sender_user_id_)..'(.*)')
if DevRio:get(storm..'Rio:Add:GpRedod'..data.sender_user_id_..data.chat_id_) then
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุชู ุงูุบุงุก ุนูููุฉ ุญูุธ ุงูุฑุฏูุฏ ุงููุชุนุฏุฏู ููุงูุฑ โคฝ "..Rio) 
DevRio:del(storm..'Rio:Add:GpRedod'..data.sender_user_id_..data.chat_id_)
DevRio:del(storm..'Rio:Text:GpTexts'..Rio..data.chat_id_)
DevRio:del(storm..'Rio:Add:GpTexts'..data.sender_user_id_..data.chat_id_)
DevRio:srem(storm..'Rio:Manager:GpRedod'..data.chat_id_,Rio)
else
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุนุฐุฑุง ุตูุงุญูุฉ ุงูุงูุฑ ููุชููู !") 
end
end
if DataText and DataText:match('/HideHelpList:(.*)') then
local Rio = DataText:match('/HideHelpList:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
EditMsg(Chat_Id2, Msg_Id2, "โ๏ธุชู ุงุฎูุงุก ูููุดุฉ ุงูุงูุงูุฑ") 
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ุงูุงูุฑ ููุณ ูู .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList:(.*)') then
local Rio = DataText:match('/HelpList:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
local Help = DevRio:get(storm..'Rio:Help')
local Text = [[
โ๏ธุงููุง ุจู ูู ูุงุฆูุฉ ุงูุงูุงูุฑ โคฝ โค 
โ โ โ โ โ โ โ โ โ
โ๏ธู1 โคฝ ุงูุงูุฑ ุงูุญูุงูู
โ๏ธู2 โคฝ ุงูุงูุฑ ุงูุงุฏูููู
โ๏ธู3 โคฝ ุงูุงูุฑ ุงููุฏุฑุงุก
โ๏ธู4 โคฝ ุงูุงูุฑ ุงูููุดุฆูู
โ๏ธู5 โคฝ ุงูุงูุฑ ุงููุทูุฑูู
โ๏ธู6 โคฝ ุงูุงูุฑ ุงูุงุนุถุงุก
โ โ โ โ โ โ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]] 
keyboard = {} 
keyboard.inline_keyboard = {{{text="ุงูุงูุฑ ุงูุงุฏูููู",callback_data="/HelpList2:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงูุญูุงูู",callback_data="/HelpList1:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงูููุดุฆูู",callback_data="/HelpList4:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงููุฏุฑุงุก",callback_data="/HelpList3:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงูุงุนุถุงุก",callback_data="/HelpList6:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงููุทูุฑูู",callback_data="/HelpList5:"..data.sender_user_id_}},{{text="โข ุงุฎูุงุก ุงููููุดู โข",callback_data="/HideHelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ุงูุงูุฑ ููุณ ูู .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList1:(.*)') then
local Rio = DataText:match('/HelpList1:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ููุณ ูุฏูู ุตูุงุญูุฉ ุงูุชุญูู ููุฐุง ุงูุงูุฑ .")..'&show_alert=true')
end
local Help = DevRio:get(storm..'Rio:Help1')
local Text = [[
โ๏ธุงูุงูุฑ ุญูุงูุฉ ุงููุฌููุนู โคฝ โค
โ โ โ โ โ โ โ โ โ
โ๏ธููู โข ูุชุญ โคฝ ุงูุฑูุงุจุท
โ๏ธููู โข ูุชุญ โคฝ ุงููุนุฑูุงุช
โ๏ธููู โข ูุชุญ โคฝ ุงูุจูุชุงุช
โ๏ธููู โข ูุชุญ โคฝ ุงููุชุญุฑูู
โ๏ธููู โข ูุชุญ โคฝ ุงูููุตูุงุช
โ๏ธููู โข ูุชุญ โคฝ ุงููููุงุช
โ๏ธููู โข ูุชุญ โคฝ ุงูุตูุฑ
โ๏ธููู โข ูุชุญ โคฝ ุงูููุฏูู
โ๏ธููู โข ูุชุญ โคฝ ุงูุงูููุงูู
โ๏ธููู โข ูุชุญ โคฝ ุงูุฏุฑุฏุดู
โ๏ธููู โข ูุชุญ โคฝ ุงูุชูุฌูู
โ๏ธููู โข ูุชุญ โคฝ ุงูุงุบุงูู
โ๏ธููู โข ูุชุญ โคฝ ุงูุตูุช
โ๏ธููู โข ูุชุญ โคฝ ุงูุฌูุงุช
โ๏ธููู โข ูุชุญ โคฝ ุงููุงุฑูุฏุงูู
โ๏ธููู โข ูุชุญ โคฝ ุงูุชูุฑุงุฑ
โ๏ธููู โข ูุชุญ โคฝ ุงููุงุดุชุงู
โ๏ธููู โข ูุชุญ โคฝ ุงูุชุนุฏูู
โ๏ธููู โข ูุชุญ โคฝ ุงูุชุซุจูุช
โ๏ธููู โข ูุชุญ โคฝ ุงูุงุดุนุงุฑุงุช
โ๏ธููู โข ูุชุญ โคฝ ุงูููุงูุด
โ๏ธููู โข ูุชุญ โคฝ ุงูุฏุฎูู
โ๏ธููู โข ูุชุญ โคฝ ุงูุดุจูุงุช
โ๏ธููู โข ูุชุญ โคฝ ุงูููุงูุน
โ๏ธููู โข ูุชุญ โคฝ ุงููุดุงุฑ
โ๏ธููู โข ูุชุญ โคฝ ุงูููุฑ
โ๏ธููู โข ูุชุญ โคฝ ุงูุทุงุฆููู
โ๏ธููู โข ูุชุญ โคฝ ุงููู
โ๏ธููู โข ูุชุญ โคฝ ุงูุนุฑุจูู
โ๏ธููู โข ูุชุญ โคฝ ุงูุงููููุฒูู
โ๏ธููู โข ูุชุญ โคฝ ุงููุงุฑุณูู
โ๏ธููู โข ูุชุญ โคฝ ุงูุชูููุด
โ โ โ โ โ โ โ โ โ
โ๏ธุงูุงูุฑ ุญูุงูู ุงุฎุฑู โคฝ โค
โ โ โ โ โ โ โ โ โ
โ๏ธููู โข ูุชุญ + ุงูุงูุฑ โคฝ โค
โ๏ธุงูุชูุฑุงุฑ ุจุงูุทุฑุฏ
โ๏ธุงูุชูุฑุงุฑ ุจุงููุชู
โ๏ธุงูุชูุฑุงุฑ ุจุงูุชููุฏ
โ๏ธุงููุงุฑุณูู ุจุงูุทุฑุฏ
โ๏ธุงูุจูุชุงุช ุจุงูุทุฑุฏ
โ๏ธุงูุจูุชุงุช ุจุงูุชููุฏ
โ โ โ โ โ โ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="ุงูุงูุฑ ุงูุงุฏูููู",callback_data="/HelpList2:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงูููุดุฆูู",callback_data="/HelpList4:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงููุฏุฑุงุก",callback_data="/HelpList3:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงูุงุนุถุงุก",callback_data="/HelpList6:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงููุทูุฑูู",callback_data="/HelpList5:"..data.sender_user_id_}},{{text="โข ุงุฎูุงุก ุงููููุดู โข",callback_data="/HideHelpList:"..data.sender_user_id_}},{{text="โข ุฑุฌูุน โข",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ุงูุงูุฑ ููุณ ูู .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList2:(.*)') then
local Rio = DataText:match('/HelpList2:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ููุณ ูุฏูู ุตูุงุญูุฉ ุงูุชุญูู ููุฐุง ุงูุงูุฑ .")..'&show_alert=true')
end
local Help = DevRio:get(storm..'Rio:Help2')
local Text = [[
โ๏ธุงูุงูุฑ ุงูุงุฏูููู โคฝ โค
โ โ โ โ โ โ โ โ โ
โ๏ธุงูุงุนุฏุงุฏุช
โ๏ธุชุงู ูููู 
โ๏ธุงูุดุงุก ุฑุงุจุท
โ๏ธุถุน ูุตู
โ๏ธุถุน ุฑุงุจุท
โ๏ธุถุน ุตูุฑู
โ๏ธุญุฐู ุงูุฑุงุจุท
โ๏ธุญุฐู ุงููุทุงูู
โ๏ธูุดู ุงูุจูุชุงุช
โ๏ธุทุฑุฏ ุงูุจูุชุงุช
โ๏ธุชูุธูู + ุงูุนุฏุฏ
โ๏ธุชูุธูู ุงูุชุนุฏูู
โ๏ธููููู + ุงููููู
โ๏ธุงุณู ุงูุจูุช + ุงูุงูุฑ
โ๏ธุถุน โข ุญุฐู โคฝ ุชุฑุญูุจ
โ๏ธุถุน โข ุญุฐู โคฝ ููุงููู
โ๏ธุงุถู โข ุญุฐู โคฝ ุตูุงุญูู
โ๏ธุงูุตูุงุญูุงุช โข ุญุฐู ุงูุตูุงุญูุงุช
โ โ โ โ โ โ โ โ โ
โ๏ธุถุน ุณุจุงู + ุงูุนุฏุฏ
โ๏ธุถุน ุชูุฑุงุฑ + ุงูุนุฏุฏ
โ โ โ โ โ โ โ โ โ
โ๏ธุฑูุน ูููุฒ โข ุชูุฒูู ูููุฒ
โ๏ธุงููููุฒูู โข ุญุฐู ุงููููุฒูู
โ๏ธูุดู ุงููููุฏ โข ุฑูุน ุงููููุฏ
โ โ โ โ โ โ โ โ โ
โ๏ธุญุฐู โข ูุณุญ + ุจุงูุฑุฏ
โ๏ธููุน โข ุงูุบุงุก ููุน
โ๏ธูุงุฆูู ุงูููุน
โ๏ธุญุฐู ูุงุฆูู ุงูููุน
โ โ โ โ โ โ โ โ โ
โ๏ธุชูุนูู โข ุชุนุทูู โคฝ ุงูุฑุงุจุท
โ๏ธุชูุนูู โข ุชุนุทูู โคฝ ุงูุงูุนุงุจ
โ๏ธุชูุนูู โข ุชุนุทูู โคฝ ุงูุชุฑุญูุจ
โ๏ธุชูุนูู โข ุชุนุทูู โคฝ ุงูุชุงู ูููู
โ๏ธุชูุนูู โข ุชุนุทูู โคฝ ูุดู ุงูุงุนุฏุงุฏุงุช
โ โ โ โ โ โ โ โ โ
โ๏ธุทุฑุฏ ุงููุญุฐูููู
โ๏ธุทุฑุฏ โคฝ ุจุงูุฑุฏ โข ุจุงููุนุฑู โข ุจุงูุงูุฏู
โ๏ธูุชู โข ุงูุบุงุก ูุชู
โ๏ธุชููุฏ โข ุงูุบุงุก ุชููุฏ
โ๏ธุญุธุฑ โข ุงูุบุงุก ุญุธุฑ
โ๏ธุงูููุชูููู โข ุญุฐู ุงูููุชูููู
โ๏ธุงููููุฏูู โข ุญุฐู ุงููููุฏูู
โ๏ธุงููุญุธูุฑูู โข ุญุฐู ุงููุญุธูุฑูู
โ โ โ โ โ โ โ โ โ
โ๏ธุชูููุฏ ุฏูููู + ุนุฏุฏ ุงูุฏูุงุฆู
โ๏ธุชูููุฏ ุณุงุนู + ุนุฏุฏ ุงูุณุงุนุงุช
โ๏ธุชูููุฏ ููู + ุนุฏุฏ ุงูุงูุงู
โ๏ธุงูุบุงุก ุชูููุฏ โคฝ ูุงูุบุงุก ุงูุชูููุฏ ุจุงูููุช
โ โ โ โ โ โ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="ุงูุงูุฑ ุงูุญูุงูู",callback_data="/HelpList1:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงูููุดุฆูู",callback_data="/HelpList4:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงููุฏุฑุงุก",callback_data="/HelpList3:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงูุงุนุถุงุก",callback_data="/HelpList6:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงููุทูุฑูู",callback_data="/HelpList5:"..data.sender_user_id_}},{{text="โข ุงุฎูุงุก ุงููููุดู โข",callback_data="/HideHelpList:"..data.sender_user_id_}},{{text="โข ุฑุฌูุน โข",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ุงูุงูุฑ ููุณ ูู .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList3:(.*)') then
local Rio = DataText:match('/HelpList3:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ููุณ ูุฏูู ุตูุงุญูุฉ ุงูุชุญูู ููุฐุง ุงูุงูุฑ .")..'&show_alert=true')
end
local Help = DevRio:get(storm..'Rio:Help3')
local Text = [[
โ๏ธุงูุงูุฑ ุงููุฏุฑุงุก โคฝ โค
โ โ โ โ โ โ โ โ โ
โ๏ธูุญุต ุงูุจูุช
โ๏ธุถุน ุงุณู + ุงูุงุณู
โ๏ธุงุถู โข ุญุฐู โคฝ ุฑุฏ
โ๏ธุฑุฏูุฏ ุงููุฏูุฑ
โ๏ธุญุฐู ุฑุฏูุฏ ุงููุฏูุฑ
โ๏ธุงุถู โข ุญุฐู โคฝ ุฑุฏ ูุชุนุฏุฏ
โ๏ธุญุฐู ุฑุฏ ูู ูุชุนุฏุฏ
โ๏ธุงูุฑุฏูุฏ ุงููุชุนุฏุฏู
โ๏ธุญุฐู ุงูุฑุฏูุฏ ุงููุชุนุฏุฏู
โ๏ธุญุฐู ููุงุฆู ุงูููุน
โ๏ธููุน โคฝ ุจุงูุฑุฏ ุนูู ( ููุตู โข ุตูุฑู โข ูุชุญุฑูู )
โ๏ธุญุฐู ูุงุฆูู ููุน + โคฝ โค
( ุงูุตูุฑ โข ุงููุชุญุฑูุงุช โข ุงูููุตูุงุช )
โ โ โ โ โ โ โ โ โ
โ๏ธุชูุฒูู ุงููู
โ๏ธุฑูุน ุงุฏูู โข ุชูุฒูู ุงุฏูู
โ๏ธุงูุงุฏูููู โข ุญุฐู ุงูุงุฏูููู
โ โ โ โ โ โ โ โ โ
โ๏ธุชุซุจูุช
โ๏ธุงูุบุงุก ุงูุชุซุจูุช
โ๏ธุงุนุงุฏู ุงูุชุซุจูุช
โ๏ธุงูุบุงุก ุชุซุจูุช ุงููู
โ โ โ โ โ โ โ โ โ
โ๏ธุชุบูุฑ ุฑุฏ + ุงุณู ุงูุฑุชุจู + ุงููุต โคฝ โค
โ๏ธุงููุทูุฑ โข ููุดุฆ ุงูุงุณุงุณู
โ๏ธุงูููุดุฆ โข ุงููุฏูุฑ โข ุงูุงุฏูู
โ๏ธุงููููุฒ โข ุงูููุธู โข ุงูุนุถู
โ๏ธุญุฐู ุฑุฏูุฏ ุงูุฑุชุจ
โ โ โ โ โ โ โ โ โ
โ๏ธุชุบููุฑ ุงูุงูุฏู โคฝ ูุชุบููุฑ ุงููููุดู
โ๏ธุชุนููู ุงูุงูุฏู โคฝ ูุชุนููู ุงููููุดู
โ๏ธุญุฐู ุงูุงูุฏู โคฝ ูุญุฐู ุงููููุดู
โ โ โ โ โ โ โ โ โ
โ๏ธุชูุนูู โข ุชุนุทูู + ุงูุงูุฑ โคฝ โค
โ๏ธุงุทุฑุฏูู โข ุงูุงูุฏู ุจุงูุตูุฑู โข ุงูุงุจุฑุงุฌ
โ๏ธูุนุงูู ุงูุงุณูุงุก โข ุงูุงูุฑ ุงููุณุจ โข ุงูุทู
โ๏ธุงูุงูุฏู โข ุชุญููู ุงูุตูุบ โข ุงูุงูุฑ ุงูุชุญุดูุด
โ๏ธุฑุฏูุฏ ุงููุฏูุฑ โข ุฑุฏูุฏ ุงููุทูุฑ โข ุงูุชุญูู
โ๏ธุถุงููู โข ุญุณุงุจ ุงูุนูุฑ โข ุงูุฒุฎุฑูู
โ โ โ โ โ โ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="ุงูุงูุฑ ุงูุงุฏูููู",callback_data="/HelpList2:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงูุญูุงูู",callback_data="/HelpList1:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงูููุดุฆูู",callback_data="/HelpList4:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงูุงุนุถุงุก",callback_data="/HelpList6:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงููุทูุฑูู",callback_data="/HelpList5:"..data.sender_user_id_}},{{text="โข ุงุฎูุงุก ุงููููุดู โข",callback_data="/HideHelpList:"..data.sender_user_id_}},{{text="โข ุฑุฌูุน โข",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ุงูุงูุฑ ููุณ ูู .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList4:(.*)') then
local Rio = DataText:match('/HelpList4:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ููุณ ูุฏูู ุตูุงุญูุฉ ุงูุชุญูู ููุฐุง ุงูุงูุฑ .")..'&show_alert=true')
end
local Help = DevRio:get(storm..'Rio:Help4')
local Text = [[
โโ๏ธุงูุงูุฑ ุงูููุดุฆูู โคฝ โค
โ โ โ โ โโโโ โ โ โ 
โฏโโ๏ธุชูุฒูู ุงููู
โฏโโ๏ธุงูููุฏูุง โข ุงูุณุญ
โโฏโ๏ธุชุนูู ุนุฏุฏ ุงูุญุฐู
โโฏโ๏ธุชุฑุชูุจ ุงูุงูุงูุฑ
โโฏโ๏ธุงุถู โข ุญุฐู โคฝ ุงูุฑ
โฏโโ๏ธุญุฐู ุงูุงูุงูุฑ ุงููุถุงูู
โฏโโ๏ธุงูุงูุงูุฑ ุงููุถุงูู
โฏโโ๏ธุงุถู ููุงุท โคฝ ุจุงูุฑุฏ โข ุจุงูุงูุฏู
โโฏโ๏ธุงุถู ุฑุณุงุฆู โคฝ ุจุงูุฑุฏ โข ุจุงูุงูุฏู
โฏโโ๏ธุฑูุน ููุธู โข ุชูุฒูู ููุธู
โโฏโ๏ธุงูููุธููู โข ุญุฐู ุงูููุธููู
โโฏโ๏ธุฑูุน ูุฏูุฑ โข ุชูุฒูู ูุฏูุฑ
โโฏโ๏ธุงููุฏุฑุงุก โข ุญุฐู ุงููุฏุฑุงุก
โโฏโ๏ธุชูุนูู โข ุชุนุทูู + ุงูุงูุฑ โคฝ โค
โโฏโ๏ธูุฒููู โข ุงูุณุญ
โโฏโ๏ธุงูุญุธุฑ โข ุงููุชู
โ โ โ โ โโโโ โ โ โ 
โโฏโ๏ธุงูุงูุฑ ุงูููุดุฆูู ุงูุงุณุงุณููู โคฝ โค
โ โ โ โ โโโโ โ โ โ 
โโฏโ๏ธูุถุน ููุจ + ุงูููุจ
โโฏโ๏ธุชูุนูู โข ุชุนุทูู โคฝ ุงูุฑูุน
โโฏโ๏ธุฑูุน ููุดุฆ โข ุชูุฒูู ููุดุฆ
โโฏโ๏ธุงูููุดุฆูู โข ุญุฐู ุงูููุดุฆูู
โ๏ธุฑูุน โข ุชูุฒูู โคฝ ูุดุฑู
โโฏโ๏ธุฑูุน ุจูู ุงูุตูุงุญูุงุช
โโฏโ๏ธุญุฐู ุงูููุงุฆู
โ โ โ โ โโโโ โ โ โ 
โโฏโ๏ธุงูุงูุฑ ุงููุงูููู โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ููุดุฆ ุงุณุงุณู
โโฏโ๏ธุญุฐู ุงูููุดุฆูู ุงูุงุณุงุณููู 
โโฏโ๏ธุงูููุดุฆูู ุงูุงุณุงุณููู 
โโฏโ๏ธุญุฐู ุฌููุน ุงูุฑุชุจ
โ โ โ โ โโโโ โ โ โ 
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="ุงูุงูุฑ ุงูุงุฏูููู",callback_data="/HelpList2:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงูุญูุงูู",callback_data="/HelpList1:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงููุฏุฑุงุก",callback_data="/HelpList3:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงูุงุนุถุงุก",callback_data="/HelpList6:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงููุทูุฑูู",callback_data="/HelpList5:"..data.sender_user_id_}},{{text="โข ุงุฎูุงุก ุงููููุดู โข",callback_data="/HideHelpList:"..data.sender_user_id_}},{{text="โข ุฑุฌูุน โข",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ุงูุงูุฑ ููุณ ูู .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList5:(.*)') then
local Rio = DataText:match('/HelpList5:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ููุณ ูุฏูู ุตูุงุญูุฉ ุงูุชุญูู ููุฐุง ุงูุงูุฑ .")..'&show_alert=true')
end
local Help = DevRio:get(storm..'Rio:Help5')
local Text = [[
โโโ๏ธุงูุงูุฑ ุงููุทูุฑูู โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุงูุฌุฑูุจุงุช
โโฏโ๏ธุงููุทูุฑูู
โโฏโ๏ธุงููุดุชุฑููู
โโฏโ๏ธุงูุงุญุตุงุฆูุงุช
โโฏโ๏ธุงููุฌููุนุงุช
โโฏโ๏ธุงุณู ุงูุจูุช + ุบุงุฏุฑ
โโฏโ๏ธุงุณู ุงูุจูุช + ุชุนุทูู
โโฏโ๏ธูุดู + -ุงูุฏู ุงููุฌููุนู
โโฏโ๏ธุฑูุน ูุงูู โข ุชูุฒูู ูุงูู
โโฏโ๏ธุงููุงูููู โข ุญุฐู ุงููุงูููู
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ูุฏูุฑ ุนุงู
โโฏโ๏ธุญุฐู โข ุงููุฏุฑุงุก ุงูุนุงููู 
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ุงุฏูู ุนุงู
โโฏโ๏ธุญุฐู โข ุงูุงุฏูููู ุงูุนุงููู 
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ูููุฒ ุนุงู
โโฏโ๏ธุญุฐู โข ุงููููุฒูู ุนุงู 
โ โ โ โ โโโโ โ โ โ
โโโ๏ธุงูุงูุฑ ุงููุทูุฑ ุงูุงุณุงุณู โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุชุญุฏูุซ
โโฏโ๏ธุงููููุงุช
โโฏโ๏ธุงููุชุฌุฑ
โโฏโ๏ธุงูุณูุฑูุฑ
โโฏโ๏ธุฑูุงุจุท ุงูุฌุฑูุจุงุช
โโฏโ๏ธุชุญุฏูุซ ุงูุณูุฑุณ
โโฏโ๏ธุชูุธูู ุงูุฌุฑูุจุงุช
โโฏโ๏ธุชูุธูู ุงููุดุชุฑููู
โโฏโ๏ธุญุฐู ุฌููุน ุงููููุงุช
โโฏโ๏ธุชุนููู ุงูุงูุฏู ุงูุนุงู
โโฏโ๏ธุชุบูุฑ ุงููุทูุฑ ุงูุงุณุงุณู
โโฏโ๏ธุญุฐู ูุนูููุงุช ุงูุชุฑุญูุจ
โโฏโ๏ธุชุบูุฑ ูุนูููุงุช ุงูุชุฑุญูุจ
โโฏโ๏ธุบุงุฏุฑ + -ุงูุฏู ุงููุฌููุนู
โโฏโ๏ธุชุนููู ุนุฏุฏ ุงูุงุนุถุงุก + ุงูุนุฏุฏ
โโฏโ๏ธุญุธุฑ ุนุงู โข ุงูุบุงุก ุงูุนุงู
โโฏโ๏ธูุชู ุนุงู โข ุงูุบุงุก ุงูุนุงู
โโฏโ๏ธูุงุฆูู ุงูุนุงู โข ุญุฐู ูุงุฆูู ุงูุนุงู
โโฏโ๏ธูุถุน โข ุญุฐู โคฝ ุงุณู ุงูุจูุช
โโฏโ๏ธุงุถู โข ุญุฐู โคฝ ุฑุฏ ุนุงู
โโฏโ๏ธุฑุฏูุฏ ุงููุทูุฑ โข ุญุฐู ุฑุฏูุฏ ุงููุทูุฑ
โโฏโ๏ธุชุนููู โข ุญุฐู โข ุฌูุจ โคฝ ุฑุฏ ุงูุฎุงุต
โโฏโ๏ธุฌูุจ ูุณุฎู ุงูุฌุฑูุจุงุช
โโฏโ๏ธุฑูุน ุงููุณุฎู + ุจุงูุฑุฏ ุนูู ุงูููู
โโฏโ๏ธุชุนููู โข ุญุฐู โคฝ ููุงุฉ ุงูุงุดุชุฑุงู
โโฏโ๏ธุฌูุจ ูููุดู ุงูุงุดุชุฑุงู
โโฏโ๏ธุชุบููุฑ โข ุญุฐู โคฝ ูููุดู ุงูุงุดุชุฑุงู
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ูุทูุฑ
โโฏโ๏ธุงููุทูุฑูู โข ุญุฐู ุงููุทูุฑูู
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ูุทูุฑ ุซุงููู
โโฏโ๏ธุงูุซุงููููู โข ุญุฐู ุงูุซุงููููู
โโฏโ๏ธุชุนููู โข ุญุฐู โคฝ ูููุดุฉ ุงูุงูุฏู
โโฏโ๏ธุงุฐุงุนู ูููู ุจุงูุชูุฌูู โคฝ ุจุงูุฑุฏ
โ โ โ โ โโโ โ โ โ โ
โโฏโ๏ธุชูุนูู ููู + ุงุณู ุงูููู
โโฏโ๏ธุชุนุทูู ููู + ุงุณู ุงูููู
โโฏโ๏ธุชูุนูู โข ุชุนุทูู + ุงูุงูุฑ โคฝ โค
โโฏโ๏ธุงูุงุฐุงุนู โข ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู
โโฏโ๏ธุชุฑุญูุจ ุงูุจูุช โข ุงููุบุงุฏุฑู
โโฏโ๏ธุงูุจูุช ุงูุฎุฏูู โข ุงูุชูุงุตู
โ โ โ โ โโโ โ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="ุงูุงูุฑ ุงูุงุฏูููู",callback_data="/HelpList2:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงูุญูุงูู",callback_data="/HelpList1:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงูููุดุฆูู",callback_data="/HelpList4:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงููุฏุฑุงุก",callback_data="/HelpList3:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงูุงุนุถุงุก",callback_data="/HelpList6:"..data.sender_user_id_}},{{text="โข ุงุฎูุงุก ุงููููุดู โข",callback_data="/HideHelpList:"..data.sender_user_id_}},{{text="โข ุฑุฌูุน โข",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ุงูุงูุฑ ููุณ ูู .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList6:(.*)') then
local Rio = DataText:match('/HelpList6:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
local Help = DevRio:get(storm..'Rio:Help6')
local Text = [[
โโ๏ธุงูุงูุฑ ุงูุงุนุถุงุก โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุงูุณูุฑุณ โข ูููุนู โข ุฑุชุจุชู โข ูุนูููุงุชู 
โโฏโ๏ธุฑููู โข ููุจู โข ูุจุฐุชู โข ุตูุงุญูุงุชู โข ุบูููู
โโฏโ๏ธูููุฒ โข ูุชุญุฑูู โข ุตูุฑู โข ุฑูููุณ โข ููู โข ูุณูุณู โข ุงููู
โโฏโ๏ธุฑุณุงุฆูู โข ุญุฐู ุฑุณุงุฆูู โข ุงุณูู โข ูุนุฑูู 
โโฏโ๏ธุงูุฏู โขุงูุฏูู โข ุฌูุงุชู โข ุฑุงุณููู โข ุงูุงูุนุงุจ 
โโฏโ๏ธููุงุทู โข ุจูุน ููุงุทู โข ุงูููุงููู โข ุฒุฎุฑูู 
โโฏโ๏ธุฑุงุจุท ุงูุญุฐู โข ูุฒููู โข ุงุทุฑุฏูู โข ุงููุทูุฑ 
โโฏโ๏ธููู ุถุงููู โข ูุดุงูุฏุงุช ุงูููุดูุฑ โข ุงูุฑุงุจุท 
โโฏโ๏ธุงูุฏู ุงููุฌููุนู โข ูุนูููุงุช ุงููุฌููุนู 
โโฏโ๏ธูุณุจู ุงูุญุจ โข ูุณุจู ุงููุฑู โข ูุณุจู ุงูุบุจุงุก 
โโฏโ๏ธูุณุจู ุงูุฑุฌููู โข ูุณุจู ุงูุงููุซู โข ุงูุชูุงุนู
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธููุจู + ุจุงูุฑุฏ
โโฏโ๏ธููู + ุงููููู
โโฏโ๏ธุฒุฎุฑูู + ุงุณูู
โโฏโ๏ธุจุฑุฌ + ููุน ุงูุจุฑุฌ
โโฏโ๏ธูุนูู ุงุณู + ุงูุงุณู
โโฏโ๏ธุจูุณู โข ุจูุณูุง โคฝ ุจุงูุฑุฏ
โโฏโ๏ธุงุญุณุจ + ุชุงุฑูุฎ ูููุงุฏู
โโฏโ๏ธุฑูุน ูุทู โข ุชูุฒูู ูุทู โข ุงููุทุงูู
โโฏโ๏ธูููู โข ููููุง โคฝ ุจุงูุฑุฏ โข ุจุงููุนุฑู
โโฏโ๏ธุตูุญู โข ุตูุญูุง โคฝ ุจุงูุฑุฏ โข ุจุงููุนุฑู
โโฏโ๏ธุตูุงุญูุงุชู โคฝ ุจุงูุฑุฏ โข ุจุงููุนุฑู โข ุจุงูุงูุฏู
โโฏโ๏ธุงูุฏู โข ูุดู  โคฝ ุจุงูุฑุฏ โข ุจุงููุนุฑู โข ุจุงูุงูุฏู
โโฏโ๏ธุชุญููู + ุจุงูุฑุฏ โคฝ ุตูุฑู โข ููุตู โข ุตูุช โข ุจุตูู
โโฏโ๏ธุงูุทู + ุงูููุงู ุชุฏุนู ุฌููุน ุงููุบุงุช ูุน ุงูุชุฑุฌูู ููุนุฑุจู
โ โ โ โ โโโโ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="ุงูุงูุฑ ุงูุงุฏูููู",callback_data="/HelpList2:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงูุญูุงูู",callback_data="/HelpList1:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงูููุดุฆูู",callback_data="/HelpList4:"..data.sender_user_id_},{text="ุงูุงูุฑ ุงููุฏุฑุงุก",callback_data="/HelpList3:"..data.sender_user_id_}},{{text="ุงูุงูุฑ ุงููุทูุฑูู",callback_data="/HelpList5:"..data.sender_user_id_}},{{text="โข ุงุฎูุงุก ุงููููุดู โข",callback_data="/HideHelpList:"..data.sender_user_id_}},{{text="โข ุฑุฌูุน โข",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("โ ุนุฐุฑุง ุงูุงูุฑ ููุณ ูู .")..'&show_alert=true')
end
end
end
if (data.ID == "UpdateNewMessage") then
local msg = data.message_
text = msg.content_.text_ 
if text and DevRio:get(storm.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
local NewCmmd = DevRio:get(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":"..text)
if NewCmmd then
DevRio:del(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":"..text)
DevRio:del(storm.."Set:Cmd:Group:New"..msg.chat_id_)
DevRio:srem(storm.."List:Cmd:Group:New"..msg.chat_id_,text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญุฐู ุงูุงูุฑ ูู ุงููุฌููุนู", 1, 'html')  
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุงููุฌุฏ ุงูุฑ ุจูุฐุง ุงูุงุณู", 1, 'html')
end
DevRio:del(storm.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
if text and text:match('^'..(DevRio:get(storm..'Rio:NameBot') or "ุณุชูุฑู")..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..(DevRio:get(storm..'Rio:NameBot') or "ุณุชูุฑู")..' ','')
end
if data.message_.content_.text_ then
local NewCmmd = DevRio:get(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":"..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if text and DevRio:get(storm.."Set:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
DevRio:set(storm.."Set:Cmd:Group:New"..msg.chat_id_,text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ุงูุงูุฑ ุงูุฌุฏูุฏ", 1, 'html')
DevRio:del(storm.."Set:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_)
DevRio:set(storm.."Set:Cmd:Group1"..msg.chat_id_..":"..msg.sender_user_id_,"true1") 
return false
end
if text and DevRio:get(storm.."Set:Cmd:Group1"..msg.chat_id_..":"..msg.sender_user_id_) == "true1" then
local NewCmd = DevRio:get(storm.."Set:Cmd:Group:New"..msg.chat_id_)
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":"..text,NewCmd)
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ุงูุงูุฑ", 1, 'html')
DevRio:del(storm.."Set:Cmd:Group1"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
if Constructor(msg) then
if text == "ุงูุงูุงูุฑ ุงููุถุงูู" and ChCheck(msg) then
local List = DevRio:smembers(storm.."List:Cmd:Group:New"..msg.chat_id_.."") 
t = "โ๏ธูุงุฆูุฉ ุงูุงูุงูุฑ ุงููุถุงูู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
Cmds = DevRio:get(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":"..v)
if Cmds then 
t = t..k.."~ ("..v..") โข {"..Cmds.."}\n"
else
t = t..k.."~ ("..v..") \n"
end
end
if #List == 0 then
t = "โ๏ธูุงุชูุฌุฏ ุงูุงูุฑ ูุถุงูู ูู ุงููุฌููุนู"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
if text == "ุญุฐู ุงูุงูุงูุฑ ุงููุถุงูู" and ChCheck(msg) or text == "ุญุฐู ุงูุงูุงูุฑ" and ChCheck(msg) or text == "ูุณุญ ุงูุงูุงูุฑ ุงููุถุงูู" and ChCheck(msg) then
local List = DevRio:smembers(storm.."List:Cmd:Group:New"..msg.chat_id_)
for k,v in pairs(List) do
DevRio:del(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":"..v)
DevRio:del(storm.."List:Cmd:Group:New"..msg.chat_id_)
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญุฐู ุงูุงูุงูุฑ ุงููุถุงูู ูู ุงููุฌููุนู", 1, 'html')
end
if text == "ุชุฑุชูุจ ุงูุงูุงูุฑ" and Constructor(msg) and ChCheck(msg) then
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุง","ุงูุฏู")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุง")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ู","ุฑูุน ูููุฒ")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ู")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุงุฏ","ุฑูุน ุงุฏูู")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุงุฏ")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ูุฏ","ุฑูุน ูุฏูุฑ")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ูุฏ")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ูู","ุฑูุน ููุดุฆ")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ูู")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุงุณ","ุฑูุน ููุดุฆ ุงุณุงุณู")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุงุณ")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ูุท","ุฑูุน ูุทูุฑ")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ูุท")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุซุงููู","ุฑูุน ูุทูุฑ ุซุงููู")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุซุงููู")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุชู","ุชูุฒูู ุงููู")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุชู")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุชุนุท","ุชุนุทูู ุงูุงูุฏู ุจุงูุตูุฑู")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุชุนุท")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุชูุน","ุชูุนูู ุงูุงูุฏู ุจุงูุตูุฑู")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุชูุน")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุฑ","ุงูุฑุงุจุท")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุฑ")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุฑุฑ","ุฑุฏูุฏ ุงููุฏูุฑ")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุฑุฑ")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุุ","ูุณุญ ุงูููุชูููู")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุุ")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุฑุฏ","ุงุถู ุฑุฏ")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุฑุฏ")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุณุญ","ูุณุญ ุณุญูุงุชู")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุณุญ")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุฑุณ","ูุณุญ ุฑุณุงุฆูู")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุฑุณ")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":ุบ","ุบูููู")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"ุบ")
DevRio:set(storm.."Set:Cmd:Group:New1"..msg.chat_id_..":#","ูุณุญ ูุงุฆูู ุงูุนุงู")
DevRio:sadd(storm.."List:Cmd:Group:New"..msg.chat_id_,"#")
send(msg.chat_id_, msg.id_,"โ๏ธุชู ุชุฑุชูุจ ุงูุงูุงูุฑ ุจุงูุดูู ุงูุชุงูู ~\nโ๏ธ ุงูุฏู - ุง .\nโ๏ธ ุฑูุน ูููุฒ - ู .\nโ๏ธุฑูุน ุงุฏูู - ุงุฏ .\nโ๏ธ ุฑูุน ูุฏูุฑ - ูุฏ . \nโ๏ธ ุฑูุน ููุดู - ูู . \nโ๏ธ ุฑูุน ููุดุฆ ุงูุงุณุงุณู - ุงุณ  .\nโ๏ธ ุฑูุน ูุทูุฑ - ูุท .\nโ๏ธุฑูุน ูุทูุฑ ุซุงููู - ุซุงููู .\nโ๏ธ ุชูุฒูู ุงููู - ุชู .\nโ๏ธ ุชุนุทูู ุงูุงูุฏู ุจุงูุตูุฑู - ุชุนุท .\nโ๏ธ ุชูุนูู ุงูุงูุฏู ุจุงูุตูุฑู - ุชูุน .\nโ๏ธ ุงูุฑุงุจุท - ุฑ .\nโ๏ธ ุฑุฏูุฏ ุงููุฏูุฑ - ุฑุฑ .\nโ๏ธ ูุณุญ ุงูููุชูููู - ุุ .\nโ๏ธ ุงุถู ุฑุฏ - ุฑุฏ .\nโ๏ธ ูุณุญ ุณุญูุงุชู - ุณุญ .\nโ๏ธ ูุณุญ ุฑุณุงุฆูู - ุฑุณ .\nโ๏ธ ุบูููู - ุบ .\nโ๏ธูุณุญ ูุงุฆูู ุงูุนุงู - #")  
end
if text == "ุงุถู ุงูุฑ" and ChCheck(msg) or text == "ุงุถุงูุฉ ุงูุฑ" and ChCheck(msg) or text == "ุงุถุงูู ุงูุฑ" and ChCheck(msg) then
DevRio:set(storm.."Set:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ุงูุงูุฑ ุงููุฏูู", 1, 'html')
return false
end
if text == "ุญุฐู ุงูุฑ" and ChCheck(msg) or text == "ูุณุญ ุงูุฑ" and ChCheck(msg) then 
DevRio:set(storm.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ุงูุงูุฑ ุงูุฐู ููุช ุจุงุถุงูุชู ูุฏููุง", 1, 'html')
return false
end
end
--     Source Storm     --
if text == "ุงูุตูุงุญูุงุช" and ChCheck(msg) or text == "ุตูุงุญูุงุช" and ChCheck(msg) then 
local List = DevRio:smembers(storm.."Coomds"..msg.chat_id_)
if #List == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุงุชูุฌุฏ ุตูุงุญูุงุช ูุถุงูู", 1, 'html')
return false
end
t = "โ๏ธูุงุฆูุฉ ุงูุตูุงุญูุงุช ุงููุถุงูู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
var = DevRio:get(storm.."Comd:New:rt:Rio:"..v..msg.chat_id_)
if var then
t = t..k.."~ "..v.." โข ("..var..")\n"
else
t = t..k.."~ "..v.."\n"
end
end
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
if Admin(msg) then
if text == "ุญุฐู ุงูุตูุงุญูุงุช" and ChCheck(msg) or text == "ูุณุญ ุงูุตูุงุญูุงุช" and ChCheck(msg) then
local List = DevRio:smembers(storm.."Coomds"..msg.chat_id_)
for k,v in pairs(List) do
DevRio:del(storm.."Comd:New:rt:Rio:"..v..msg.chat_id_)
DevRio:del(storm.."Coomds"..msg.chat_id_)
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญุฐู ุงูุตูุงุญูุงุช ุงููุถุงูู", 1, 'html')
end
end
if text and text:match("^ุงุถู ุตูุงุญูู (.*)$") and ChCheck(msg) then 
ComdNew = text:match("^ุงุถู ุตูุงุญูู (.*)$")
DevRio:set(storm.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
DevRio:sadd(storm.."Coomds"..msg.chat_id_,ComdNew)  
DevRio:setex(storm.."Comd:New"..msg.chat_id_..msg.sender_user_id_,200,true)  
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ููุน ุงูุตูุงุญูู \n{ ุนุถู โข ูููุฒ  โข ุงุฏูู  โข ูุฏูุฑ }\nโ๏ธุงุฑุณู ุงูุบุงุก ูุงูุบุงุก ุงูุงูุฑ ", 1, 'html')
end
if text and text:match("^ุญุฐู ุตูุงุญูู (.*)$") and ChCheck(msg) or text and text:match("^ูุณุญ ุตูุงุญูู (.*)$") and ChCheck(msg) then 
ComdNew = text:match("^ุญุฐู ุตูุงุญูู (.*)$") or text:match("^ูุณุญ ุตูุงุญูู (.*)$")
DevRio:del(storm.."Comd:New:rt:Rio:"..ComdNew..msg.chat_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญุฐู ุงูุตูุงุญูู", 1, 'html')
end
if DevRio:get(storm.."Comd:New"..msg.chat_id_..msg.sender_user_id_) then 
if text and text:match("^โคฝ ุงูุบุงุก โ$") then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุงูุงูุฑ", 1, 'html')
DevRio:del(storm.."Comd:New"..msg.chat_id_..msg.sender_user_id_) 
return false  
end 
if text == "ูุฏูุฑ" then
if not Constructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชุณุชุทูุน ุงุถุงูุฉ ุตูุงุญูุฉ ( ุนุถู โข ูููุฒ  โข ุงุฏูู )\nโ๏ธุงุฑุณุงู ููุน ุงูุตูุงุญูู ูุฑู ุงุฎุฑู", 1, 'html')
return false
end
end
if text == "ุงุฏูู" then
if not Manager(msg) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชุณุชุทูุน ุงุถุงูุฉ ุตูุงุญูุฉ ( ุนุถู โข ูููุฒ )\nโ๏ธุงุฑุณุงู ููุน ุงูุตูุงุญูู ูุฑู ุงุฎุฑู", 1, 'html')
return false
end
end
if text == "ูููุฒ" then
if not Admin(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชุณุชุทูุน ุงุถุงูุฉ ุตูุงุญูุฉ ( ุนุถู )\nโ๏ธุงุฑุณุงู ููุน ุงูุตูุงุญูู ูุฑู ุงุฎุฑู", 1, 'html')
return false
end
end
if text == "ูุฏูุฑ" or text == "ุงุฏูู" or text == "ูููุฒ" or text == "ุนุถู" then
local textn = DevRio:get(storm.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
DevRio:set(storm.."Comd:New:rt:Rio:"..textn..msg.chat_id_,text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงุถุงูุฉ ุงูุตูุงุญูู", 1, 'html')
DevRio:del(storm.."Comd:New"..msg.chat_id_..msg.sender_user_id_) 
return false  
end 
end

if text and text:match("ุฑูุน (.*)") and tonumber(msg.reply_to_message_id_) > 0 then 
local DEV_RIO = text:match("ุฑูุน (.*)")
if DevRio:sismember(storm.."Coomds"..msg.chat_id_,DEV_RIO) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local mrrio = DevRio:get(storm.."Comd:New:rt:Rio:"..DEV_RIO..msg.chat_id_)
if mrrio == "ูููุฒ" and VipMem(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..data.first_name_..'](t.me/'..(data.username_ or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุฑูุนู โจ '..DEV_RIO..' โฉ ุจูุฌุงุญ', 1, 'md')
DevRio:set(storm.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_,DEV_RIO) 
DevRio:sadd(storm..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
elseif mrrio == "ุงุฏูู" and Admin(msg) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..data.first_name_..'](t.me/'..(data.username_ or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุฑูุนู โจ '..DEV_RIO..' โฉ ุจูุฌุงุญ', 1, 'md')
DevRio:set(storm.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_,DEV_RIO)
DevRio:sadd(storm..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
elseif mrrio == "ูุฏูุฑ" and Manager(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..data.first_name_..'](t.me/'..(data.username_ or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุฑูุนู โจ '..DEV_RIO..' โฉ ุจูุฌุงุญ', 1, 'md')
DevRio:set(storm.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_,DEV_RIO)  
DevRio:sadd(storm..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
elseif mrrio == "ุนุถู" then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..data.first_name_..'](t.me/'..(data.username_ or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุฑูุนู โจ '..DEV_RIO..' โฉ ุจูุฌุงุญ', 1, 'md')
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match("ุชูุฒูู (.*)") and tonumber(msg.reply_to_message_id_) > 0 then 
local DEV_RIO = text:match("ุชูุฒูู (.*)")
if DevRio:sismember(storm.."Coomds"..msg.chat_id_,DEV_RIO) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local mrrio = DevRio:get(storm.."Comd:New:rt:Rio:"..DEV_RIO..msg.chat_id_)
if mrrio == "ูููุฒ" and VipMem(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..data.first_name_..'](t.me/'..(data.username_ or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุชูุฒููู โจ '..DEV_RIO..' โฉ ุจูุฌุงุญ', 1, 'md')
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:del(storm.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_)
elseif mrrio == "ุงุฏูู" and Admin(msg) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..data.first_name_..'](t.me/'..(data.username_ or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุชูุฒููู โจ '..DEV_RIO..' โฉ ุจูุฌุงุญ', 1, 'md')
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:del(storm.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_)
elseif mrrio == "ูุฏูุฑ" and Manager(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..data.first_name_..'](t.me/'..(data.username_ or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุชูุฒููู โจ '..DEV_RIO..' โฉ ุจูุฌุงุญ', 1, 'md')
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:del(storm.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_)
elseif mrrio == "ุนุถู" then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..data.first_name_..'](t.me/'..(data.username_ or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุชูุฒููู โจ '..DEV_RIO..' โฉ ุจูุฌุงุญ', 1, 'md')
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match("^ุฑูุน (.*) @(.*)") then 
local text1 = {string.match(text, "^(ุฑูุน) (.*) @(.*)$")}
if DevRio:sismember(storm.."Coomds"..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local mrrio = DevRio:get(storm.."Comd:New:rt:Rio:"..text1[2]..msg.chat_id_)
if mrrio == "ูููุฒ" and VipMem(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..result.title_..'](t.me/'..(text1[3] or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุฑูุนู โจ '..text1[2]..' โฉ ุจูุฌุงุญ', 1, 'md')
DevRio:sadd(storm..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:set(storm.."Comd:New:rt:User:"..msg.chat_id_..result.id_,text1[2])
elseif mrrio == "ุงุฏูู" and Admin(msg) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..result.title_..'](t.me/'..(text1[3] or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุฑูุนู โจ '..text1[2]..' โฉ ุจูุฌุงุญ', 1, 'md')
DevRio:sadd(storm..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:set(storm.."Comd:New:rt:User:"..msg.chat_id_..result.id_,text1[2])
elseif mrrio == "ูุฏูุฑ" and Manager(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..result.title_..'](t.me/'..(text1[3] or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุฑูุนู โจ '..text1[2]..' โฉ ุจูุฌุงุญ', 1, 'md')
DevRio:sadd(storm..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:set(storm.."Comd:New:rt:User:"..msg.chat_id_..result.id_,text1[2])
elseif mrrio == "ุนุถู" then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..result.title_..'](t.me/'..(text1[3] or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุฑูุนู โจ '..text1[2]..' โฉ ุจูุฌุงุญ', 1, 'md')
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*", 1, 'md')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match("^ุชูุฒูู (.*) @(.*)") then 
local text1 = {string.match(text, "^(ุชูุฒูู) (.*) @(.*)$")}
if DevRio:sismember(storm.."Coomds"..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local mrrio = DevRio:get(storm.."Comd:New:rt:Rio:"..text1[2]..msg.chat_id_)
if mrrio == "ูููุฒ" and VipMem(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..result.title_..'](t.me/'..(text1[3] or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุชูุฒููู โจ '..text1[2]..' โฉ ุจูุฌุงุญ', 1, 'md')
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:del(storm.."Comd:New:rt:User:"..msg.chat_id_..result.id_)
elseif mrrio == "ุงุฏูู" and Admin(msg) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..result.title_..'](t.me/'..(text1[3] or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุชูุฒููู โจ '..text1[2]..' โฉ ุจูุฌุงุญ', 1, 'md')
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:del(storm.."Comd:New:rt:User:"..msg.chat_id_..result.id_)
elseif mrrio == "ูุฏูุฑ" and Manager(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..result.title_..'](t.me/'..(text1[3] or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุชูุฒููู โจ '..text1[2]..' โฉ ุจูุฌุงุญ', 1, 'md')
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:del(storm.."Comd:New:rt:User:"..msg.chat_id_..result.id_)
elseif mrrio == "ุนุถู" then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู โคฝ โจ ['..result.title_..'](t.me/'..(text1[3] or 'So_ST0RM')..')'..' โฉ\nโ๏ธุชู ุชูุฒููู โจ '..text1[2]..' โฉ ุจูุฌุงุญ', 1, 'md')
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*", 1, 'md')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
--     Source Storm     --
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
DevRio:incr(storm..'Rio:UsersMsgs'..storm..os.date('%d')..':'..msg.chat_id_..':'..msg.sender_user_id_)
DevRio:incr(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
DevRio:incr(storm..'Rio:MsgNumberDay'..msg.chat_id_..':'..os.date('%d'))  
ChatType = 'sp' 
elseif id:match("^(%d+)") then
if not DevRio:sismember(storm.."Rio:Users",msg.chat_id_) then
DevRio:sadd(storm.."Rio:Users",msg.chat_id_)
end
ChatType = 'pv' 
else
ChatType = 'gp' 
end
end 
--     Source Storm     --
if ChatType == 'pv' then 
if text == '/start' or text == 'โคฝ ุฑุฌูุน โ' then 
if SecondSudo(msg) then 
local Sudo_Welcome = 'โ๏ธูุฑุญุจุง ุนุฒูุฒู ุงููุทูุฑ \nโ๏ธุงูุช ุงููุทูุฑ ุงูุงุณุงุณู ููุง \nโ๏ธุงููู ุงุฒุฑุงุฑ ุณูุฑุณ ุณุชูุฑู \nโ๏ธุชุณุชุทูุน ุงูุชุญูู ุจูู ุงูุงูุงูุฑ ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ ุงูุณูุฑุณ โ','ูุถุน ุงุณู ุงูุจูุช'},
{'โคฝ  ุงููุทูุฑูู โ','โคฝ ุงูุงุญุตุงุฆูุงุช โ'},
{'โคฝ ุงูุชูุนูู ูุงูุชุนุทูู โ','โคฝ ุงูุงุฐุงุนู โ'},
{'โคฝ ุชุนููู ููุงูุด ุงูุงูุงูุฑ โ','โคฝ ุงูุนุงู โ','โคฝ ุฑุฏูุฏ ุงูุฎุงุต โ'},
{'โคฝ ุงููุชุฌุฑ โ','โคฝ ุงูุงูุงูุฑ ุงูุฎุฏููู โ'},
{'โคฝ ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == 'โคฝ ุชุนููู ููุงูุด ุงูุงูุงูุฑ โ' then 
if SecondSudo(msg) then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู ุงููุทูุฑ \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจุชุนุฏูู ูุชุบููุฑ ููุงูุด ุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'ุชุบูุฑ ูุนูููุงุช ุงูุชุฑุญูุจ'},
{'ุญุฐู ูููุดุฉ ุงูุงูุฏู','ุชุนููู ูููุดุฉ ุงูุงูุฏู'},
{'ุชุนููู ุงูุฑ ุงูุงูุงูุฑ'},
{'ุชุนููู ุงูุฑ ู3','ุชุนููู ุงูุฑ ู2','ุชุนููู ุงูุฑ ู1'},
{'ุชุนููู ุงูุฑ ู6','ุชุนููู ุงูุฑ ู5','ุชุนููู ุงูุฑ ู4'},
{'ุงุณุชุนุงุฏุฉ ููุงูุด ุงูุงูุงูุฑ'},
{'โคฝ ุฑุฌูุน โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == 'โคฝ ุงูุณูุฑุณ โ' then 
if SecondSudo(msg) then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู ุงููุทูุฑ \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจุชุญุฏูุซ  ุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ ุชุญุฏูุซ ุงูุณูุฑุณ โ','โคฝ ุชุญุฏูุซ โ'},
{'โคฝ ุงูุณูุฑูุฑ โ'},
{'โคฝ ูุจุฑูุฌ ุงูุณูุฑุณ โ','โคฝ ููุงุฉ ุงูุณูุฑุณ โ'},
{'โคฝ  ุงูุณูุฑุณ โ'},
{'โคฝ ุฑุฌูุน โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == 'โคฝ ุงูุงุญุตุงุฆูุงุช โ' then 
if SecondSudo(msg) then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู ุงููุทูุฑ \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจ ุฃุญุตุงุฆูุงุช  ุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ  ุงูุงุญุตุงุฆูุงุช โ'},
{'โคฝ ุงููุดุชุฑููู โ','โคฝ ุงููุฌููุนุงุช โ'},
{'โคฝ ุฑูุงุจุท ุงููุฌููุนุงุช โ','โคฝ ุฌูุจ ูุณุฎู ุงุญุชูุงุทูู โ'},
{'โคฝ ุชูุธูู ุงููุดุชุฑููู โ','โคฝ ุชูุธูู ุงููุฌููุนุงุช โ'},
{'โคฝ ููู ุงูุงุญุตุงุฆูุงุช โ'},
{'โคฝ ุฑุฌูุน โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == 'โคฝ  ุงููุทูุฑูู โ' then 
if SecondSudo(msg) then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู ุงููุทูุฑ \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจ ุงููุทูุฑูู ูุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ ุงูุงุณุงุณููู โ','ูุณุญ ุงูุงุณุงุณููู'},
{'โคฝ ุงูุซุงููููู โ','ูุณุญ ุงูุซุงููููู'},
{'โคฝ ุงููุทูุฑูู โ','ูุณุญ ุงููุทูุฑูู'},
{'โคฝ ุชุบูุฑ ุงููุทูุฑ ุงูุงุณุงุณู โ','โคฝ ุชุบููุฑ ูููุดู ุงููุทูุฑ โ'},
{'โคฝ ุฑุฌูุน โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == 'โคฝ ุงูุชูุนูู ูุงูุชุนุทูู โ' then 
if SecondSudo(msg) then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู ุงููุทูุฑ \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจ ุงูุชูุนูู ูุงูุชุนุทูู ูุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ ุชุนุทูู ุงูุชูุงุตู โ','โคฝ ุชูุนูู ุงูุชูุงุตู โ'},
{'โคฝ ุชุนุทูู ุชุฑุญูุจ ุงูุจูุช โ','โคฝ ุชูุนูู ุชุฑุญูุจ ุงูุจูุช โ'},
{'โคฝ ุชุนุทูู ุงููุบุงุฏุฑู โ','โคฝ ุชูุนูู ุงููุบุงุฏุฑู โ'},
{'โคฝ ุชุนุทูู ุงูุงุฐุงุนู โ','โคฝ ุชูุนูู ุงูุงุฐุงุนู โ'},
{'โคฝ ุชุนุทูู ุงูุจูุช ุงูุฎุฏูู โ','โคฝ ุชูุนูู ุงูุจูุช ุงูุฎุฏูู โ'},
{'โคฝ ุฑุฌูุน โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == 'โคฝ ุงูุงุฐุงุนู โ' then 
if SecondSudo(msg) then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู ุงููุทูุฑ \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจุงูุงุฐุงุนู ูุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ ุงุฐุงุนู ุจุงูุชุซุจูุช โ'},
{'โคฝ ุงุฐุงุนู ุฎุงุต โ','โคฝ ุงุฐุงุนู ุนุงู โ'},
{'โคฝ ุงุฐุงุนู ุฎุงุต ุจุงูุชูุฌูู โ','โคฝ ุงุฐุงุนู ุนุงู ุจุงูุชูุฌูู โ'},
{'ุงูุบุงุก'},
{'โคฝ ุฑุฌูุน โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == 'โคฝ ุงูุนุงู โ' then 
if SecondSudo(msg) then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู ุงููุทูุฑ \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจุงูุนุงู ูุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ ุงุถู ุฑุฏ ุนุงู โ','โคฝ ุญุฐู ุฑุฏ ุนุงู โ'},
{'โคฝ ุฑุฏูุฏ ุงูุนุงู โ','โคฝ ูุณุญ ุฑุฏูุฏ ุงูุนุงู โ'},
{'โคฝ ูุงุฆูู ุงูุนุงู โ','ูุณุญ ูุงุฆูู ุงูุนุงู'},
{'โคฝ ุฑุฌูุน โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == 'โคฝ ุฑุฏูุฏ ุงูุฎุงุต โ' then 
if SecondSudo(msg) then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู ุงููุทูุฑ \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจุฑุฏูุฏ ุงูุฎุงุต ูุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ ุชุนููู ุฑุฏ ุงูุฎุงุต โ','โคฝ ุญุฐู ุฑุฏ ุงูุฎุงุต โ'},
{'โคฝ ุฌูุจ ุฑุฏ ุงูุฎุงุต โ'},
{'โคฝ ุฑุฌูุน โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == 'โคฝ ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู โ' then 
if SecondSudo(msg) then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู ุงููุทูุฑ \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู ูุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ  ุชูุนูู ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู โ','โคฝ  ุชุนุทูู ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู โ'},
{'โคฝ ุชุนููู ููุงุฉ ุงูุงุดุชุฑุงู โ',' โคฝ ุญุฐู ููุงุฉ ุงูุงุดุชุฑุงู โ'},
{'โคฝ ุชุบูุฑ ูููุดู ุงูุงุดุชุฑุงู โ','โคฝ ุญุฐู ูููุดู ุงูุงุดุชุฑุงู โ'},
{'โคฝ ูููุดู ุงูุงุดุชุฑุงู โ','โคฝ ููุงุฉ ุงูุงุดุชุฑุงู โ'},
{'โคฝ ุฑุฌูุน โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == 'โคฝ ุงููุชุฌุฑ โ' then 
if SecondSudo(msg) then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู ุงููุทูุฑ \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจูุชุฌุฑ ุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ  ุงููุชุฌุฑ โ'},
{'ุชูุนูู ููู AddedMe.lua','ุชุนุทูู ููู AddedMe.lua'},
{'ุชูุนูู ููู AutoFile.lua','ุชุนุทูู ููู AutoFile.lua'},
{'ุชูุนูู ููู TagAll.lua','ุชุนุทูู ููู TagAll.lua'},
{'ุชูุนูู ููู TagAdmins.lua','ุชุนุทูู ููู TagAdmins.lua'},
{'ุชูุนูู ููู ReplyBot.lua','ุชุนุทูู ููู ReplyBot.lua'},
{'ุชูุนูู ููู ProNames.lua','ุชุนุทูู ููู ProNames.lua'},
{'ุชูุนูู ููู MuteNames.lua','ุชุนุทูู ููู MuteNames.lua'},
{'ุชูุนูู ููู ChangeUser.lua','ุชุนุทูู ููู ChangeUser.lua'},
{'ุชูุนูู ููู ChangePhoto.lua','ุชุนุทูู ููู ChangePhoto.lua'},
{'โคฝ ุฑุฌูุน โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == 'โคฝ ุงูุงูุงูุฑ ุงูุฎุฏููู โ' or text == '/play' or text == 'โคฝ  ุฑุฌูุน  โ' or text == 'ุงูุงูุฑ ุงูุฎุฏููู' or text == '/free' then
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจุงูุงูุงูุฑ ุงูุฎุฏููู ุงูุฎุงุตู ุจุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ ุงูุงูุฑ ุงูุชุณููู โ','โคฝ ุงูุงูุงูุฑ ุงูุฎุฏููู  โ'},
{'โคฝ ุงูุงูุฑ ุงููุณุจ โ','โคฝ ุงูุจูุชุงุช โ'},
{'โคฝ ุงูุนุงุจ โ'},
{'โคฝ  ุงูุณูุฑุณ โ','โคฝ  ุงููุทูุฑ โ'},
{'โคฝ ุฑุฌูุน โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
if text == 'โคฝ ุงูุงูุฑ ุงูุชุณููู โ' then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจุฃูุงูุฑ ุงูุชุณููู ุงูุฎุงุตู ุจุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ ุบูููู โ','โคฝ ุงุบููู โ'},
{'โคฝ ูููุฒ โ','โคฝ ุฑูููุณ โ'},
{'โคฝ ุตูุฑู โ','โคฝ ูุชุญุฑูู โ'},
{'โคฝ ูุณูุณู โ','โคฝ ููู โ'},
{'โคฝ  ุฑุฌูุน  โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
if text == 'โคฝ ุงูุงูุงูุฑ ุงูุฎุฏููู  โ' then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจุงูุงูุงูุฑ ุงูุฎุฏููู ุงูุฎุงุตู ุจุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ ุงูุงุจุฑุงุฌ โ','โคฝ ุญุณุงุจ ุงูุนูุฑ โ'},
{'โคฝ ุงูุฒุฎุฑูู โ','โคฝ ูุนุงูู ุงูุงุณูุงุก โ'},
{'โคฝ ุงูุญูุงูู โ'},
{'โคฝ  ูุนุฑูู โ','โคฝ  ุงุณูู โ','โคฝ ุงูุฏูู โ'},
{'โคฝ  ูุจุฐุชู โ','โคฝ ูุจุฐุง โ'},
{'โคฝ  ุฑุฌูุน  โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
if text == 'โคฝ ุงูุจูุชุงุช โ' then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจุฃูุงูุฑ ุงูุจูุชุงุช ุงูุฎุงุตู ุจุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ ุจูุช ุงูุญุฐู โ','โคฝ ุจูุช ุงูููุณู โ'},
{'โคฝ ุจูุช ุงูููุชููุจ โ','โคฝ ุจูุช ุงููุช โ'},
{'โคฝ ุจูุช ุงูุฒุฎุฑูู โ'},
{'โคฝ  ุฑุฌูุน  โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
if text == 'โคฝ ุงูุงูุฑ ุงููุณุจ โ' then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจุฃูุงูุฑ ุงููุณุจ ุงูุฎุงุตู ุจุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงูุงูุฑ ุงูุฐู ุชุฑูุฏ ุชูููุฐู'
local key = {
{'โคฝ ูุณุจู ุงููุฑู โ','โคฝ ูุณุจู ุงูุญุจ โ'},
{'โคฝ ูุณุจู ุงูุฑุฌููู โ','โคฝ ูุณุจู ุงูุงููุซู โ'},
{'โคฝ ูุณุจู ุงูุบุจุงุก โ','โคฝ ูุณุจู ุงูุฌูุงู โ'},
{'โคฝ ูุณุจู ุงูุฎูุงูู โ'},
{'โคฝ  ุฑุฌูุน  โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
if text == 'โคฝ ุงูุนุงุจ โ' then 
local Sudo_Welcome = 'โ๏ธุงููุง ุจู ูุฌุฏุฏุง ุนุฒูุฒู \nโ๏ธุงููู ุงูุงุฒุฑุงุฑ ุงูุฎุงุตู ุจุฃูุนุงุจ ุณูุฑุณ ุณุชูุฑู ููุท ุงุถุบุท ุนูู ุงููุนุจู ุงูุฐู ุชุฑูุฏ ูุนุจูุง'
local key = {
{'โคฝ ุงูุงูุนุงุจ โ','โคฝ ุงูุงูุนุงุจ ุงููุชุทูุฑู โ'},
{'โคฝ ูุช โ'},
{'โคฝ ุณูุงููุงุช โ','โคฝ ูุนุงูู โ'},
{'โคฝ ุชุฑุชูุจ โ','โคฝ ุญุฒูุฑู โ'},
{'โคฝ ุงูุนูุณ โ','โคฝ ุงููุฎุชูู โ'},
{'โคฝ ุงูุซูู โ','โคฝ ุงุณุฆูู โ'},
{'โคฝ ุชุฎููู โ',''},
{'โคฝ ุฑูุงุถูุงุช โ','โคฝ ุงููููุฒู โ'},
{'โคฝ  ุฑุฌูุน  โ'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
--     Source Storm     --
if text == '/start' and ChCheck(msg) then  
if not DevRio:get(storm..'Rio:Start:Time'..msg.sender_user_id_) then
tdcli_function({ID="GetUser",user_id_=DevId},function(arg,dp) 
local inline = {
{{text="โ ุงููุทูุฑ .",url="t.me/"..(dp.username_ or "So_ST0RM")}},
{{text="โ ุงูุณูุฑุณ .",url="https://t.me/So_ST0RM"},{text="โ ูุชูุตูุจ ุจูุช .",url="https://t.me/AHMED_MERO_love"}},{{text="โ ุงุถููู ูู ูุฌููุนุชู .",url="t.me/"..dp.username_.."?startgroup=botstart"}}
}
local start = DevRio:get(storm.."Rio:Start:Bot")
if start then 
Start_Source = start
else
Start_Source = "โ๏ธูุฑุญุจุง ุงูุง ุจูุช ุงุณูู "..NameBot.."\nโ๏ธุงุฎุชุตุงุตู ุญูุงูุฉ ุงููุฌููุนุงุช\nโ๏ธูู ุงูุชูููุด ูุงูุณุจุงู ูุงูุฎุฎ .. . ุ\nโ๏ธุชูุนููู ุณูู ููุฌุงูุง ููุท ูู ุจุฑูุนู ุงุฏูู ูู ูุฌููุนุชู ูุงุฑุณู ุงูุฑ โคฝ ุชูุนูู\nโ๏ธุณูุชู ุฑูุน ุงูุงุฏูููู ูุงูููุดุฆ ุชููุงุฆูุง\nโ๏ธุงุฑุณู ุงูุฑ /free ุงู /play ููุชูุชุน ุจุงูุงูุฑ ุงูุงุนุถุงุก"
end 
SendInline(msg.chat_id_,Start_Source,nil,inline)
end,nil)
end
DevRio:setex(storm..'Rio:Start:Time'..msg.sender_user_id_,300,true)
return false
end 

--     Source Storm     --
if not SecondSudo(msg) and not DevRio:sismember(storm..'Rio:Ban:Pv',msg.sender_user_id_) and not DevRio:get(storm..'Rio:Texting:Pv') then
tdcli_function({ID="GetUser",user_id_=DevId},function(arg,chat) 
Dev_Rio(msg.sender_user_id_, msg.id_, 1, 'โ๏ธุชู ุงุฑุณุงู ุฑุณุงูุชู ุงูู [ุงููุทูุฑ](t.me/'..(chat.username_ or "So_ST0RM")..')', 1, 'md') 
tdcli_function({ID="ForwardMessages",chat_id_=DevId,from_chat_id_= msg.sender_user_id_,message_ids_={[0]=msg.id_},disable_notification_=1,from_background_=1},function(arg,data) 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,dp) 
if data and data.messages_ and data.messages_[0] ~= false and data.ID ~= "Error" then
if data and data.messages_ and data.messages_[0].content_.sticker_ then
SendText(DevId,'โ๏ธุชู ุงุฑุณุงู ุงูููุตู ูู โคฝ โค\n['..string.sub(dp.first_name_,0, 40)..'](tg://user?id='..dp.id_..')',0,'md') 
return false
end;end;end,nil);end,nil);end,nil);end
if SecondSudo(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end 
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'ุญุธุฑ' or text == 'ุญุถุฑ' then
local Text = 'โ๏ธุงูุนุถู โคฝ ['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..data.id_..')'..'\nโ๏ธุชู ุญุธุฑู ูู ุงูุชูุงุตู'
SendText(DevId,Text,msg.id_/2097152/0.5,'md') 
DevRio:sadd(storm..'Rio:Ban:Pv',data.id_)  
return false  
end 
if text == 'ุงูุบุงุก ุงูุญุธุฑ' or text == 'ุงูุบุงุก ุญุธุฑ' then
local Text = 'โ๏ธุงูุนุถู โคฝ ['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..data.id_..')'..'\nโ๏ธุชู ุงูุบุงุก ุญุธุฑู ูู ุงูุชูุงุตู'
SendText(DevId,Text,msg.id_/2097152/0.5,'md') 
DevRio:srem(storm..'Rio:Ban:Pv',data.id_)  
return false  
end 
tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,dp) 
if dp.code_ == 400 or dp.code_ == 5 then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู ูุงู ุจุญุธุฑ ุงูุจูุช ูุง ุชุณุชุทูุน ุงุฑุณุงู ุงูุฑุณุงุฆู ูู', 1, 'md')
return false  
end 
if text then
Dev_Rio(id_user, 0, 1, text, 1, "md")  
Text = 'โ๏ธุชู ุงุฑุณุงู ุงูุฑุณุงูู ุงูู โคฝ โค'
elseif msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1,nil, msg.content_.sticker_.sticker_.persistent_id_)   
Text = 'โ๏ธุชู ุงุฑุณุงู ุงูููุตู ุงูู โคฝ โค'
elseif msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1,nil, msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
Text = 'โ๏ธุชู ุงุฑุณุงู ุงูุตูุฑู ุงูู โคฝ โค'
elseif msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
Text = 'โ๏ธุชู ุงุฑุณุงู ุงููุชุญุฑูู ุงูู โคฝ โค'
elseif msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1,nil, msg.content_.voice_.voice_.persistent_id_)    
Text = 'โ๏ธุชู ุงุฑุณุงู ุงูุจุตูู ุงูู โคฝ โค'
end     
SendText(DevId, Text..'\n'..'['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..data.id_..')',0,'md') 
end,nil);
end,nil);
end,nil);
end,nil);
end 
end 
--     Source Storm     --
if text and DevRio:get(storm..'Rio:Start:Bots'..msg.sender_user_id_) then
if text == 'ุงูุบุงุก' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุญูุธ ูููุดุฉ ุงูุณุชุงุฑุช', 1, 'md')
DevRio:del(storm..'Rio:Start:Bots'..msg.sender_user_id_) 
return false
end
DevRio:set(storm.."Rio:Start:Bot",text)  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญูุธ ูููุดุฉ ุงูุณุชุงุฑุช', 1, 'md')
DevRio:del(storm..'Rio:Start:Bots'..msg.sender_user_id_) 
return false
end
if SecondSudo(msg) then
if text == 'ุชุนููู ุฑุฏ ุงูุฎุงุต' and ChCheck(msg) or text == 'ุถุน ูููุดู ุณุชุงุฑุช' and ChCheck(msg) or text == 'โคฝ ุชุนููู ุฑุฏ ุงูุฎุงุต โ' and ChCheck(msg) then 
DevRio:set(storm..'Rio:Start:Bots'..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงุฑุณู ูู ูููุดุฉ ุงูุณุชุงุฑุช ุงูุงู', 1, 'md')
return false
end
if text == 'ุญุฐู ุฑุฏ ุงูุฎุงุต' and ChCheck(msg) or text == 'ุญุฐู ูููุดู ุณุชุงุฑุช' and ChCheck(msg) or text == 'โคฝ ุญุฐู ุฑุฏ ุงูุฎุงุต โ' and ChCheck(msg) then 
DevRio:del(storm..'Start:Bot') 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญุฐู ูููุดุฉ ุงูุณุชุงุฑุช ุจูุฌุงุญ', 1, 'md')
end
if text == 'ุฌูุจ ุฑุฏ ุงูุฎุงุต' and ChCheck(msg) or text == 'โคฝ ุฌูุจ ุฑุฏ ุงูุฎุงุต โ' and ChCheck(msg) then  
local start = DevRio:get(storm.."Rio:Start:Bot")
if start then 
Start_Source = start
else
Start_Source = "โ๏ธูุฑุญุจุง ุงูุง ุจูุช ุงุณูู "..NameBot.."\nโ๏ธุงุฎุชุตุงุตู ุญูุงูุฉ ุงููุฌููุนุงุช\nโ๏ธูู ุงูุชูููุด ูุงูุณุจุงู ูุงูุฎุฎ .. . ุ\nโ๏ธุชูุนููู ุณูู ููุฌุงูุง ููุท ูู ุจุฑูุนู ุงุฏูู ูู ูุฌููุนุชู ูุงุฑุณู ุงูุฑ โคฝ ุชูุนูู\nโ๏ธุณูุชู ุฑูุน ุงูุงุฏูููู ูุงูููุดุฆ ุชููุงุฆูุง"
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, Start_Source, 1, 'md')
return false
end
if text == 'ุชูุนูู ุงูุชูุงุตู' and ChCheck(msg) or text == 'โคฝ ุชูุนูู ุงูุชูุงุตู โ' and ChCheck(msg) then   
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุชูุงุตู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Texting:Pv') 
end
if text == 'ุชุนุทูู ุงูุชูุงุตู' and ChCheck(msg) or text == 'โคฝ ุชุนุทูู ุงูุชูุงุตู โ' and ChCheck(msg) then  
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุชูุงุตู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Texting:Pv',true) 
end
if text == 'ุชูุนูู ุงููุทูุฑ ุงููุงูู' and ChCheck(msg) or text == 'โคฝ ุชูุนูู ุงููุทูุฑ ุงููุงูู โ' and ChCheck(msg) then   
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงููุทูุฑ ุงููุงูู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Devinline:Pv') 
end
if text == 'ุชุนุทูู ุงููุทูุฑ ุงููุงูู' and ChCheck(msg) or text == 'โคฝ ุชุนุทูู ุงููุทูุฑ ุงููุงูู โ' and ChCheck(msg) then  
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงููุทูุฑ ุงููุงูู ุจูุฌุงุญ ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Devinline:Pv',true) 
end
end
--     Source Storm     --
if text == "ุงูุงุจุฑุงุฌ" or text == "โคฝ ุงูุงุจุฑุงุฌ โ" then  Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ ูู ุฎูุงู ุงูุจูุช ููููู ูุนุฑูู ุชููุนุงุช ุจุฑุฌู \nโ๏ธ ููุท ูู ุจุงุฑุณุงู ุงูุฑ ุจุฑุฌ + ุงุณู ุงูุจุฑุฌ \nโ๏ธ ูุซุงู : ุจุฑุฌ ุงูุงุณุฏ ุ\nโ๏ธ ููุนุฑูู ุจุฑุฌู ูู ุจุงูุฑุฌูุน ุงูู ูุณู ุญุณุงุจ ุงูุนูุฑ ', 1, 'md') end
if text == "ุญุณุงุจ ุงูุนูุฑ" or text == "โคฝ ุญุณุงุจ ุงูุนูุฑ โ" then  Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ ูู ุฎูุงู ุงูุจูุช ููููู ุญุณุงุจ ุนูุฑู \nโ๏ธ ููุท ูู ุจุงุฑุณุงู ุงูุฑ ุงุญุณุจ + ููุงููุฏู ุงูู ุงูุจูุช \nโ๏ธ ุจุงูุชูุณูู ุงูุชุงูู ูุซุงู : ุงุญุณุจ 2000/7/24', 1, 'md') end
if text == "ุงูุญูุงูู" or text == "โคฝ ุงูุญูุงูู โ" then  Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ ุงุถู ุงูุจูุช ูู ุงููุฌููุนู ุซู ูู ุจุฑูุนู ูุดุฑู ูุงุฑุณู ุชูุนูู \nโ๏ธ ูุชูุชุน ุจุฎุฏูุงุช ุบูุฑ ููุฌูุฏู ูู ุจุงูู ุงูุจูุชุงุช ', 1, 'md') end
if text == "ุงูุฒุฎุฑูู" or text == "โคฝ ุงูุฒุฎุฑูู โ" then  Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ุจุฃุฑุณุงู ุฃูุฑ ุฒุฎุฑูู ูุซู ุงุฑุณุงู ุงูุงุณู ุงูุฐู ุชุฑูุฏ ุฒุฎุฑูุชู ุจุฃูุงููููุฒู ุฃู ุงูุนุฑุจู', 1, 'md') end
if text == "ูุนุงูู ุงูุงุณูุงุก" or text == "โคฝ ูุนุงูู ุงูุงุณูุงุก โ" then  Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ ูู ุฎูุงู ุงูุจูุช ููููู ูุนุฑูู ูุนูู ุงุณูู \nโ๏ธ ููุท ูู ุจุงุฑุณุงู ุงูุฑ ูุนูู ุงุณู + ุงูุงุณู \nโ๏ธ ูุซุงู : ูุนูู ุงุณู ุฑูู', 1, 'md') end
if text == "ุนุฏุฏ ุงููุณุญ" or text == "ุชุนูู ุนุฏุฏ ุงููุณุญ" or text == "ุชุนููู ุนุฏุฏ ุงููุณุญ" then  Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ ููุท ูู ุจุงุฑุณุงู ุงูุฑ ุนุฏุฏ ุงููุณุญ + ุนุฏุฏ ุงููุณุญ \nโ๏ธ ูุซุงู : ุนุฏุฏ ุงููุณุญ 100', 1, 'md') end
if text == "ุงูุทู" then  Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ ููุท ูู ุจุงุฑุณุงู ุงูุฑ ุงูุทู + ุงููููู\nโ๏ธุณูููู ุงูุจูุช ุจูุทู ุงููููู \nโ๏ธ ูุซุงู : ุงูุทู ููู', 1, 'md') end
if text == "ููุชููุจ" and ChCheck(msg) or text == "ุงูููุชููุจ" and ChCheck(msg) or text == "โคฝ ุจูุช ุงูููุชููุจ โ" and ChCheck(msg) or text == "ุจูุช ุงูููุชููุจ" and ChCheck(msg) or text == "ุงุฑูุฏ ุจูุช ููุชููุจ" and ChCheck(msg) or text == "ุดูุฑูู ุจูุช ููุชููุจ" and ChCheck(msg) or text == "ููุช" and ChCheck(msg) then local inline = {{{text="ุงุถุบุท ููุง",url="https://t.me/Qeaa_bot"}}} SendInline(msg.chat_id_,'*โ๏ธุงุถุบุท ููุญุตูู ุนูู ุจูุช ุงูููุชููุจ*',nil,inline) return false end
if text == "ุงููุณ" and ChCheck(msg) or text == "โคฝ ุจูุช ุงูููุณู โ" and ChCheck(msg) or text == "ุจูุช ุงูููุณู" and ChCheck(msg) or text == "ููุณู" and ChCheck(msg) or text == "ุงุฑูุฏ ุจูุช ุงูููุณู" and ChCheck(msg) or text == "ุฏุฒูู ุจูุช ุงูููุณู" and ChCheck(msg) or text == "ุฏุฒููู ุจูุช ุงูููุณู" and ChCheck(msg) then  Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ@HMSEBOT\nโ๏ธ@nnbbot\nโ๏ธ@ocBot\nโ๏ธ@hebot ', 1, 'md') end
if text == "ุฑุงุจุท ุญุฐู" and ChCheck(msg) or text == "ุฑุงุจุท ุงูุญุฐู" and ChCheck(msg) or text == "ุงุฑูุฏ ุฑุงุจุท ุงูุญุฐู" and ChCheck(msg) or text == "ุดูุฑูู ุฑุงุจุท ุงูุญุฐู" and ChCheck(msg) or text == "ุงุฑูุฏ ุฑุงุจุท ุญุฐู" and ChCheck(msg) then local inline = {{{text="ุงุถุบุท ููุง",url="https://t.me/LC6BOT"}}} SendInline(msg.chat_id_,'*โ๏ธุงุถุบุท ููุญุตูู ุนูู ุฑุงุจุท ุงูุญุฐู*',nil,inline) return false end
if text == "โคฝ ุจูุช ุงูุญุฐู โ" and ChCheck(msg) or text == "ุจูุช ุงูุญุฐู" and ChCheck(msg) or text == "ุงุฑูุฏ ุจูุช ุงูุญุฐู" and ChCheck(msg) or text == "ุงุฑูุฏ ุจูุช ุญุฐู" and ChCheck(msg) or text == "ุจูุช ุญุฐู" and ChCheck(msg) or text == "ุจูุช ุญุฐู ุญุณุงุจุงุช" and ChCheck(msg) or text == "ุฑุงุญ ุงุญุฐู" and ChCheck(msg) then local inline = {{{text="ุงุถุบุท ููุง",url="https://t.me/LC6BOT"}}} SendInline(msg.chat_id_,'*โ๏ธุงุถุบุท ููุญุตูู ุนูู ุจูุช ุงูุญุฐู*',nil,inline) return false end
if text == "โคฝ ุจูุช ุงููุช โ" and ChCheck(msg) or text == "ุจูุช ุงููุช" and ChCheck(msg) or text == "ุจูุช ูุช" and ChCheck(msg) then local inline = {{{text="ุงุถุบุท ููุง",url="https://t.me/E93OBot"}}} SendInline(msg.chat_id_,'*โ๏ธุงุถุบุท ููุญุตูู ุนูู ุจูุช ุงููุช*',nil,inline) return false end
if text == "โคฝ ุจูุช ุงูุฒุฎุฑูู โ" and ChCheck(msg) or text == "ุจูุช ุงูุฒุฎุฑูู" and ChCheck(msg) or text == "ุจูุช ุฒุฎุฑูู" and ChCheck(msg) then local inline = {{{text="ุงุถุบุท ููุง",url="https://t.me/W55555535Bot"}}} SendInline(msg.chat_id_,'*โ๏ธุงุถุบุท ููุญุตูู ุนูู ุจูุช ุงูุฒุฎุฑูู*',nil,inline) return false end
if text == "ุงูุฏูู" and ChCheck(msg) or text == "โคฝ ุงูุฏูู โ" and ChCheck(msg) then Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุงูุฏูู โคฝ โจ `'..msg.sender_user_id_..'` โฉ', 1, 'md') end
-- Source Storm --
if text == 'ูุจุฐุง' and ChCheck(msg) or text == 'โคฝ ูุจุฐุง โ' then
local stormTeam = {'- Nothing stops him who wants you .','make them wish they had you !.','Maybe a magical girl','ูซ ๐ก๐พ ๐๐๐๐๐๐พ ๐บ๐๐ฝ ๐ฝ๐๐ฟ๐ฟ๐พ๐๐พ๐๐','. ๐ฌ๐บ๐๐พ ๐ฝ๐๐พ๐บ๐๐ ๐ฟ๐๐๐ ๐๐๐๐ ๐๐พ๐ฟ๐๐บ๐ผ๐๐๐๐๐ . .',':Life is lying .','๐จ ๐๐๐๐ ๐บ๐๐๐บ๐๐ ๐๐๐๐พ ๐๐๐ ๐๐พ๐๐พ๐ ๐ฟ๐๐๐๐พ๐'}  
Dev_Rio(msg.chat_id_, msg.id_, 1, ''..stormTeam[math.random(#stormTeam)]..'' , 1, 'md')  
return false
end
--     Source Storm     --
if text and (text == 'ุงููุทูุฑ' or text == 'ูุทูุฑ' or text == 'โคฝ  ุงููุทูุฑ โ') and not DevRio:get(storm..'Rio:Devinline:Pv'..msg.chat_id_) then
tdcli_function({ID="GetUser",user_id_=DevId},function(arg,result)
local msg_id = msg.id_/2097152/0.5
Text = "*โ๏ธ๐๐๐ฃ ๐๐๐๐ โฌ * ["..result.first_name_.."](T.me/"..result.username_..")\n*โ๏ธ๐๐๐ฃ๐๐๐๐๐๐  โฌ* [@"..result.username_.."]"
keyboard = {} 
keyboard.inline_keyboard = {{{text = ''..result.first_name_..' ',url="t.me/"..result.username_ or So_ST0RM}}}
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/'..result.username_..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
end
--     Source Storm     --
if text == "ูุนุฑูู" and ChCheck(msg) or text == "โคฝ  ูุนุฑูู โ" and ChCheck(msg) then
function get_username(extra,result,success)
text = 'โ๏ธูุนุฑูู โคฝ โจ User โฉ'
local text = text:gsub('User',('@'..result.username_ or ''))
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, 'html')
end
getUser(msg.sender_user_id_,get_username)
end
if text == "ุงุณูู" and ChCheck(msg) or text == "โคฝ  ุงุณูู โ" and ChCheck(msg) then
function get_firstname(extra,result,success)
text = 'โ๏ธุงุณูู โคฝ firstname lastname'
local text = text:gsub('firstname',(result.first_name_ or ''))
local text = text:gsub('lastname',(result.last_name_ or ''))
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, 'html')
end
getUser(msg.sender_user_id_,get_firstname)
end 
if text == 'ูุจุฐุชู' and ChCheck(msg) or text == 'ุจุงูู' and ChCheck(msg) or text == 'โคฝ  ูุจุฐุชู โ' and ChCheck(msg) then
send(msg.chat_id_, msg.id_,'['..GetBio(msg.sender_user_id_)..']')
end
if text == "ุตูุฑุชู" or text == "โคฝ ุตูุฑุชู โ" then
local my_ph = DevRio:get(storm.."Rio:Photo:Profile"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_," โ๏ธุงูุตูุฑู ูุนุทูู") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," โ๏ธุนุฏุฏ ุตูุฑู โคฝ "..result.total_count_.." ุตูุฑูโโ", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'ูุง ุชูุชูู ุตูุฑู ูู ุญุณุงุจู', 1, 'md')
end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
--     Source Storm     --
if text == "ุงูุงูุนุงุจ ุงููุชุทูุฑู" or text == "ุงูุงูุนุงุจ ุงูุงุญุชุฑุงููู" or text == "โคฝ ุงูุงูุนุงุจ ุงููุชุทูุฑู โ" then
if not DevRio:get(storm..'Rio:Lock:Gamesinline'..msg.chat_id_) then
Text =[[
*โ๏ธูุงุฆูู ุงูุงูุนุงุจ ุงููุชุทูุฑู ุงุถุบุท ููุนุจ*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="โ ุงูุดุทุฑูุฌ โ",url='https://t.me/T4TTTTBOT?game=chess'}},
{{text="ูุนุจุฉ ููุงุจู ุจูุฑุฏ ๐ฅ",url='https://t.me/awesomebot?game=FlappyBird'},{text="ุชุญุฏู ุงูุฑูุงุถูุงุช",url='https://t.me/gamebot?game=MathBattle'}},
{{text="ุงูุณ ุงู",url='t.me/xobot?start'},{text="ุณุจุงู ุงูุฏุฑุงุฌุงุช ๐",url='https://t.me/gamee?game=MotoFX'}},
{{text="ุณุจุงู ุณูุงุฑุงุช ๐",url='https://t.me/gamee?game=F1Racer'},{text="ูุชุดุงุจู ๐พ",url='https://t.me/gamee?game=DiamondRows'}},
{{text="ูุฑุฉ ูุฏู โฝ",url='https://t.me/gamee?game=FootballStar'}},
{{text="ูุฑู๐คนโโ",url='https://t.me/gamee?game=Hexonix'},{text="Hexonixโ",url='https://t.me/gamee?game=Hexonix'}},
{{text="MotoFx๐๏ธ",url='https://t.me/gamee?game=MotoFx'}},
{{text="ูุนุจุฉ 2048 ๐ฐ",url='https://t.me/awesomebot?game=g2048'},{text="Squares๐",url='https://t.me/gamee?game=Squares'}},
{{text="Atomic 1โถ๏ธ",url='https://t.me/gamee?game=AtomicDrop1'},{text="Corsairs",url='https://t.me/gamebot?game=Corsairs'}},
{{text="LumberJack",url='https://t.me/gamebot?game=LumberJack'}},
{{text="LittlePlane",url='https://t.me/gamee?game=LittlePlane'},{text="RollerDisco",url='https://t.me/gamee?game=RollerDisco'}},
{{text="๐ฆ ูุนุจุฉ ุงูุชููู ๐ฆ",url='https://t.me/T4TTTTBOT?game=dragon'},{text="๐ ูุนุจุฉ ุงูุงูุนู ๐",url='https://t.me/T4TTTTBOT?game=snake'}},
{{text="๐ต ูุนุจุฉ ุงูุงููุงู ๐ด",url='https://t.me/T4TTTTBOT?game=color'}},
{{text="๐ ูุนุจุฉ ุงูุตุงุฑูุฎ ๐",url='https://t.me/T4TTTTBOT?game=rocket'},{text="๐น ูุนุจุฉ ุงูุณูุงู ๐น",url='https://t.me/T4TTTTBOT?game=arrow'}},
{{text="ูุนุจุฉ ุงููููุฌุง",url='https://t.me/gamee?game=GravityNinja21'},{text="ูุนุจุฉ ุงููุฑุชู",url='https://t.me/gamee?game=KarateKid2'}},
{{text = 'โ storm team .', url="t.me/So_ST0RM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end end
--     Source Storm     --
function getUser(user_id, cb)
tdcli_function ({
ID = "GetUser",
user_id_ = user_id
}, cb, nil)
end
local msg = data.message_
text = msg.content_.text_
if msg.content_.ID == "MessageChatAddMembers" then 
DevRio:incr(storm..'Rio:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_)
DevRio:set(storm.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = DevRio:get(storm.."Rio:Lock:Bots"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and Bots == "kick" and not VipMem(msg) then   
https.request("https://api.telegram.org/bot"..TokenBot.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
GetInfo = https.request("https://api.telegram.org/bot"..TokenBot.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local JsonInfo = JSON.decode(GetInfo)
if JsonInfo.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,dp) local admins = dp.members_ for i=0 , #admins do if dp.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not VipMem(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and Bots == "del" and not VipMem(msg) then   
GetInfo = https.request("https://api.telegram.org/bot"..TokenBot.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local JsonInfo = JSON.decode(GetInfo)
if JsonInfo.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,dp) local admins = dp.members_ for i=0 , #admins do if dp.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not VipMem(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and Bots == "ked" and not VipMem(msg) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_.."&can_send_messages=false&can_send_media_messages=false&can_send_other_messages=false&can_add_web_page_previews=false")
DevRio:sadd(storm..'Rio:Tkeed:'..msg.chat_id_, msg.sender_user_id_)
GetInfo = https.request("https://api.telegram.org/bot"..TokenBot.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local JsonInfo = JSON.decode(GetInfo)
if JsonInfo.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,dp) local admins = dp.members_ for i=0 , #admins do if dp.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not VipMem(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end  
end  
end
if msg.content_.ID == "MessageChatDeleteMember" and tonumber(msg.content_.user_.id_) == tonumber(storm) then 
DevRio:srem(storm.."Rio:Groups", msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
if not Sudo(msg) and not Bot(msg) then
SendText(DevId,"โ๏ธุชู ุทุฑุฏ ุงูุจูุช ูู ุงููุฌููุนู โคฝ โค \nโ โ โ โ โ โ โ โ โ\nโ๏ธุจูุงุณุทุฉ โคฝ "..Name.."\nโ๏ธุงุณู ุงููุฌููุนู โคฝ ["..NameChat.."]\nโ๏ธุงูุฏู ุงููุฌููุนู โคฝ โค \nโจ `"..msg.chat_id_.."` โฉ\nโ โ โ โ โ โ โ โ โ\nโ๏ธุงูููุช โคฝ "..os.date("%I:%M%p").."\nโ๏ธุงูุชุงุฑูุฎ โคฝ "..os.date("%Y/%m/%d").."",0,'md')
end
end,nil)
end,nil)
end
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if DevRio:get(storm..'Rio:Lock:TagServr'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
end   
end
if msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" then   
DevRio:incr(storm..'Rio:EntryNumber'..msg.chat_id_..':'..os.date('%d'))  
elseif msg.content_.ID == "MessageChatDeleteMember" then   
DevRio:incr(storm..'Rio:ExitNumber'..msg.chat_id_..':'..os.date('%d'))  
end
--     Source Storm     --
if text ==('ุชูุนูู') and not SudoBot(msg) and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:FreeBot'..storm) then
if ChatType == 'pv' then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุงุชุณุชุทูุน ุชูุนููู ููุง ูุฑุฌู ุงุถุงูุชู ูู ูุฌููุนู ุงููุง', 1, 'md')
return false
end
if ChatType ~= 'sp' then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุฌููุนู ุนุงุฏูู ูููุณุช ุฎุงุฑูู ูุง ุชุณุชุทูุน ุชูุนููู ูุฑุฌู ุงู ุชุถุน ุณุฌู ุฑุณุงุฆู ุงููุฌููุนู ุถุงูุฑ ูููุณ ูุฎูู ููู ุจุนุฏูุง ููููู ุฑูุนู ุงุฏูู ุซู ุชูุนููู', 1, 'md')
return false
end
if msg.can_be_deleted_ == false then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุจูุช ููุณ ุงุฏูู ูุฑุฌู ุชุฑููุชู !', 1, 'md')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,ChatMem) 
if ChatMem and ChatMem.status_.ID == "ChatMemberStatusEditor" or ChatMem and ChatMem.status_.ID == "ChatMemberStatusCreator" then
if ChatMem and ChatMem.user_id_ == msg.sender_user_id_ then
if ChatMem.status_.ID == "ChatMemberStatusCreator" then
status = 'ููุดุฆ'
elseif ChatMem.status_.ID == "ChatMemberStatusEditor" then
status = 'ุงุฏูู'
else 
status = 'ุนุถู'
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,rio) 
local admins = rio.members_
for i=0 , #admins do
if rio.members_[i].bot_info_ == false and rio.members_[i].status_.ID == "ChatMemberStatusEditor" then
DevRio:sadd(storm..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
DevRio:sadd(storm..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)
end
if rio.members_[i].status_.ID == "ChatMemberStatusCreator" then
DevRio:sadd(storm.."Rio:BasicConstructor:"..msg.chat_id_,admins[i].user_id_)
DevRio:sadd(storm.."Rio:RioConstructor:"..msg.chat_id_,admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
DevRio:srem(storm.."Rio:BasicConstructor:"..msg.chat_id_,admins[i].user_id_)
DevRio:srem(storm.."Rio:RioConstructor:"..msg.chat_id_,admins[i].user_id_)
end
end,nil)  
end 
end
end,nil)
if DevRio:sismember(storm..'Rio:Groups',msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุฌููุนู ุจุงูุชุงููุฏ ููุนูู', 1, 'md')
else
if tonumber(data.member_count_) < tonumber(DevRio:get(storm..'Rio:Num:Add:Bot') or 0) and not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุนุฏุฏ ุงุนุถุงุก ุงููุฌููุนู ุงูู ูู โคฝ *'..(DevRio:get(storm..'Rio:Num:Add:Bot') or 0)..'* ุนุถู', 1, 'md')
return false
end
ReplyStatus(msg,result.id_,"ReplyBy","โ๏ธุชู ุชูุนูู ุงููุฌููุนู "..dp.title_)  
DevRio:sadd(storm.."Rio:Groups",msg.chat_id_)
DevRio:sadd(storm..'Rio:BasicConstructor:'..msg.chat_id_,msg.sender_user_id_)
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NumMem = data.member_count_
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
else
LinkGroup = 'ูุง ููุฌุฏ'
end
DevRio:set(storm.."Rio:Groups:Links"..msg.chat_id_,LinkGroup) 
SendText(DevId,"โ๏ธุชู ุชูุนูู ูุฌููุนู ุฌุฏูุฏู โคฝ โค \nโ โ โ โ โ โ โ โ โ\nโ๏ธุจูุงุณุทุฉ โคฝ "..Name.."\nโ๏ธูููุนู ูู ุงููุฌููุนู โคฝ "..status.."\nโ๏ธุงุณู ุงููุฌููุนู โคฝ ["..NameChat.."]\nโ๏ธุนุฏุฏ ุงุนุถุงุก ุงููุฌููุนู โคฝ โจ *"..NumMem.."* โฉ\nโ๏ธุงูุฏู ุงููุฌููุนู โคฝ โค \nโจ `"..msg.chat_id_.."` โฉ\nโ๏ธุฑุงุจุท ุงููุฌููุนู โคฝ โค\nโจ ["..LinkGroup.."] โฉ\nโ โ โ โ โ โ โ โ โ\nโ๏ธุงูููุช โคฝ "..os.date("%I:%M%p").."\nโ๏ธุงูุชุงุฑูุฎ โคฝ "..os.date("%Y/%m/%d").."",0,'md')
end
end end
end,nil)
end,nil)
end,nil)
end,nil)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุชูุนูู ูุฐู ุงููุฌููุนู ุจุณุจุจ ุชุนุทูู ุงูุจูุช ุงูุฎุฏูู ูู ูุจู ุงููุทูุฑ ุงูุงุณุงุณู', 1, 'md') 
end 
end 
--     Source Storm     --
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
DevRio:set(storm..'Save:UserName'..msg.sender_user_id_,data.username_)
end;end,nil) 
--     Source Storm     --
local ReFalse = tostring(msg.chat_id_)
if not DevRio:sismember(storm.."Rio:Groups",msg.chat_id_) and not ReFalse:match("^(%d+)") and not SudoBot(msg) then
print("Return False : The Bot Is Not Enabled In The Group")
return false
end
--     Source Storm     --
-------- MSG TYPES ---------
if msg.content_.ID == "MessageChatJoinByLink" and not VipMem(msg) then 
if DevRio:get(storm..'Rio:Lock:Robot'..msg.chat_id_) then
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,dp) 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..dp.id_)
DevRio:sadd(storm..'Rio:Tkeed:'..msg.chat_id_, dp.id_)
local Text = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ ['..string.sub(dp.first_name_,0, 40)..'](tg://user?id='..dp.id_..')\nโ๏ธูุฌุจ ุนูููุง ุงูุชุฃูุฏ ุฃูู ูุณุช ุฑูุจูุช\nโ๏ธุชู ุชููุฏู ุงุถุบุท ุงูุฒุฑ ุจุงูุงุณูู ูููู'
keyboard = {} 
keyboard.inline_keyboard = {{{text="ุงุถุบุท ููุง ููู ุชููุฏู",callback_data="/UnTkeed"}}} 
Msg_id = msg.id_/2097152/0.5
HTTPS.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text='..URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
return false
end
if DevRio:get(storm.."Rio:Lock:Join"..msg.chat_id_) then
ChatKick(msg.chat_id_,msg.sender_user_id_) 
return false  
end
end
if msg.content_.ID == "MessagePhoto" then
if not Manager(msg) then 
local filter = DevRio:smembers(storm.."Rio:FilterPhoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","โ๏ธุงูุตูุฑู ุงูุชู ุงุฑุณูุชูุง ุชู ููุนูุง ูู ุงููุฌููุนู")  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false   
end
end
end
end
if msg.content_.ID == "MessageAnimation" then
if not Manager(msg) then 
local filter = DevRio:smembers(storm.."Rio:FilterAnimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","โ๏ธุงููุชุญุฑูู ุงูุชู ุงุฑุณูุชูุง ุชู ููุนูุง ูู ุงููุฌููุนู")  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
end
if msg.content_.ID == "MessageSticker" then
if not Manager(msg) then 
local filter = DevRio:smembers(storm.."Rio:FilterSteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.sticker_.persistent_id_ then
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","โ๏ธุงูููุตู ุงูุฐู ุงุฑุณูุชู ุชู ููุนู ูู ุงููุฌููุนู")  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false   
end
end
end
end
--     Source Storm     --
if text and text:match("^(.*)$") then
local DelGpRedRedods = DevRio:get(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
local GetGpTexts = DevRio:get(storm..'Rio:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_)
if DelGpRedRedods == 'DelGpRedRedods' then
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุงูุฑุฏ โคฝ '..msg.content_.text_..' ูููููู โคฝ '..GetGpTexts..' ุชู ุญุฐููุง',  1, "html")
DevRio:del(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
DevRio:srem(storm..'Rio:Text:GpTexts'..GetGpTexts..msg.chat_id_,msg.content_.text_)
return false
end
end
if text and text:match("^(.*)$") then
local DelGpRed = DevRio:get(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
if DelGpRed == 'DelGpRedod' then
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุงููููู ( '..msg.content_.text_..' ) ุชู ุญุฐููุง',  1, "html")
DevRio:del(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
DevRio:del(storm..'Rio:Text:GpTexts'..msg.content_.text_..msg.chat_id_)
DevRio:srem(storm..'Rio:Manager:GpRedod'..msg.chat_id_,msg.content_.text_)
return false
end
end
if text and text:match("^(.*)$") then
local DelGpRed = DevRio:get(storm..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
if DelGpRed == 'DelGpRed' then
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุงููููู ( '..msg.content_.text_..' ) ุชู ุญุฐููุง',  1, "html")
DevRio:del(storm..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
DevRio:del(storm..'Rio:Gif:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(storm..'Rio:Voice:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(storm..'Rio:Audio:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(storm..'Rio:Photo:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(storm..'Rio:Stecker:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(storm..'Rio:Video:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(storm..'Rio:File:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(storm..'Rio:Text:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:srem(storm..'Rio:Manager:GpRed'..msg.chat_id_,msg.content_.text_)
return false
end
end
if text and text:match("^(.*)$") then
local DelAllRed = DevRio:get(storm.."Rio:Add:AllRed"..msg.sender_user_id_)
if DelAllRed == 'DelAllRed' then
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุงููููู ( '..msg.content_.text_..' ) ุชู ุญุฐููุง',  1, "html")
DevRio:del(storm.."Rio:Add:AllRed"..msg.sender_user_id_)
DevRio:del(storm.."Rio:Gif:AllRed"..msg.content_.text_)
DevRio:del(storm.."Rio:Voice:AllRed"..msg.content_.text_)
DevRio:del(storm.."Rio:Audio:AllRed"..msg.content_.text_)
DevRio:del(storm.."Rio:Photo:AllRed"..msg.content_.text_)
DevRio:del(storm.."Rio:Stecker:AllRed"..msg.content_.text_)
DevRio:del(storm.."Rio:Video:AllRed"..msg.content_.text_)
DevRio:del(storm.."Rio:File:AllRed"..msg.content_.text_)
DevRio:del(storm.."Rio:Text:AllRed"..msg.content_.text_)
DevRio:del(storm.."Rio:Sudo:AllRed",msg.content_.text_)
return false
end
end
--     Source Storm     --
if text and text:match("^(.*)$") then
local SaveGpRedod = DevRio:get(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
if SaveGpRedod == 'SaveGpRedod' then
local GetGpTexts = DevRio:get(storm..'Rio:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_)
local List = DevRio:smembers(storm..'Rio:Text:GpTexts'..GetGpTexts..msg.chat_id_)
if text == "ุงูุบุงุก" then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธโ๏ธุชู ุงูุบุงุก ุนูููุฉ ุญูุธ ุงูุฑุฏูุฏ ุงููุชุนุฏุฏู ููุงูุฑ โคฝ "..GetGpTexts ,  1, "md")
DevRio:del(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
DevRio:del(storm..'Rio:Text:GpTexts'..GetGpTexts..msg.chat_id_)
DevRio:del(storm..'Rio:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_)
DevRio:srem(storm..'Rio:Manager:GpRedod'..msg.chat_id_,GetGpTexts)
return false
end
Text = text:gsub('"',""):gsub('"',""):gsub("`",""):gsub("*","")
DevRio:sadd(storm..'Rio:Text:GpTexts'..GetGpTexts..msg.chat_id_,Text)
if #List == 4 then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ โคฝ 5 ูู ุงูุฑุฏูุฏ ุงููุชุนุฏุฏู ููุงูุฑ โคฝ "..GetGpTexts ,  1, "md")
DevRio:del(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
return false
end
local Rio = "โ๏ธุชู ุญูุธ ุงูุฑุฏ ุฑูู โคฝ "..(#List+1).."\nโ๏ธูู ุจุงุฑุณุงู ุงูุฑุฏ ุฑูู โคฝ "..(#List+2)
keyboard = {} 
keyboard.inline_keyboard = {{{text="ุงููุงุก ูุญูุธ "..(#List+1).." ูู ุงูุฑุฏูุฏ",callback_data="/EndRedod:"..msg.sender_user_id_..GetGpTexts}},{{text="ุงูุบุงุก ูุญุฐู ุงูุชุฎุฒูู",callback_data="/DelRedod:"..msg.sender_user_id_..GetGpTexts}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Rio).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
end
if text and not DevRio:get(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_) then
if DevRio:sismember(storm..'Rio:Manager:GpRedod'..msg.chat_id_,text) then
local stormTeam =  DevRio:smembers(storm..'Rio:Text:GpTexts'..text..msg.chat_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, '['..stormTeam[math.random(#stormTeam)]..']' , 1, 'md')  
end
end
--     Source Storm     --
if msg.content_.text_ or msg.content_.video_ or msg.content_.document_ or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.audio_ or msg.content_.photo_ or msg.content_.animation_ then 
local SaveGpRed = DevRio:get(storm..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
if SaveGpRed == 'SaveGpRed' then 
if text == 'ุงูุบุงุก' then
local DelManagerRep = DevRio:get(storm..'DelManagerRep'..msg.chat_id_)
DevRio:srem(storm..'Rio:Manager:GpRed'..msg.chat_id_,DelManagerRep)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุญูุธ ุงูุฑุฏ', 1, 'md')
DevRio:del(storm..'Rio:Add:GpText'..msg.sender_user_id_..msg.chat_id_)
DevRio:del(storm..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
DevRio:del(storm..'DelManagerRep'..msg.chat_id_)
return false
end
DevRio:del(storm..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
local SaveGpRed = DevRio:get(storm..'Rio:Add:GpText'..msg.sender_user_id_..msg.chat_id_)
if msg.content_.video_ then DevRio:set(storm..'Rio:Video:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.video_.video_.persistent_id_)
end
if msg.content_.document_ then DevRio:set(storm..'Rio:File:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.document_.document_.persistent_id_)
end
if msg.content_.sticker_ then DevRio:set(storm..'Rio:Stecker:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_) 
end 
if msg.content_.voice_ then DevRio:set(storm..'Rio:Voice:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_) 
end
if msg.content_.audio_ then DevRio:set(storm..'Rio:Audio:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_) 
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
DevRio:set(storm..'Rio:Photo:GpRed'..SaveGpRed..msg.chat_id_, photo_in_group) 
end
if msg.content_.animation_ then DevRio:set(storm..'Rio:Gif:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_) 
end 
if msg.content_.text_ then
DevRio:set(storm..'Rio:Text:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.text_)
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญูุธ ุงูุฑุฏ ุงูุฌุฏูุฏ', 1, 'md') 
DevRio:del(storm..'Rio:Add:GpText'..msg.sender_user_id_..msg.chat_id_)
DevRio:del(storm..'DelManagerRep'..msg.chat_id_)
return false 
end 
end
if msg.content_.text_ and not DevRio:get(storm..'Rio:Lock:GpRed'..msg.chat_id_) then 
if DevRio:get(storm..'Rio:Video:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendVideo(msg.chat_id_, msg.id_, 0, 1,nil, DevRio:get(storm..'Rio:Video:GpRed'..msg.content_.text_..msg.chat_id_)) 
end 
if DevRio:get(storm..'Rio:File:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, DevRio:get(storm..'Rio:File:GpRed'..msg.content_.text_..msg.chat_id_)) 
end 
if DevRio:get(storm..'Rio:Voice:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(storm..'Rio:Voice:GpRed'..msg.content_.text_..msg.chat_id_)) 
end
if DevRio:get(storm..'Rio:Audio:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendAudio(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(storm..'Rio:Audio:GpRed'..msg.content_.text_..msg.chat_id_)) 
end
if DevRio:get(storm..'Rio:Photo:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(storm..'Rio:Photo:GpRed'..msg.content_.text_..msg.chat_id_)) 
end
if DevRio:get(storm..'Rio:Gif:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(storm..'Rio:Gif:GpRed'..msg.content_.text_..msg.chat_id_)) 
end 
if DevRio:get(storm..'Rio:Stecker:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendSticker(msg.chat_id_, msg.id_, 0, 1,nil, DevRio:get(storm..'Rio:Stecker:GpRed'..msg.content_.text_..msg.chat_id_))
end
if DevRio:get(storm..'Rio:Text:GpRed'..msg.content_.text_..msg.chat_id_) then
function stormTeam(extra,result,success)
if result.username_ then username = '[@'..result.username_..']' else username = 'ูุง ููุฌุฏ' end
local edit_msg = DevRio:get(storm..'Rio:EditMsg'..msg.chat_id_..msg.sender_user_id_) or 0
local user_msgs = DevRio:get(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
local Text = DevRio:get(storm..'Rio:Text:GpRed'..msg.content_.text_..msg.chat_id_)
local Text = Text:gsub('#username',(username or 'ูุง ููุฌุฏ')) 
local Text = Text:gsub('#name','['..result.first_name_..']')
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',edit_msg)
local Text = Text:gsub('#msgs',(user_msgs or 'ูุง ููุฌุฏ'))
local Text = Text:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'ูุง ููุฌุฏ'))
send(msg.chat_id_,msg.id_,Text)
end
getUser(msg.sender_user_id_, stormTeam)
end
end
--     Source Storm     --
text = msg.content_.text_
if msg.content_.text_ or msg.content_.video_ or msg.content_.document_ or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.audio_ or msg.content_.photo_ or msg.content_.animation_ then
local SaveAllRed = DevRio:get(storm.."Rio:Add:AllRed"..msg.sender_user_id_)
if SaveAllRed == 'SaveAllRed' then
if text == 'ุงูุบุงุก' then
local DelSudoRep = DevRio:get(storm..'DelSudoRep')
DevRio:del(storm.."Rio:Sudo:AllRed",DelSudoRep)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุญูุธ ุงูุฑุฏ', 1, 'md')
DevRio:del(storm.."Rio:Add:AllText"..msg.sender_user_id_)
DevRio:del(storm.."Rio:Add:AllRed"..msg.sender_user_id_)
DevRio:del(storm.."DelSudoRep")
return false
end
DevRio:del(storm.."Rio:Add:AllRed"..msg.sender_user_id_)
local SaveAllRed = DevRio:get(storm.."Rio:Add:AllText"..msg.sender_user_id_)
if msg.content_.video_ then
DevRio:set(storm.."Rio:Video:AllRed"..SaveAllRed, msg.content_.video_.video_.persistent_id_)
end
if msg.content_.document_ then
DevRio:set(storm.."Rio:File:AllRed"..SaveAllRed, msg.content_.document_.document_.persistent_id_)
end
if msg.content_.sticker_ then
DevRio:set(storm.."Rio:Stecker:AllRed"..SaveAllRed, msg.content_.sticker_.sticker_.persistent_id_)
end
if msg.content_.voice_ then
DevRio:set(storm.."Rio:Voice:AllRed"..SaveAllRed, msg.content_.voice_.voice_.persistent_id_)
end
if msg.content_.audio_ then
DevRio:set(storm.."Rio:Audio:AllRed"..SaveAllRed, msg.content_.audio_.audio_.persistent_id_)
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_all_groups = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_all_groups = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_all_groups = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_all_groups = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
DevRio:set(storm.."Rio:Photo:AllRed"..SaveAllRed, photo_in_all_groups)
end
if msg.content_.animation_ then
DevRio:set(storm.."Rio:Gif:AllRed"..SaveAllRed, msg.content_.animation_.animation_.persistent_id_)
end
if msg.content_.text_ then
DevRio:set(storm.."Rio:Text:AllRed"..SaveAllRed, msg.content_.text_)
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญูุธ ุงูุฑุฏ ุงูุฌุฏูุฏ', 1, 'md') 
DevRio:del(storm.."Rio:Add:AllText"..msg.sender_user_id_)
DevRio:del(storm..'DelSudoRep')
return false end end
if msg.content_.text_ and not DevRio:get(storm..'Rio:Lock:AllRed'..msg.chat_id_) then
if DevRio:get(storm.."Rio:Video:AllRed"..msg.content_.text_) then
sendVideo(msg.chat_id_, msg.id_, 0, 1,nil, DevRio:get(storm.."Rio:Video:AllRed"..msg.content_.text_))
end
if DevRio:get(storm.."Rio:File:AllRed"..msg.content_.text_) then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, DevRio:get(storm.."Rio:File:AllRed"..msg.content_.text_))
end
if DevRio:get(storm.."Rio:Voice:AllRed"..msg.content_.text_)  then
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(storm.."Rio:Voice:AllRed"..msg.content_.text_))
end
if DevRio:get(storm.."Rio:Audio:AllRed"..msg.content_.text_)  then
sendAudio(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(storm.."Rio:Audio:AllRed"..msg.content_.text_))
end
if DevRio:get(storm.."Rio:Photo:AllRed"..msg.content_.text_)  then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(storm.."Rio:Photo:AllRed"..msg.content_.text_))
end
if  DevRio:get(storm.."Rio:Gif:AllRed"..msg.content_.text_) then
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(storm.."Rio:Gif:AllRed"..msg.content_.text_))
end
if DevRio:get(storm.."Rio:Stecker:AllRed"..msg.content_.text_) then
sendSticker(msg.chat_id_, msg.id_, 0, 1,nil, DevRio:get(storm.."Rio:Stecker:AllRed"..msg.content_.text_))
end
if DevRio:get(storm.."Rio:Text:AllRed"..msg.content_.text_) then
function stormTeam(extra,result,success)
if result.username_ then username = '[@'..result.username_..']' else username = 'ูุง ููุฌุฏ' end
local edit_msg = DevRio:get(storm..'Rio:EditMsg'..msg.chat_id_..msg.sender_user_id_) or 0
local user_msgs = DevRio:get(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
local Text = DevRio:get(storm.."Rio:Text:AllRed"..msg.content_.text_)
local Text = Text:gsub('#username',(username or 'ูุง ููุฌุฏ')) 
local Text = Text:gsub('#name','['..result.first_name_..']')
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',edit_msg)
local Text = Text:gsub('#msgs',(user_msgs or 'ูุง ููุฌุฏ'))
local Text = Text:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'ูุง ููุฌุฏ'))
send(msg.chat_id_,msg.id_,Text)
end
getUser(msg.sender_user_id_, stormTeam)
end
end 
--     Source Storm     --
--       Spam Send        --
function NotSpam(msg,Type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,dp) 
local GetName = '['..dp.first_name_..'](tg://user?id='..dp.id_..')'
if Type == "kick" then 
ChatKick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = 'โ๏ธุงูุนุถู โคฝ '..GetName..' \nโ๏ธูุงู ุจุงูุชูุฑุงุฑ ุงููุญุฏุฏ ุชู ุทุฑุฏู '
SendText(msg.chat_id_,Text,0,'md')
return false  
end 
if Type == "del" then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false  
end 
if Type == "keed" and not DevRio:sismember(storm..'Rio:Tkeed:'..msg.chat_id_, msg.sender_user_id_) then
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_.."") 
DevRio:sadd(storm..'Rio:Tkeed:'..msg.chat_id_, msg.sender_user_id_)
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = 'โ๏ธุงูุนุถู โคฝ '..GetName..' \nโ๏ธูุงู ุจุงูุชูุฑุงุฑ ุงููุญุฏุฏ ุชู ุชููุฏู '
SendText(msg.chat_id_,Text,0,'md')
return false  
end  
if Type == "mute" and not DevRio:sismember(storm..'Rio:Muted:'..msg.chat_id_, msg.sender_user_id_) then
DevRio:sadd(storm..'Rio:Muted:'..msg.chat_id_,msg.sender_user_id_)
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = 'โ๏ธุงูุนุถู โคฝ '..GetName..' \nโ๏ธูุงู ุจุงูุชูุฑุงุฑ ุงููุญุฏุฏ ุชู ูุชูู '
SendText(msg.chat_id_,Text,0,'md')
return false  
end
end,nil)
end  
--  end functions storm --
--     Source Storm     --
--       Spam Check       --
if not VipMem(msg) and msg.content_.ID ~= "MessageChatAddMembers" and DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Spam:User") then 
if msg.sender_user_id_ ~= storm then
floods = DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Spam:User") or "nil"
Num_Msg_Max = DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5
Time_Spam = DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 5
local post_count = tonumber(DevRio:get(storm.."Rio:Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_) or 0)
if post_count > tonumber(DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5) then 
local ch = msg.chat_id_
local type = DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Spam:User") 
NotSpam(msg,type)  
end
DevRio:setex(storm.."Rio:Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_, tonumber(DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 3), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam") then
Num_Msg_Max = DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam") 
end
if DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") then
Time_Spam = DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") 
end 
end
end 
--     Source Storm     --
----- START MSG CHECKS -----
if msg.sender_user_id_ and Ban(msg.sender_user_id_, msg.chat_id_) then
ChatKick(msg.chat_id_, msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
if msg.sender_user_id_ and BanAll(msg.sender_user_id_) then
ChatKick(msg.chat_id_, msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
if msg.sender_user_id_ and Muted(msg.sender_user_id_, msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
if msg.sender_user_id_ and MuteAll(msg.sender_user_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
if msg.content_.ID == "MessagePinMessage" then
if Constructor(msg) or tonumber(msg.sender_user_id_) == tonumber(storm) then
DevRio:set(storm..'Rio:PinnedMsg'..msg.chat_id_,msg.content_.message_id_)
else
local pin_id = DevRio:get(storm..'Rio:PinnedMsg'..msg.chat_id_)
if pin_id and DevRio:get(storm..'Rio:Lock:Pin'..msg.chat_id_) then
pinmsg(msg.chat_id_,pin_id,0)
end
end
end
if DevRio:get(storm..'Rio:viewget'..msg.sender_user_id_) then
if not msg.forward_info_ then
DevRio:del(storm..'Rio:viewget'..msg.sender_user_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุนุฏุฏ ูุดุงูุฏุงุช ุงูููุดูุฑ ูู โคฝ ('..msg.views_..')', 1, 'md')
DevRio:del(storm..'Rio:viewget'..msg.sender_user_id_)
end
end
--     Source Storm     --
--         Photo          --
if msg.content_.ID == "MessagePhoto" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(storm..'Rio:Lock:Photo'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(storm..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(storm..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(storm..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(storm..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(storm..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(storm..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Storm     --
--        Markdown        --
elseif not msg.reply_markup_ and msg.via_bot_user_id_ ~= 0 then
if DevRio:get(storm..'Rio:Lock:Markdown'..msg.chat_id_) then
if not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
--     Source Storm     --
--        Document        --
elseif msg.content_.ID == "MessageDocument" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(storm..'Rio:Lock:Document'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(storm..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(storm..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(storm..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(storm..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(storm..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(storm..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Storm     --
--         Inline         --
elseif msg.reply_markup_ and msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" and msg.via_bot_user_id_ ~= 0 then
if not VipMem(msg) then
if DevRio:get(storm..'Rio:Lock:Inline'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
--     Source Storm     --
--        Sticker         --
elseif msg.content_.ID == "MessageSticker" then
if not VipMem(msg) then
if DevRio:get(storm..'Rio:Lock:Stickers'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
elseif msg.content_.ID == "MessageChatJoinByLink" then
if DevRio:get(storm..'Rio:Lock:TagServr'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return
end
function get_welcome(extra,result,success)
if DevRio:get(storm..'Rio:Groups:Welcomes'..msg.chat_id_) then
Welcomes = DevRio:get(storm..'Rio:Groups:Welcomes'..msg.chat_id_)
else
Welcomes = 'โข ููุฑุช ุญุจู \nโข firstname \nโข username'
end
local Welcomes = Welcomes:gsub('"',"") Welcomes = Welcomes:gsub("'","") Welcomes = Welcomes:gsub(",","") Welcomes = Welcomes:gsub("*","") Welcomes = Welcomes:gsub(";","") Welcomes = Welcomes:gsub("`","") Welcomes = Welcomes:gsub("{","") Welcomes = Welcomes:gsub("}","") 
local Welcomes = Welcomes:gsub('firstname',('['..result.first_name_..']' or ''))
local Welcomes = Welcomes:gsub('username',('[@'..result.username_..']' or '[@So_ST0RM]'))
Dev_Rio(msg.chat_id_, msg.id_, 1, Welcomes, 1, 'md')
end 
if DevRio:get(storm.."Rio:Lock:Welcome"..msg.chat_id_) then
getUser(msg.sender_user_id_,get_welcome)
end

--     Source Storm     --
--      New User Add      --
elseif msg.content_.ID == "MessageChatAddMembers" then
if not DevRio:get(storm..'Rio:Lock:BotWelcome') then 
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = storm,offset_ = 0,limit_ = 1},function(extra,rio,success) 
for i=0,#msg.content_.members_ do    
BotWelcome = msg.content_.members_[i].id_    
if BotWelcome and BotWelcome == tonumber(storm) then 
if DevRio:sismember(storm..'Rio:Groups',msg.chat_id_) then BotText = "ููุนูู ูู ุงูุณุงุจู\nโ๏ธุงุฑุณู โคฝ ุงูุงูุงูุฑ ูุงุณุชูุชุน ุจุงููููุฒูุงุช" else BotText = "ูุนุทูู ูุฌุจ ุฑูุนู ูุดุฑู\nโ๏ธุจุนุฏ ุฐูู ูุฑุฌู ุงุฑุณุงู ุงูุฑ โคฝ ุชูุนูู\nโ๏ธุณูุชู ุฑูุน ุงูุงุฏูููู ูุงูููุดุฆ ุชููุงุฆูุง" end 
if DevRio:get(storm.."Rio:Text:BotWelcome") then RioText = DevRio:get(storm.."Rio:Text:BotWelcome") else RioText = "โ๏ธูุฑุญุจุง ุงูุง ุจูุช ุงุณูู "..NameBot.."\nโ๏ธุญุงูุฉ ุงููุฌููุนู โคฝ "..BotText.."\nโ โ โ โ โ โ โ โ โ" end 
if DevRio:get(storm.."Rio:Photo:BotWelcome") then RioPhoto = DevRio:get(storm.."Rio:Photo:BotWelcome") elseif rio.photos_[0] then RioPhoto = rio.photos_[0].sizes_[1].photo_.persistent_id_ else RioPhoto = nil end 
if RioPhoto ~= nil then
sendPhoto(msg.chat_id_,msg.id_,0,1,nil,RioPhoto,RioText)
else 
send(msg.chat_id_,msg.id_,RioText)
end 
end   
end
end,nil)
end
if DevRio:get(storm..'Rio:Lock:TagServr'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return
end
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban(msg.content_.members_[0].id_, msg.chat_id_) then
ChatKick(msg.chat_id_, msg.content_.members_[0].id_)
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and BanAll(msg.content_.members_[0].id_) then
ChatKick(msg.chat_id_, msg.content_.members_[0].id_)
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
if DevRio:get(storm.."Rio:Lock:Welcome"..msg.chat_id_) then
if DevRio:get(storm..'Rio:Groups:Welcomes'..msg.chat_id_) then
Welcomes = DevRio:get(storm..'Rio:Groups:Welcomes'..msg.chat_id_)
else
Welcomes = 'โข ููุฑุช ุญุจู \nโข firstname \nโข username'
end
local Welcomes = Welcomes:gsub('"',"") Welcomes = Welcomes:gsub("'","") Welcomes = Welcomes:gsub(",","") Welcomes = Welcomes:gsub("*","") Welcomes = Welcomes:gsub(";","") Welcomes = Welcomes:gsub("`","") Welcomes = Welcomes:gsub("{","") Welcomes = Welcomes:gsub("}","") 
local Welcomes = Welcomes:gsub('firstname',('['..msg.content_.members_[0].first_name_..']' or ''))
local Welcomes = Welcomes:gsub('username',('[@'..msg.content_.members_[0].username_..']' or '[@So_ST0RM]'))
Dev_Rio(msg.chat_id_, msg.id_, 1, Welcomes, 1, 'md')
end
--     Source Storm     --
--        Contact         --
elseif msg.content_.ID == "MessageContact" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(storm..'Rio:Lock:Contact'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
--     Source Storm     --
--         Audio          --
elseif msg.content_.ID == "MessageAudio" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(storm..'Rio:Lock:Music'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(storm..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(storm..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(storm..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(storm..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(storm..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(storm..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Storm     --
--         Voice          --
elseif msg.content_.ID == "MessageVoice" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(storm..'Rio:Lock:Voice'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(storm..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(storm..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(storm..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(storm..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(storm..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(storm..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Storm     --
--        Location        --
elseif msg.content_.ID == "MessageLocation" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(storm..'Rio:Lock:Location'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(storm..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(storm..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(storm..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(storm..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(storm..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(storm..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Storm     --
--         Video          --
elseif msg.content_.ID == "MessageVideo" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(storm..'Rio:Lock:Videos'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(storm..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(storm..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(storm..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(storm..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(storm..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(storm..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Storm     --
--          Gif           --
elseif msg.content_.ID == "MessageAnimation" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(storm..'Rio:Lock:Gifs'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(storm..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(storm..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(storm..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(storm..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(storm..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(storm..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Storm     --
--         Text           --
elseif msg.content_.ID == "MessageText" then
if not VipMem(msg) then
Filters(msg,text)
if msg.forward_info_ then
if DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
if DevRio:get(storm..'Rio:Lock:Links'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(storm..'Rio:Lock:Text'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.text_:match("@") then
if DevRio:get(storm..'Rio:Lock:Tags'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.text_:match("#") then
if DevRio:get(storm..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if text:match("[Hh][Tt][Tt][Pp][Ss]://") or text:match("[Hh][Tt][Tt][Pp]://") or text:match(".[Ii][Rr]") or text:match(".[Cc][Oo][Mm]") or text:match(".[Oo][Rr][Gg]") or text:match(".[Ii][Nn][Ff][Oo]") or text:match("[Ww][Ww][Ww].") or text:match(".[Tt][Kk]") or text:match(".[Xx][Yy][Zz]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(storm..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.text_:match("[\216-\219][\128-\191]") then
if DevRio:get(storm..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.text_ then
local _nl, ctrl_chars = string.gsub(text, '%c', '')
local _nl, real_digits = string.gsub(text, '%d', '')
if not DevRio:get(storm..'Rio:Spam:Text'..msg.chat_id_) then
sens = 400
else
sens = tonumber(DevRio:get(storm..'Rio:Spam:Text'..msg.chat_id_))
end
if DevRio:get(storm..'Rio:Lock:Spam'..msg.chat_id_) and string.len(msg.content_.text_) > (sens) or ctrl_chars > (sens) or real_digits > (sens) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.text_:match("[A-Z]") or msg.content_.text_:match("[a-z]") then
if DevRio:get(storm..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
--     Source Storm     --
if DevRio:get(storm.."Rio:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_) then
if text == "ุงูุบุงุก" then
send(msg.chat_id_,msg.id_,"โ๏ธุชู ุงูุบุงุก ุญูุธ ุงูุฑุงุจุท")       
DevRio:del(storm.."Rio:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_) 
return false
end
if msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)") then
local Link = msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)")
DevRio:set(storm.."Rio:Groups:Links"..msg.chat_id_,Link)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญูุธ ุงูุฑุงุจุท ุจูุฌุงุญ', 1, 'md')
DevRio:del(storm.."Rio:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_) 
return false 
end
end
--     Source Storm     --
local msg = data.message_
text = msg.content_.text_
if text and Constructor(msg) then 
if DevRio:get('stormTeam:'..storm.."numadd:user"..msg.chat_id_.."" .. msg.sender_user_id_) then 
if text and text:match("^ุงูุบุงุก$") then 
DevRio:del('stormTeam:'..storm..'id:user'..msg.chat_id_)  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุงูุฑ', 1, 'md')
DevRio:del('stormTeam:'..storm.."numadd:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
return false  end 
DevRio:del('stormTeam:'..storm.."numadd:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = DevRio:get('stormTeam:'..storm..'id:user'..msg.chat_id_)  
DevRio:incrby(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..iduserr,numadded)
Dev_Rio(msg.chat_id_, msg.id_,  1, "โ๏ธุชู ุงุถุงูุฉ "..numadded..' ุฑุณุงูู', 1, 'md')
DevRio:del('stormTeam:'..storm..'id:user'..msg.chat_id_) 
end
end
if text and Constructor(msg) then 
if DevRio:get('stormTeam:'..storm.."nmadd:user"..msg.chat_id_.."" .. msg.sender_user_id_) then 
if text and text:match("^ุงูุบุงุก$") then 
DevRio:del('stormTeam:'..storm..'ids:user'..msg.chat_id_)  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุงูุฑ', 1, 'md')
DevRio:del('stormTeam:'..storm.."nmadd:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
return false  end 
DevRio:del('stormTeam:'..storm.."nmadd:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = DevRio:get('stormTeam:'..storm..'ids:user'..msg.chat_id_)  
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..iduserr,numadded)  
Dev_Rio(msg.chat_id_, msg.id_,  1, "โ๏ธุชู ุงุถุงูุฉ "..numadded..' ููุทู', 1, 'md')
DevRio:del('stormTeam:'..storm..'ids:user'..msg.chat_id_)  
end
end
--     Source Storm     --
if text and (text:match("ุทูุฒ") or text:match("ุฏูุณ") or text:match("ุงููุฌ") or text:match("ููุฌ") or text:match("ุฏููุณ") or text:match("ุนูุฑ") or text:match("ูุณุฎุชู") or text:match("ูุณูู") or text:match("ูุณุฑุจู") or text:match("ุจูุงุน") or text:match("ุงุจู ุงูุนููุฑู") or text:match("ููููุฌ") or text:match("ูุญุจู") or text:match("ูุญุงุจ") or text:match("ุงููุญุจู") or text:match("ูุณู") or text:match("ุทูุฒู") or text:match("ูุณ ุงูู") or text:match("ุตุฑู") or text:match("ูุณ ุงุฎุชู")) then
if not DevRio:get(storm.."Rio:Lock:Fshar"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","โ๏ธููููุน ุงููุดุงุฑ ูู ุงููุฌููุนู")  
end end
if text and (text:match("ฺฌ") or text:match("ูบ") or text:match("ฺ") or text:match("ฺ") or text:match("ฺฟ") or text:match("ฺ") or text:match("ฺ") or text:match("?ซ") or text:match("ฺ") or text:match("ฺ") or text:match("?") or text:match("ฺธ") or text:match("ูพ") or text:match("?ด") or text:match("ูฺฉ") or text:match("ุฒุฏู") or text:match("ุฏุฎุชุฑุง") or text:match("ุฏ?ูุซ") or text:match("ฺฉู?ูพุดู") or text:match("ุฎูุดุดูู") or text:match("ู?ุฏุง") or text:match("ฺฉู") or text:match("ุจุฏุงู?ู") or text:match("ุจุง?ุฏ") or text:match("ุฒูุงุดู??") or text:match("ุขููุฒุด") or text:match("ุฑุงุญุช?") or text:match("ุฎุณุชู") or text:match("ุจ?ุงู") or text:match("ุจูพูุดู") or text:match("ูุฑูู")) then
if DevRio:get(storm.."Rio:Lock:Farsi"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","โ๏ธููููุน ุงูุชููู ุจุงูุบู ุงููุงุฑุณูู ููุง")  
end end
if text and (text:match("ฺฌ") or text:match("ูบ") or text:match("ฺ") or text:match("ฺ") or text:match("ฺฟ") or text:match("ฺ") or text:match("ฺ") or text:match("?ซ") or text:match("ฺ") or text:match("ฺ") or text:match("?") or text:match("ฺธ") or text:match("ูพ") or text:match("?ด") or text:match("ูฺฉ") or text:match("ุฒุฏู") or text:match("ุฏุฎุชุฑุง") or text:match("ุฏ?ูุซ") or text:match("ฺฉู?ูพุดู") or text:match("ุฎูุดุดูู") or text:match("ู?ุฏุง") or text:match("ฺฉู") or text:match("ุจุฏุงู?ู") or text:match("ุจุง?ุฏ") or text:match("ุฒูุงุดู??") or text:match("ุขููุฒุด") or text:match("ุฑุงุญุช?") or text:match("ุฎุณุชู") or text:match("ุจ?ุงู") or text:match("ุจูพูุดู") or text:match("ูุฑูู")) then
if DevRio:get(storm.."Rio:Lock:FarsiBan"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ChatKick(msg.chat_id_, msg.sender_user_id_)
end end 
if text and (text:match("ุฎุฑู ุจุงููู") or text:match("ุฎุจุฑุจู") or text:match("ูุณุฏููุฑุจู") or text:match("ุฎุฑุจ ุจุงููู") or text:match("ุฎุฑุจ ุงููู") or text:match("ุฎุฑู ุจุฑุจู") or text:match("ุงููู ุงูููุงุฏ") or text:match("ุฎุฑู ุจูุญูุฏ") or text:match("ูุณู ุงููู") or text:match("ูุณู ุฑุจู") or text:match("ูุณุฑุจู") or text:match("ูุณุฎุชุงููู") or text:match("ูุณุฎุช ุงููู") or text:match("ุฎุฑู ุจุฏููู") or text:match("ุฎุฑูุจุฏููู") or text:match("ูุณุงููู") or text:match("ุฎุฑุจุงููู")) then
if not DevRio:get(storm.."Rio:Lock:Kfr"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","โ๏ธููููุน ุงูููุฑ ูู ุงููุฌููุนู") 
end end
if text and (text:match("ุณูู ููุณ") or text:match("ุดูุนู") or text:match("ุงูุดูุนู") or text:match("ุงูุณูู") or text:match("ุทุงุฆูุชูู") or text:match("ุดูุนู") or text:match("ุงูุง ุณูู") or text:match("ูุณูุญู") or text:match("ูููุฏู") or text:match("ุตุงุจุฆู") or text:match("ููุญุฏ") or text:match("ุจุงูุณูู") or text:match("ุดูุนุฉ")) then
if not DevRio:get(storm.."Rio:Lock:Taf"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","โ๏ธููููุน ุงูุชููู ุจุงูุทุงุฆููู ููุง") 
end end
--     Source Storm     --
if SecondSudo(msg) then
if text == 'ุฌูุจ ูุณุฎู ุงูุฌุฑูุจุงุช' and ChCheck(msg) or text == 'ุฌูุจ ูุณุฎู ุงุญุชูุงุทูู' and ChCheck(msg) or text == 'ุฌูุจ ุงููุณุฎู ุงูุงุญุชูุงุทูู' and ChCheck(msg) or text == 'โคฝ ุฌูุจ ูุณุฎู ุงุญุชูุงุทูู โ' and ChCheck(msg) then
local List = DevRio:smembers(storm..'Rio:Groups') 
local BotName = (DevRio:get(storm.."Rio:NameBot") or 'ุณุชูุฑู')
local GetJson = '{"BotId": '..storm..',"BotName": "'..BotName..'","GroupsList":{'  
for k,v in pairs(List) do 
LinkGroups = DevRio:get(storm.."Rio:Groups:Links"..v)
Welcomes = DevRio:get(storm..'Rio:Groups:Welcomes'..v) or ''
Welcomes = Welcomes:gsub('"',"") Welcomes = Welcomes:gsub("'","") Welcomes = Welcomes:gsub(",","") Welcomes = Welcomes:gsub("*","") Welcomes = Welcomes:gsub(";","") Welcomes = Welcomes:gsub("`","") Welcomes = Welcomes:gsub("{","") Welcomes = Welcomes:gsub("}","") 
RioConstructors = DevRio:smembers(storm..'Rio:RioConstructor:'..v)
Constructors = DevRio:smembers(storm..'Rio:BasicConstructor:'..v)
BasicConstructors = DevRio:smembers(storm..'Rio:Constructor:'..v)
Managers = DevRio:smembers(storm..'Rio:Managers:'..v)
Admis = DevRio:smembers(storm..'Rio:Admins:'..v)
Vips = DevRio:smembers(storm..'Rio:VipMem:'..v)
if k == 1 then
GetJson = GetJson..'"'..v..'":{'
else
GetJson = GetJson..',"'..v..'":{'
end
if #Vips ~= 0 then 
GetJson = GetJson..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Admis ~= 0 then
GetJson = GetJson..'"Admis":['
for k,v in pairs(Admis) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Managers ~= 0 then
GetJson = GetJson..'"Managers":['
for k,v in pairs(Managers) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Constructors ~= 0 then
GetJson = GetJson..'"Constructors":['
for k,v in pairs(Constructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #BasicConstructors ~= 0 then
GetJson = GetJson..'"BasicConstructors":['
for k,v in pairs(BasicConstructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #RioConstructors ~= 0 then
GetJson = GetJson..'"RioConstructors":['
for k,v in pairs(RioConstructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if LinkGroups then
GetJson = GetJson..'"LinkGroups":"'..LinkGroups..'",'
end
GetJson = GetJson..'"Welcomes":"'..Welcomes..'"}'
end
GetJson = GetJson..'}}'
local File = io.open('./'..storm..'.json', "w")
File:write(GetJson)
File:close()
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './'..storm..'.json', 'โ๏ธูุญุชูู ุงูููู ุนูู โคฝ '..#List..' ูุฌููุนู',dl_cb, nil)
io.popen('rm -rf ./'..storm..'.json')
end
if text and (text == 'ุฑูุน ุงููุณุฎู' or text == 'ุฑูุน ุงููุณุฎู ุงูุงุญุชูุงุทูู' or text == 'ุฑูุน ูุณุฎู ุงูุงุญุชูุงุทูู') and tonumber(msg.reply_to_message_id_) > 0 then   
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
--     Source Storm     --
if DevRio:get(storm.."SET:GAME"..msg.chat_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 6 then
Dev_Rio( msg.chat_id_, msg.id_, 1,"โ๏ธููุฌุฏ ููุท ( 6 ) ุงุฎุชูุงุฑุงุช\nโ๏ธุงุฑุณู ุงุฎุชูุงุฑู ูุฑู ุงุฎุฑู", 1, "md")    
return false  end 
local GETNUM = DevRio:get(storm.."GAMES"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
DevRio:del(storm.."SET:GAME"..msg.chat_id_)   
Dev_Rio( msg.chat_id_, msg.id_, 1,'โ๏ธ*ุงููุญูุจุณ ุจุงููุฏ ุฑูู* โคฝ '..NUM..'\nโ๏ธ*ูุจุฑูู ููุฏ ุฑุจุญุช ูุญุตูุช ุนูู 5 ููุงุท ููููู ุงุณุชุจุฏุงููุง ุจุงูุฑุณุงุฆู*', 1, "md") 
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_,5)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
DevRio:del(storm.."SET:GAME"..msg.chat_id_)   
Dev_Rio( msg.chat_id_, msg.id_, 1,'โ๏ธ*ุงููุญูุจุณ ุจุงููุฏ ุฑูู* โคฝ '..GETNUM..'\nโ๏ธ*ููุงุณู ููุฏ ุฎุณุฑุช ุญุงูู ูุฑู ุงุฎุฑู ููุนุซูุฑ ุนูู ุงููุญูุจุณ*', 1, "md")
end
end
end
if DevRio:get(storm..'DevRio4'..msg.sender_user_id_) then
if text and text:match("^ุงูุบุงุก$") then 
send(msg.chat_id_, msg.id_, "โ๏ธุชู ุงูุบุงุก ุงูุงูุฑ")
DevRio:del(storm..'DevRio4'..msg.sender_user_id_)
return false  end 
DevRio:del(storm..'DevRio4'..msg.sender_user_id_)
local username = string.match(text, "@[%a%d_]+") 
tdcli_function({ID = "SearchPublicChat",username_ = username},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, 'โ๏ธุงููุนุฑู ูุง ููุฌุฏ ููู ููุงุฉ')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, 'โ๏ธุนุฐุฑุง ูุง ููููู ูุถุน ูุนุฑู ุญุณุงุจุงุช ูู ุงูุงุดุชุฑุงู')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_, 'โ๏ธุนุฐุฑุง ูุง ููููู ูุถุน ูุนุฑู ูุฌููุนู ูู ุงูุงุดุชุฑุงู')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'โ๏ธุงูุจูุช ุงุฏูู ูู ุงูููุงุฉ \nโ๏ธุชู ุชูุนูู ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู \nโ๏ธุงูุฏู ุงูููุงุฉ โคฝ '..data.id_..'\nโ๏ธูุนุฑู ุงูููุงุฉ โคฝ [@'..data.type_.channel_.username_..']')
DevRio:set(storm..'Rio:ChId',data.id_)
else
send(msg.chat_id_, msg.id_,'โ๏ธุนุฐุฑุง ุงูุจูุช ููุณ ุงุฏูู ูู ุงูููุงุฉ')
end
return false  
end
end,nil)
end
--     Source Storm     --
if DevRio:get(storm.."Rio:DevText"..msg.chat_id_..":" .. msg.sender_user_id_) then
if text and text:match("^ุงูุบุงุก$") then 
DevRio:del(storm.."Rio:DevText"..msg.chat_id_..":" .. msg.sender_user_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุงูุฑ', 1, 'md')
return false 
end 
DevRio:del(storm.."Rio:DevText"..msg.chat_id_..":" .. msg.sender_user_id_)
local DevText = msg.content_.text_:match("(.*)")
DevRio:set(storm.."DevText", DevText)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ูููุดุฉ ุงููุทูุฑ", 1, "md")
end
if DevRio:get(storm..'Rio:NameBot'..msg.sender_user_id_) == 'msg' then
if text and text:match("^ุงูุบุงุก$") then 
DevRio:del(storm..'Rio:NameBot'..msg.sender_user_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุงูุฑ', 1, 'md')
return false 
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญูุธ ุงุณู ุงูุจูุช ', 1, 'html')
DevRio:del(storm..'Rio:NameBot'..msg.sender_user_id_)
DevRio:set(storm..'Rio:NameBot', text)
return false 
end
--     Source Storm     --
if text == "ุงูุฑุงุจุท" then
if not DevRio:get(storm..'Rio:Lock:GpLinks'..msg.chat_id_) then 
if DevRio:get(storm.."Rio:Groups:Links"..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธGroup Link โฌ โค \nโ โ โ โ โ โ โ โ โ\n"..DevRio:get(storm.."Rio:Groups:Links"..msg.chat_id_), 1, "html")
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุงููุฌุฏ ุฑุงุจุท ุงุฑุณู โคฝ ุถุน ุฑุงุจุท ุงู ุงุฑุณู โคฝ ุงูุดุงุก ุฑุงุจุท ููุงูุดุงุก', 1, 'md')
end
else
end
end
--     Source Storm     --
if text == "ุงูุฑุงุจุท" then
if not DevRio:get(storm.."Rio:Lock:GpLinksinline"..msg.chat_id_) then 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_)) or DevRio:get(storm.."Private:Group:Link"..msg.chat_id_) 
if linkgpp.ok == true then 
local Text = 'โ๏ธ๐ซ๐๐๐ ๐ฆ๐๐๐๐ โฌ โค\nโ โ โ โ โ โ โ โ โ\n['..ta.title_..']('..linkgpp.result..')'
local inline = {{{text = ta.title_, url=linkgpp.result}},
} 
SendInline(msg.chat_id_,Text,nil,inline,msg.id_/2097152/0.5) 
else 
end 
end,nil) 
end
end
--     Source Storm     --
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
DevRio:incr(storm..'Rio:UsersMsgs'..storm..os.date('%d')..':'..msg.chat_id_..':'..msg.sender_user_id_)
DevRio:incr(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
DevRio:incr(storm..'Rio:MsgNumberDay'..msg.chat_id_..':'..os.date('%d'))  
ChatType = 'sp' 
elseif id:match("^(%d+)") then
if not DevRio:sismember(storm.."Rio:Users",msg.chat_id_) then
DevRio:sadd(storm.."Rio:Users",msg.chat_id_)
end
ChatType = 'pv' 
else
ChatType = 'gp' 
end
end 
--     Source Storm     --
if ChatType == 'sp' or ChatType == 'gp' or ChatType == 'pv' then
if text == 'ุจูุช' or text == 'ุจูุชุช' then 
NameBot = (DevRio:get(storm..'Rio:NameBot') or 'ุณุชูุฑู')
local stormTeam = {' ููู ูุณุทุง ุงูุง'..NameBot..' ',' ุงุณูู '..NameBot..' ',' . ููุชุง ุดุงูู ุงุณูู'..NameBot..' '}
DevRio2 = math.random(#stormTeam) 
Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam[DevRio2] , 1, 'html') 
return false
end

if text == 'ุงุณู ุงูุจูุช' or text == 'ุงูุจูุช ุดูู ุงุณูู' or text == 'ุดุณูู ุงูุจูุช' or text == 'ุงูุจูุช ุดุณูู' then
NameBot = (DevRio:get(storm..'Rio:NameBot') or 'ุณุชูุฑู') 
local stormTeam = {"ููุชุง ุดุงูู ุงุณูู"..NameBot.." "} 
DevRio2 = math.random(#stormTeam) 
Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam[DevRio2] , 1, 'html') 
return false
end
if text and text == (DevRio:get(storm..'Rio:NameBot') or 'ุณุชูุฑู') then 
NameBot = (DevRio:get(storm..'Rio:NameBot') or 'ุณุชูุฑู')
local namebot = {'ููู ูุณุทุง ุงูุง'..NameBot..' ',' ุงุณูู '..NameBot..' '} 
name = math.random(#namebot) 
Dev_Rio(msg.chat_id_, msg.id_, 1, namebot[name] , 1, 'html') 
return false 
end
if text =='ููุงุทู' and ChCheck(msg) then 
if tonumber((DevRio:get(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_) or 0)) == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูู ุชุฑุจุญ ุงู ููุทู\nโ๏ธุงุฑุณู โคฝ ุงูุงูุนุงุจ ููุนุจ', 1, 'md')
else 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุนุฏุฏ ุงูููุงุท ุงูุชู ุฑุจุญุชูุง โคฝ '..(DevRio:get(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_)), 1, 'md')
end
end
if text ==  'ุญุฐู ุฑุณุงุฆูู' and ChCheck(msg) or text ==  'ูุณุญ ุฑุณุงุฆูู' and ChCheck(msg) then DevRio:del(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_) Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญุฐู ุฌููุน ุฑุณุงุฆูู', 1, 'md') end
if text ==  'ุญุฐู ููุงุทู' and ChCheck(msg) or text ==  'ูุณุญ ููุงุทู' and ChCheck(msg) then DevRio:del(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_) Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญุฐู ุฌููุน ููุงุทู', 1, 'md') end
--     Source Storm     --
if text == 'ุณูุงููุงุช' and ChCheck(msg) or text == 'ุงูุณูุงููุงุช' and ChCheck(msg) or text == 'โคฝ ุณูุงููุงุช โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'๐','๐','๐','๐','๐','๐','๐','๐','๐','๐','๐','๐','๐','๐ฅฅ','๐ฅ','๐','๐','๐ฅ','๐ฅฆ','๐ฅ','๐ถ','๐ฝ','๐ฅ','๐ฅ','๐ ','๐ฅ','๐','๐ฅ','๐ฅจ','๐ง','๐ฅ','๐ณ','๐ฅ','๐ฅ','๐ฅฉ','๐','๐','๐ญ','๐','๐','๐','๐ฅช','๐ฅ','๐ผ','โ๏ธ','๐ต','๐ฅค','๐ถ','๐บ','๐ป','๐','โฝ๏ธ','๐','โพ๏ธ','๐พ','๐','๐','๐ฑ','๐','๐ธ','๐ฅ','๐ฐ','๐ฎ','๐ณ','๐ฏ','๐','๐ป','๐ธ','๐บ','๐ฅ','๐น','๐ผ','๐ง','๐ค','๐ฌ','๐จ','๐ญ','๐ช','๐','๐ค','๐','๐ต','๐','๐','๐ฅ','๐ท','๐','๐','๐','๐','๐','๐','๐','๐','๐','๐','๐','๐ฎ๐ถ','โ๏ธ','๐ก','๐ฎ','๐ก','๐ฃ','โฑ','๐ข','๐','๐','๐','๐','๐ช','๐ซ','๐ฌ','๐ญ','โฐ','๐บ','๐','โ๏ธ','๐ก'}
name = DevRio2[math.random(#DevRio2)]
DevRio:set(storm..'Rio:GameNum'..msg.chat_id_,name)
DevRio:del(storm..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐ฅจ','๐ฅจ')
name = string.gsub(name,'๐ง','๐ง')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐ณ','๐ณ')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐ฅฉ','๐ฅฉ')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ญ','๐ญ')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ฅช','๐ฅช')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐ผ','๐ผ')
name = string.gsub(name,'โ๏ธ','โ๏ธ')
name = string.gsub(name,'๐ต','๐ต')
name = string.gsub(name,'๐ฅค','๐ฅค')
name = string.gsub(name,'๐ถ','๐ถ')
name = string.gsub(name,'๐บ','๐บ')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ฅฅ','๐ฅฅ')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐ฅฆ','๐ฅฆ')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐ถ','๐ถ')
name = string.gsub(name,'๐ฝ','๐ฝ')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐ ','๐ ')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐ป','๐ป')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'โฝ๏ธ','โฝ๏ธ')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'โพ๏ธ','โพ๏ธ')
name = string.gsub(name,'๐พ','๐พ')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ฑ','๐ฑ')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ธ','๐ธ')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐ฐ','๐ฐ')
name = string.gsub(name,'๐ฎ','๐ฎ')
name = string.gsub(name,'๐ณ','๐ณ')
name = string.gsub(name,'๐ฏ','๐ฏ')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ป','๐ป')
name = string.gsub(name,'๐ธ','๐ธ')
name = string.gsub(name,'๐บ','๐บ')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐น','๐น')
name = string.gsub(name,'๐ผ','๐ผ')
name = string.gsub(name,'๐ง','๐ง')
name = string.gsub(name,'๐ค','๐ค')
name = string.gsub(name,'๐ฌ','๐ฌ')
name = string.gsub(name,'๐จ','๐จ')
name = string.gsub(name,'๐ญ','๐ญ')
name = string.gsub(name,'๐ช','๐ช')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ค','๐ค')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ต','๐ต')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ฅ','๐ฅ')
name = string.gsub(name,'๐ท','๐ท')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ฎ๐ถ','๐ฎ๐ถ')
name = string.gsub(name,'โ๏ธ','โ๏ธ')
name = string.gsub(name,'๐ก','๐ก')
name = string.gsub(name,'๐ฎ','๐ฎ')
name = string.gsub(name,'๐ก','๐ก')
name = string.gsub(name,'๐ฃ','๐ฃ')
name = string.gsub(name,'โฑ','โฑ')
name = string.gsub(name,'๐ข','๐ข')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'๐ช','๐ช')
name = string.gsub(name,'๐ซ','๐ซ')
name = string.gsub(name,'๐ฌ','๐ฌ')
name = string.gsub(name,'๐ญ','๐ญ')
name = string.gsub(name,'โฐ','โฐ')
name = string.gsub(name,'๐บ','๐บ')
name = string.gsub(name,'๐','๐')
name = string.gsub(name,'โ๏ธ','โ๏ธ')
stormTeam = 'โ๏ธุงูู ูุงุญุฏ ูุฏุฒ ูุฐุง ุงูุณูุงูู ูุฑุจุญ โคฝ '..name
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
return false
end end
if text == DevRio:get(storm..'Rio:GameNum'..msg.chat_id_) and not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then
if not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then 
stormTeam = 'โ๏ธูุจุฑูู ููุฏ ุฑุจุญุช ูู ุงููุนุจู \nโ๏ธุงุฑุณู โคฝ ุณูุงููุงุช ููุนุจ ูุฑู ุงุฎุฑู'
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevRio:set(storm..'Rio:Games:Ids'..msg.chat_id_,true)
end
if text == 'ุชุฑุชูุจ' and ChCheck(msg) or text == 'ุงูุชุฑุชูุจ' and ChCheck(msg) or text == 'โคฝ ุชุฑุชูุจ โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'ุณุญูุฑ','ุณูุงุฑู','ุงุณุชูุจุงู','ูููู','ุงูููู','ุจุฒููู','ูุทุจุฎ','ูุฑุณุชูุงูู','ุฏุฌุงุฌู','ูุฏุฑุณู','ุงููุงู','ุบุฑูู','ุซูุงุฌู','ูููู','ุณูููู','ุงูุนุฑุงู','ูุญุทู','ุทูุงุฑู','ุฑุงุฏุงุฑ','ููุฒู','ูุณุชุดูู','ููุฑุจุงุก','ุชูุงุญู','ุงุฎุทุจูุท','ุณูููู','ูุฑูุณุง','ุจุฑุชูุงูู','ุชูุงุญ','ูุทุฑูู','ุจุชูุชู','ููุงูู','ุดุจุงู','ุจุงุต','ุณููู','ุฐุจุงุจ','ุชููุงุฒ','ุญุงุณูุจ','ุงูุชุฑููุช','ุณุงุญู','ุฌุณุฑ'};
name = DevRio2[math.random(#DevRio2)]
DevRio:set(storm..'Rio:GameNum'..msg.chat_id_,name)
DevRio:del(storm..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'ุณุญูุฑ','ุณ ุฑ ู ุญ')
name = string.gsub(name,'ุณูุงุฑู','ู ุฑ ุณ ู ุง')
name = string.gsub(name,'ุงุณุชูุจุงู','ู ุจ ุง ุช ู ุณ ุง')
name = string.gsub(name,'ูููู','ู ู ู ู')
name = string.gsub(name,'ุงูููู','ู ู ู ุง')
name = string.gsub(name,'ุจุฒููู','ุฒ ู ู ู')
name = string.gsub(name,'ูุทุจุฎ','ุฎ ุจ ุท ู')
name = string.gsub(name,'ูุฑุณุชูุงูู','ุณ ุช ุง ู ู ู ุฑ ู')
name = string.gsub(name,'ุฏุฌุงุฌู','ุฌ ุฌ ุง ุฏ ู')
name = string.gsub(name,'ูุฏุฑุณู','ู ู ุฏ ุฑ ุณ')
name = string.gsub(name,'ุงููุงู','ู ุง ู ุง ู')
name = string.gsub(name,'ุบุฑูู','ุบ ู ุฑ ู')
name = string.gsub(name,'ุซูุงุฌู','ุฌ ู ุช ู ุง')
name = string.gsub(name,'ูููู','ู ู ู ู')
name = string.gsub(name,'ุณูููู','ู ู ู ู ุณ')
name = string.gsub(name,'ุงูุนุฑุงู','ู ุน ุง ู ุฑ ุง')
name = string.gsub(name,'ูุญุทู','ู ุท ู ุญ')
name = string.gsub(name,'ุทูุงุฑู','ุฑ ุง ุท ู ู')
name = string.gsub(name,'ุฑุงุฏุงุฑ','ุฑ ุง ุฑ ุง ุฏ')
name = string.gsub(name,'ููุฒู','ู ุฒ ู ู')
name = string.gsub(name,'ูุณุชุดูู','ู ุด ุณ ู ุช ู')
name = string.gsub(name,'ููุฑุจุงุก','ุฑ ุจ ู ู ุง ุก')
name = string.gsub(name,'ุชูุงุญู','ุญ ู ุง ุช ู')
name = string.gsub(name,'ุงุฎุทุจูุท','ุท ุจ ู ุง ุฎ ุท')
name = string.gsub(name,'ุณูููู','ู ู ู ู ุณ')
name = string.gsub(name,'ูุฑูุณุง','ู ู ุฑ ุณ ุง')
name = string.gsub(name,'ุจุฑุชูุงูู','ุฑ ุช ู ุจ ุง ู ู')
name = string.gsub(name,'ุชูุงุญ','ุญ ู ุง ุช')
name = string.gsub(name,'ูุทุฑูู','ู ุท ู ุฑ ู')
name = string.gsub(name,'ุจุชูุชู','ุจ ุช ุช ู ู')
name = string.gsub(name,'ููุงูู','ู ู ู ู ู')
name = string.gsub(name,'ุดุจุงู','ุจ ุด ุง ู')
name = string.gsub(name,'ุจุงุต','ุต ุง ุจ')
name = string.gsub(name,'ุณููู','ู ุณ ู ู')
name = string.gsub(name,'ุฐุจุงุจ','ุจ ุง ุจ ุฐ')
name = string.gsub(name,'ุชููุงุฒ','ุช ู ู ุฒ ุง')
name = string.gsub(name,'ุญุงุณูุจ','ุณ ุง ุญ ู ุจ')
name = string.gsub(name,'ุงูุชุฑููุช','ุง ุช ู ุฑ ู ู ุช')
name = string.gsub(name,'ุณุงุญู','ุญ ุง ู ุณ')
name = string.gsub(name,'ุฌุณุฑ','ุฑ ุฌ ุณ')
stormTeam = 'โ๏ธุงูู ูุงุญุฏ ูุฑุชุจูุง ูุฑุจุญ โคฝ '..name
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
return false
end end
if text == DevRio:get(storm..'Rio:GameNum'..msg.chat_id_) and not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then
if not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then 
stormTeam = 'โ๏ธูุจุฑูู ููุฏ ุฑุจุญุช ูู ุงููุนุจู \nโ๏ธุงุฑุณู โคฝ ุชุฑุชูุจ ููุนุจ ูุฑู ุงุฎุฑู'
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevRio:set(storm..'Rio:Games:Ids'..msg.chat_id_,true)
end
if text == 'ูุญูุจุณ' and ChCheck(msg) or text == 'ุจุงุช' and ChCheck(msg) or text == 'ุงููุญูุจุณ' and ChCheck(msg) or text == 'โคฝ ูุญูุจุณ โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
Num = math.random(1,6)
DevRio:set(storm.."GAMES"..msg.chat_id_,Num) 
TEST = [[
โ     โ     โ     โ     โ     โ
โ     โ     โ     โ     โ     โ
๐ โนโบ ๐๐ป โนโบ ๐๐ผ โนโบ ๐๐ฝ โนโบ ๐๐พ โนโบ ๐๐ฟ
โ๏ธุงุฎุชุฑ ุฑูู ูุงุณุชุฎุฑุงุฌ ุงููุญูุจุณ
โ๏ธุงููุงุฆุฒ ูุญุตู ุนูู (5) ููุงุท
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, TEST, 1, "md") 
DevRio:setex(storm.."SET:GAME"..msg.chat_id_, 100, true)  
return false  
end end
if text == 'ุญุฒูุฑู' and ChCheck(msg) or text == 'ุงูุญุฒูุฑู' and ChCheck(msg) or text == 'โคฝ ุญุฒูุฑู โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'ุงูุฌุฑุณ','ุนูุฑุจ ุงูุณุงุนู','ุงูุณูู','ุงููุทุฑ','5','ุงููุชุงุจ','ุงูุจุณูุงุฑ','7','ุงููุนุจู','ุจูุช ุงูุดุนุฑ','ููุงูู','ุงูุง','ุงูู','ุงูุงุจุฑู','ุงูุณุงุนู','22','ุบูุท','ูู ุงูุณุงุนู','ุงูุจูุชูุฌุงู','ุงูุจูุถ','ุงููุฑุงูู','ุงูุถูุก','ุงูููุงุก','ุงูุถู','ุงูุนูุฑ','ุงูููู','ุงููุดุท','ุงูุญูุฑู','ุงูุจุญุฑ','ุงูุซูุฌ','ุงูุงุณููุฌ','ุงูุตูุช','ุจูู'};
name = DevRio2[math.random(#DevRio2)]
DevRio:set(storm..'Rio:GameNum'..msg.chat_id_,name)
DevRio:del(storm..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'ุงูุฌุฑุณ','ุดูุฆ ุงุฐุง ููุณุชู ุตุฑุฎ ูุง ููู ุ')
name = string.gsub(name,'ุนูุฑุจ ุงูุณุงุนู','ุงุฎูุงู ูุง ูุณุชุทูุนุงู ุชูุถูู ุงูุซุฑ ูู ุฏูููู ูุนุง ููุง ููุง ุ')
name = string.gsub(name,'ุงูุณูู','ูุง ูู ุงูุญููุงู ุงูุฐู ูู ูุตุนุฏ ุงูู ุณูููุฉ ููุญ ุนููู ุงูุณูุงู ุ')
name = string.gsub(name,'ุงููุทุฑ','ุดูุฆ ูุณูุท ุนูู ุฑุฃุณู ูู ุงูุงุนูู ููุง ูุฌุฑุญู ููุง ูู ุ')
name = string.gsub(name,'5','ูุง ุงูุนุฏุฏ ุงูุฐู ุงุฐุง ุถุฑุจุชู ุจููุณู ูุงุถูุช ุนููู 5 ูุตุจุญ ุซูุงุซูู ')
name = string.gsub(name,'ุงููุชุงุจ','ูุง ุงูุดูุฆ ุงูุฐู ูู ุงูุฑุงู ูููุณ ูู ุฌุฐูุฑ ุ')
name = string.gsub(name,'ุงูุจุณูุงุฑ','ูุง ูู ุงูุดูุฆ ุงูุฐู ูุง ููุดู ุงูุง ุจุงูุถุฑุจ ุ')
name = string.gsub(name,'7','ุนุงุฆูู ูุคููู ูู 6 ุจูุงุช ูุงุฎ ููู ูููู .ููู ุนุฏุฏ ุงูุฑุงุฏ ุงูุนุงุฆูู ')
name = string.gsub(name,'ุงููุนุจู','ูุง ูู ุงูุดูุฆ ุงูููุฌูุฏ ูุณุท ููุฉ ุ')
name = string.gsub(name,'ุจูุช ุงูุดุนุฑ','ูุง ูู ุงูุจูุช ุงูุฐู ููุณ ููู ุงุจูุงุจ ููุง ููุงูุฐ ุ ')
name = string.gsub(name,'ููุงูู','ูุญุฏู ุญููู ููุบุฑูุฑู ุชูุจุณ ููุฉ ุชููุฑู .ูู ููู ุ ')
name = string.gsub(name,'ุงูุง','ุงุจู ุงูู ูุงุจู ุงุจูู ูููุณ ุจุงุฎุชู ููุง ุจุงุฎูู ููู ูููู ุ')
name = string.gsub(name,'ุงูู','ุงุฎุช ุฎุงูู ูููุณุช ุฎุงูุชู ูู ุชููู ุ ')
name = string.gsub(name,'ุงูุงุจุฑู','ูุง ูู ุงูุดูุฆ ุงูุฐู ูููุง ุฎุทุง ุฎุทูู ููุฏ ุดูุฆุง ูู ุฐููู ุ ')
name = string.gsub(name,'ุงูุณุงุนู','ูุง ูู ุงูุดูุฆ ุงูุฐู ูููู ุงูุตุฏู ููููู ุงุฐุง ุฌุงุน ูุฐุจ ุ')
name = string.gsub(name,'22','ูู ูุฑู ููุทุจู ุนูุฑุจุง ุงูุณุงุนู ุนูู ุจุนุถููุง ูู ุงูููู ุงููุงุญุฏ ')
name = string.gsub(name,'ุบูุท','ูุง ูู ุงููููู ุงููุญูุฏู ุงูุชู ุชููุถ ุบูุท ุฏุงุฆูุง ุ ')
name = string.gsub(name,'ูู ุงูุณุงุนู','ูุง ูู ุงูุณุคุงู ุงูุฐู ุชุฎุชูู ุงุฌุงุจุชู ุฏุงุฆูุง ุ')
name = string.gsub(name,'ุงูุจูุชูุฌุงู','ุฌุณู ุงุณูุฏ ูููุจ ุงุจูุถ ูุฑุงุณ ุงุฎุธุฑ ููุง ูู ุ')
name = string.gsub(name,'ุงูุจูุถ','ูุงูู ุงูุดูุฆ ุงูุฐู ุงุณูู ุนูู ูููู ุ')
name = string.gsub(name,'ุงููุฑุงูู','ุงุฑู ูู ุดูุฆ ูู ุฏูู ุนููู ูู ุงููู ุ ')
name = string.gsub(name,'ุงูุถูุก','ูุง ูู ุงูุดูุฆ ุงูุฐู ูุฎุชุฑู ุงูุฒุฌุงุฌ ููุง ููุณุฑู ุ')
name = string.gsub(name,'ุงูููุงุก','ูุง ูู ุงูุดูุฆ ุงูุฐู ูุณูุฑ ุงูุงูู ููุง ุชุฑุงู ุ')
name = string.gsub(name,'ุงูุถู','ูุง ูู ุงูุดูุฆ ุงูุฐู ููุงุญูู ุงูููุง ุชุฐูุจ ุ ')
name = string.gsub(name,'ุงูุนูุฑ','ูุง ูู ุงูุดูุก ุงูุฐู ูููุง ุทุงู ูุตุฑ ุ ')
name = string.gsub(name,'ุงูููู','ูุง ูู ุงูุดูุฆ ุงูุฐู ููุชุจ ููุง ููุฑุฃ ุ')
name = string.gsub(name,'ุงููุดุท','ูู ุฃุณูุงู ููุง ูุนุถ ูุง ูู ุ ')
name = string.gsub(name,'ุงูุญูุฑู','ูุง ูู ุงูุดูุฆ ุงุฐุง ุฃุฎุฐูุง ููู ุงุฒุฏุงุฏ ููุจุฑ ุ')
name = string.gsub(name,'ุงูุจุญุฑ','ูุง ูู ุงูุดูุฆ ุงูุฐู ูุฑูุน ุงุซูุงู ููุง ููุฏุฑ ูุฑูุน ูุณูุงุฑ ุ')
name = string.gsub(name,'ุงูุซูุฌ','ุงูุง ุงุจู ุงููุงุก ูุงู ุชุฑูููู ูู ุงููุงุก ูุช ููู ุงูุง ุ')
name = string.gsub(name,'ุงูุงุณููุฌ','ููู ุซููุจ ููุน ุฐุงูู ุงุญูุถ ุงููุงุก ููู ุงููู ุ')
name = string.gsub(name,'ุงูุตูุช','ุงุณูุฑ ุจูุง ุฑุฌููู ููุง ุงุฏุฎู ุงูุง ุจุงูุงุฐููู ููู ุงูุง ุ')
name = string.gsub(name,'ุจูู','ุญุงูู ููุญููู ูุตู ูุงุดู ููุตู ูุจููู ููู ุงููู ุ ')
stormTeam = 'โ๏ธุงูู ูุงุญุฏ ูุญููุง ูุฑุจุญ โคฝ '..name
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
return false
end end
if text == DevRio:get(storm..'Rio:GameNum'..msg.chat_id_) and not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then
if not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then 
stormTeam = 'โ๏ธูุจุฑูู ููุฏ ุฑุจุญุช ูู ุงููุนุจู \nโ๏ธุงุฑุณู โคฝ ุญุฒูุฑู ููุนุจ ูุฑู ุงุฎุฑู'
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevRio:set(storm..'Rio:Games:Ids'..msg.chat_id_,true)
end 
if text == 'ุงููุนุงูู' and ChCheck(msg) or text == 'ูุนุงูู' and ChCheck(msg) or text == 'โคฝ ูุนุงูู โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'ูุฑุฏ','ุฏุฌุงุฌู','ุจุทุฑูู','ุถูุฏุน','ุจููู','ูุญูู','ุฏูู','ุฌูู','ุจูุฑู','ุฏููููู','ุชูุณุงุญ','ูุฑุด','ููุฑ','ุงุฎุทุจูุท','ุณููู','ุฎูุงุด','ุงุณุฏ','ูุฃุฑ','ุฐุฆุจ','ูุฑุงุดู','ุนูุฑุจ','ุฒุฑุงูู','ูููุฐ','ุชูุงุญู','ุจุงุฐูุฌุงู'}
name = DevRio2[math.random(#DevRio2)]
DevRio:set(storm..'Rio:GameNum2'..msg.chat_id_,name)
DevRio:del(storm..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'ูุฑุฏ','๐')
name = string.gsub(name,'ุฏุฌุงุฌู','๐')
name = string.gsub(name,'ุจุทุฑูู','๐ง')
name = string.gsub(name,'ุถูุฏุน','๐ธ')
name = string.gsub(name,'ุจููู','๐ฆ')
name = string.gsub(name,'ูุญูู','๐')
name = string.gsub(name,'ุฏูู','๐')
name = string.gsub(name,'ุฌูู','๐ซ')
name = string.gsub(name,'ุจูุฑู','๐')
name = string.gsub(name,'ุฏููููู','๐ฌ')
name = string.gsub(name,'ุชูุณุงุญ','๐')
name = string.gsub(name,'ูุฑุด','๐ฆ')
name = string.gsub(name,'ููุฑ','๐')
name = string.gsub(name,'ุงุฎุทุจูุท','๐')
name = string.gsub(name,'ุณููู','๐')
name = string.gsub(name,'ุฎูุงุด','๐ฆ')
name = string.gsub(name,'ุงุณุฏ','๐ฆ')
name = string.gsub(name,'ูุฃุฑ','๐ญ')
name = string.gsub(name,'ุฐุฆุจ','๐บ')
name = string.gsub(name,'ูุฑุงุดู','๐ฆ')
name = string.gsub(name,'ุนูุฑุจ','๐ฆ')
name = string.gsub(name,'ุฒุฑุงูู','๐ฆ')
name = string.gsub(name,'ูููุฐ','๐ฆ')
name = string.gsub(name,'ุชูุงุญู','๐')
name = string.gsub(name,'ุจุงุฐูุฌุงู','๐')
stormTeam = 'โ๏ธูุง ูุนูู ูุฐุง ุงูุณูุงูู :ุ โคฝ '..name
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
return false
end end
if text == DevRio:get(storm..'Rio:GameNum2'..msg.chat_id_) and not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then
if not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then 
stormTeam = 'โ๏ธูุจุฑูู ููุฏ ุฑุจุญุช ูู ุงููุนุจู \nโ๏ธุงุฑุณู โคฝ ุงููุนุงูู ููุนุจ ูุฑู ุงุฎุฑู'
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevRio:set(storm..'Rio:Games:Ids'..msg.chat_id_,true)
end 
if text == 'ุงูุนูุณ' and ChCheck(msg) or text == 'ุนูุณ' and ChCheck(msg) or text == 'โคฝ ุงูุนูุณ โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'ุจุงู','ูููุช','ููุฒูู','ุงุณูุนู','ุงุญุจู','ููุญูู','ูุถูู','ุญุงุฑู','ูุงุตู','ุฌูู','ุณุฑูุน','ููุณู','ุทููู','ุณููู','ุถุนูู','ุดุฑูู','ุดุฌุงุน','ุฑุญุช','ุนุฏู','ูุดูุท','ุดุจุนุงู','ููุนุทุดุงู','ุฎูุด ููุฏ','ุงูู','ูุงุฏุฆ'}
name = DevRio2[math.random(#DevRio2)]
DevRio:set(storm..'Rio:GameNum3'..msg.chat_id_,name)
DevRio:del(storm..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'ุจุงู','ููู')
name = string.gsub(name,'ูููุช','ูุงูููุช')
name = string.gsub(name,'ููุฒูู','ุฒูู')
name = string.gsub(name,'ุงุณูุนู','ูุงุณูุนู')
name = string.gsub(name,'ุงุญุจู','ูุงุญุจู')
name = string.gsub(name,'ูุญูู','ุญูู')
name = string.gsub(name,'ูุถูู','ูุตุฎ')
name = string.gsub(name,'ุญุงุฑู','ุจุงุฑุฏู')
name = string.gsub(name,'ูุงุตู','ุนุงูู')
name = string.gsub(name,'ุฌูู','ููู')
name = string.gsub(name,'ุณุฑูุน','ุจุทูุก')
name = string.gsub(name,'ููุณู','ุถูุฌู')
name = string.gsub(name,'ุทููู','ูุฒู')
name = string.gsub(name,'ุณููู','ุถุนูู')
name = string.gsub(name,'ุถุนูู','ููู')
name = string.gsub(name,'ุดุฑูู','ููุงุฏ')
name = string.gsub(name,'ุดุฌุงุน','ุฌุจุงู')
name = string.gsub(name,'ุฑุญุช','ุงุฌูุช')
name = string.gsub(name,'ุญู','ููุช')
name = string.gsub(name,'ูุดูุท','ูุณูู')
name = string.gsub(name,'ุดุจุนุงู','ุฌูุนุงู')
name = string.gsub(name,'ููุนุทุดุงู','ุนุทุดุงู')
name = string.gsub(name,'ุฎูุด ููุฏ','ููุฎูุด ููุฏ')
name = string.gsub(name,'ุงูู','ูุทู')
name = string.gsub(name,'ูุงุฏุฆ','ุนุตุจู')
stormTeam = 'โ๏ธูุง ูู ุนูุณ ูููุฉ โคฝ '..name
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
return false
end end
if text == DevRio:get(storm..'Rio:GameNum3'..msg.chat_id_) and not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then
if not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then 
stormTeam = 'โ๏ธูุจุฑูู ููุฏ ุฑุจุญุช ูู ุงููุนุจู \nโ๏ธุงุฑุณู โคฝ ุงูุนูุณ ููุนุจ ูุฑู ุงุฎุฑู'
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevRio:set(storm..'Rio:Games:Ids'..msg.chat_id_,true)
end 
if text == 'ุงููุฎุชูู' and ChCheck(msg) or text == 'ูุฎุชูู' and ChCheck(msg) or text == 'โคฝ ุงููุฎุชูู โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'๐ธ','โ ','๐ผ','๐','๐','๐','โญ๏ธ','๐ฅ','โ','๐ฅ','โ๏ธ','๐จโ๐ฌ','๐จโ๐ป','๐จโ๐ง','๐ฉโ๐ณ','๐งโโ','๐งโโ๏ธ','๐งโโ','๐โโ','๐งโโ','๐ฌ','๐จโ๐จโ๐ง','๐','๐ค','โ๏ธ','๐','๐ฉโโ๏ธ','๐จโ๐จ'};
name = DevRio2[math.random(#DevRio2)]
DevRio:set(storm..'Rio:GameNum4'..msg.chat_id_,name)
DevRio:del(storm..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'๐ธ','๐น๐น๐น๐ธ๐น๐น๐น๐น')
name = string.gsub(name,'โ ๏ธ','๐๐๐โ ๏ธ๐๐๐๐')
name = string.gsub(name,'๐ผ','๐ป๐ป๐ป๐ป๐ป๐ป๐ป๐ผ')
name = string.gsub(name,'๐','๐๐๐๐๐๐๐๐')
name = string.gsub(name,'๐','๐๐๐๐๐๐๐๐')
name = string.gsub(name,'๐','๐๐๐๐๐๐๐๐')
name = string.gsub(name,'โญ๏ธ','๐๐๐๐๐๐โญ๏ธ๐')
name = string.gsub(name,'๐ฅ','๐ซ๐ซ๐ซ๐ฅ๐ซ๐ซ๐ซ๐ซ')
name = string.gsub(name,'โ','๐จ๐จ๐จโ๐จ๐จ๐จ๐จ')
name = string.gsub(name,'๐ฅ','โ๏ธโ๏ธโ๏ธ๐ฅโ๏ธโ๏ธโ๏ธโ๏ธ')
name = string.gsub(name,'โ๏ธ','โ๏ธโ๏ธโ๏ธโ๏ธโ๏ธโ๏ธโ๏ธโ๏ธโ๏ธ')
name = string.gsub(name,'๐จโ๐ฌ','๐ฉโ๐ฌ๐ฉโ๐ฌ๐ฉโ๐ฌ๐ฉโ๐ฌ๐ฉโ๐ฌ๐จโ๐ฌ๐ฉโ๐ฌ๐ฉโ๐ฌ')
name = string.gsub(name,'๐จโ๐ป','๐ฉโ๐ป๐ฉโ๐ป๐จโ๐ป๐ฉโ๐ป๐ฉโ๐ป๐ฉโ๐ป๐ฉโ๐ป๐ฉโ๐ป')
name = string.gsub(name,'๐จโ๐ง','๐ฉโ๐ง๐ฉโ๐ง๐ฉโ๐ง๐ฉโ๐ง๐ฉโ๐ง๐ฉโ๐ง๐จโ๐ง๐ฉโ๐ง')
name = string.gsub(name,'๐ฉโ๐ณ','๐จโ๐ณ๐จโ๐ณ๐ฉโ๐ณ๐จโ๐ณ๐จโ๐ณ๐จโ๐ณ๐จโ๐ณ๐จโ๐ณ')
name = string.gsub(name,'๐งโโ๏ธ','๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ')
name = string.gsub(name,'๐งโโ๏ธ','๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ')
name = string.gsub(name,'๐งโโ๏ธ','๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ')
name = string.gsub(name,'๐โโ๏ธ','๐โโ๏ธ๐โโ๏ธ๐โโ๏ธ๐โโ๏ธ๐โโ๏ธ๐โโ๏ธ๐โโ๏ธ๐โโ๏ธ')
name = string.gsub(name,'๐งโโ๏ธ','๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ๐งโโ๏ธ')
name = string.gsub(name,'๐ฌ','๐ญ๐ญ๐ญ๐ญ๐ฌ๐ญ๐ญ๐ญ')
name = string.gsub(name,'๐จโ๐จโ๐ง','๐จโ๐จโ๐ฆ๐จโ๐จโ๐ฆ๐จโ๐จโ๐ฆ๐จโ๐จโ๐ฆ๐จโ๐จโ๐ฆ๐จโ๐จโ๐ง๐จโ๐จโ๐ฆ๐จโ๐จโ๐ฆ')
name = string.gsub(name,'๐','๐๐๐๐๐๐๐๐')
name = string.gsub(name,'๐ค','๐ฅ๐ฅ๐ฅ๐ฅ๐ฅ๐ค๐ฅ๐ฅ')
name = string.gsub(name,'โ๏ธ','โณโณโณโณโณโ๏ธโณโณ')
name = string.gsub(name,'๐','๐๐๐๐๐๐๐๐')
name = string.gsub(name,'๐ฉโโ๏ธ','๐จโโ๏ธ๐จโโ๏ธ๐จโโ๏ธ๐จโโ๏ธ๐จโโ๏ธ๐ฉโโ๏ธ๐จโโ๏ธ๐จโโ๏ธ')
name = string.gsub(name,'๐จโ๐จ','๐ฉโ๐จ๐ฉโ๐จ๐จโ๐จ๐ฉโ๐จ๐ฉโ๐จ๐ฉโ๐จ๐ฉโ๐จ๐ฉโ๐จ')
stormTeam = 'โ๏ธุงูู ูุงุญุฏ ูุทูุน ุงููุฎุชูู ูุฑุจุญ\n{'..name..'} '
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
return false
end end
if text == DevRio:get(storm..'Rio:GameNum4'..msg.chat_id_) and not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then
if not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then 
stormTeam = 'โ๏ธูุจุฑูู ููุฏ ุฑุจุญุช ูู ุงููุนุจู \nโ๏ธุงุฑุณู โคฝ ุงููุฎุชูู ููุนุจ ูุฑู ุงุฎุฑู'
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevRio:set(storm..'Rio:Games:Ids'..msg.chat_id_,true)
end  
if text == 'ุงูุซูู' and ChCheck(msg) or text == 'ุงูุงูุซูู' and ChCheck(msg) or text == 'โคฝ ุงูุซูู โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {
'ุฌูุฒ','ุถุฑุงุทู','ุงูุญุจู','ุงูุญุงูู','ุดูุฑู','ุจูุฏู','ุณูุงูู','ุงููุฎูู','ุงูุฎูู','ุญุฏุงุฏ','ุงููุจูู','ูุฑูุต','ูุฑุฏ','ุงูุนูุจ','ุงูุนูู','ุงูุฎุจุฒ','ุจุงูุญุตุงุฏ','ุดูุฑ','ุดูู','ููุญูู',
};
name = DevRio2[math.random(#DevRio2)]
DevRio:set(storm..'Rio:GameNum5'..msg.chat_id_,name)
DevRio:del(storm..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'ุฌูุฒ','ููุทู ___ ูููุงุนูุฏู ุณููู')
name = string.gsub(name,'ุถุฑุงุทู','ุงูู ูุณูู ุงููุทู ูุชุญูู ___ ')
name = string.gsub(name,'ุจูุฏู','ุงูู ___ ูุญุฏ ูููุฏู')
name = string.gsub(name,'ุงูุญุงูู','ุชุฌุฏู ูู ___ ูุนุงู')
name = string.gsub(name,'ุดูุฑู','ูุน ุงูุฎูู ูุง ___ ')
name = string.gsub(name,'ุงููุฎูู','ุงูุทูู ุทูู ___ ูุงูุนูู ุนูู ุงูุตุฎูุฉ')
name = string.gsub(name,'ุณูุงูู','ุจุงููุฌู ุงูุฑุงูุฉ ูุจุงูุธูุฑ ___ ')
name = string.gsub(name,'ุงูุฎูู','ูู ููุฉ ___ ุดุฏู ุนูู ุงูฺูุงุจ ุณุฑูุฌ')
name = string.gsub(name,'ุญุฏุงุฏ','ูููู ูู ุตุฎู ูุฌูู ูุงู ุขูู ___ ')
name = string.gsub(name,'ุงููุจูู',' ___ ูุง ูุฎุงู ูู ุงููุทุฑ')
name = string.gsub(name,'ุงูุญุจู','ุงููู ุชูุฏุบุฉ ุงูุญูุฉ ูุฎุงู ูู ุฌุฑุฉ ___ ')
name = string.gsub(name,'ูุฑูุต','ุงููุงูุนุฑู ___ ูููู ุงููุงุน ุนูุฌู')
name = string.gsub(name,'ุงูุนูุจ','ุงููุงูููุญ ___ ูููู ุญุงูุถ')
name = string.gsub(name,'ุงูุนูู','___ ุฅุฐุง ุญุจุช ุงูฺูุฉ ุงุจููุณ ูุฏุฎู ุงูุฌูุฉ')
name = string.gsub(name,'ุงูุฎุจุฒ','ุงูุทู ___ ููุฎุจุงุฒ ุญุชู ูู ูุงูู ูุตู')
name = string.gsub(name,'ุจุงูุญุตุงุฏ','ุงุณูุฉ ___ ูููุฌูู ููุณูุฑ')
name = string.gsub(name,'ุดูุฑ','ุงูุดู ___ ููุง ุชุนุจุฑ ููุฑ')
name = string.gsub(name,'ุดูู','ูุงูู ุชุนุจ ูุงูู ___ ูุง ูู ุนูู ุงูุญุงุถุฑ ููุฉ')
name = string.gsub(name,'ุงููุฑุฏ',' ___ ุจุนูู ุงูู ุบุฒุงู')
name = string.gsub(name,'ููุญูู','ุงุฌู ___ ุนูุงูุง')
stormTeam = 'โ๏ธุงููู ุงููุซุงู ุงูุชุงูู โคฝ ['..name..']'
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
return false
end end
if text == DevRio:get(storm..'Rio:GameNum5'..msg.chat_id_) then
if not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then 
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
DevRio:del(storm..'Rio:GameNum5'..msg.chat_id_)
stormTeam = 'โ๏ธูุจุฑูู ููุฏ ุฑุจุญุช ูู ุงููุนุจู \nโ๏ธุงุฑุณู โคฝ ุงูุซูู ููุนุจ ูุฑู ุงุฎุฑู'
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
end
DevRio:set(storm..'Rio:Games:Ids'..msg.chat_id_,true)
end  
if text == 'ุฑูุงุถูุงุช' and ChCheck(msg) or text == 'ุงูุฑูุงุถูุงุช' and ChCheck(msg) or text == 'โคฝ ุฑูุงุถูุงุช โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'9','46','2','9','5','4','25','10','17','15','39','5','16',};
name = DevRio2[math.random(#DevRio2)]
DevRio:set(storm..'Rio:GameNum6'..msg.chat_id_,name)
DevRio:del(storm..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'9','7 + 2 = ?')
name = string.gsub(name,'46','41 + 5 = ?')
name = string.gsub(name,'2','5 - 3 = ?')
name = string.gsub(name,'9','5 + 2 + 2 = ?')
name = string.gsub(name,'5','8 - 3 = ?')
name = string.gsub(name,'4','40 รท 10 = ?')
name = string.gsub(name,'25','30 - 5 = ?')
name = string.gsub(name,'10','100 รท 10 = ?')
name = string.gsub(name,'17','10 + 5 + 2 = ?')
name = string.gsub(name,'15','25 - 10 = ?')
name = string.gsub(name,'39','44 - 5 = ?')
name = string.gsub(name,'5','12 + 1 - 8 = ?')
name = string.gsub(name,'16','16 + 16 - 16 = ?')
stormTeam = 'โ๏ธุงููู ุงููุนุงุฏูู ุงูุชุงููู โคฝ โค\n{'..name..'} '
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
return false
end end
if text == DevRio:get(storm..'Rio:GameNum6'..msg.chat_id_) then
if not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then 
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
DevRio:del(storm..'Rio:GameNum6'..msg.chat_id_)
stormTeam = 'โ๏ธูุจุฑูู ููุฏ ุฑุจุญุช ูู ุงููุนุจู \nโ๏ธุงุฑุณู โคฝ ุฑูุงุถูุงุช ููุนุจ ูุฑู ุงุฎุฑู'
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
end
DevRio:set(storm..'Rio:Games:Ids'..msg.chat_id_,true)
end  
if text == 'ุงูุงููููุฒู' and ChCheck(msg) or text == 'ุงูุงูุฌููุฒูู' and ChCheck(msg) or text == 'ุงููููุฒูู' and ChCheck(msg) or text == 'โคฝ ุงููููุฒู โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'ูุนูููุงุช','ูููุงุช','ูุฌููุนุงุช','ูุชุงุจ','ุชูุงุญู','ุณุฏูู','ูููุฏ','ุงุนูู','ุฐุฆุจ','ุชูุณุงุญ','ุฐูู','ุดุงุทุฆ','ุบุจู',};
name = DevRio2[math.random(#DevRio2)]
DevRio:set(storm..'Rio:GameNum7'..msg.chat_id_,name)
DevRio:del(storm..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'ุฐุฆุจ','Wolf')
name = string.gsub(name,'ูุนูููุงุช','Information')
name = string.gsub(name,'ูููุงุช','Channels')
name = string.gsub(name,'ูุฌููุนุงุช','Groups')
name = string.gsub(name,'ูุชุงุจ','Book')
name = string.gsub(name,'ุชูุงุญู','Apple')
name = string.gsub(name,'ูููุฏ','money')
name = string.gsub(name,'ุงุนูู','I know')
name = string.gsub(name,'ุชูุณุงุญ','crocodile')
name = string.gsub(name,'ุดุงุทุฆ','Beach')
name = string.gsub(name,'ุบุจู','Stupid')
name = string.gsub(name,'ุตุฏุงูู','Friendchip')
stormTeam = 'โ๏ธูุง ูุนูู ูููุฉ โคฝ '..name
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
return false
end end
if text == DevRio:get(storm..'Rio:GameNum7'..msg.chat_id_) then
if not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then 
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
DevRio:del(storm..'Rio:GameNum7'..msg.chat_id_)
stormTeam = 'โ๏ธูุจุฑูู ููุฏ ุฑุจุญุช ูู ุงููุนุจู \nโ๏ธุงุฑุณู โคฝ ุงููููุฒูู ููุนุจ ูุฑู ุงุฎุฑู'
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
end
DevRio:set(storm..'Rio:Games:Ids'..msg.chat_id_,true)
end  
--     Source Storm     --
if text == 'ุงุณุฆูู' and ChCheck(msg) or text == 'ุงุฎุชูุงุฑุงุช' and ChCheck(msg) or text == 'ุงูุงุณุฆูู' and ChCheck(msg) or text == 'ุงุณุงูู' and ChCheck(msg) or text == 'โคฝ ุงุณุฆูู โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'ุงูููู','14','ุงููู','11','30','ุจูุชูู','ุณุชูู ุฌูุจุฑ','ุจุงุฑูุณ','10','ุงูููู','ุญุฑู ุงููุงู','ุงูุดุนุฑ','ุณุญุงุจ','ุงูุงุณู','ุฐูุจ','ุญุฑู ุงูุงู','ุงูุนุฒุงุฆู','ุงูุณุงุช','ุงูููุฌููู','ุงุณูุง','6','ุงูุงุณุฏ','ููุฑ','ุงูุฏููููู','ุงูุฑูุจุง','ุงูุฒุฆุจู','ููุฏู','ุงูุงูุณุงู','ุทูููู','ุฎุฏูุฌู',}
name = DevRio2[math.random(#DevRio2)]
DevRio:set(storm..'Rio:GameNum8'..msg.chat_id_,name)
DevRio:del(storm..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'ุงูููู','โ๏ธูุงูู ุงุทูู ููุฑ ูู ุงูุนุงูู ุ\n1- ุงูููู\n2- ุงููุฑุงุช\n3- ููุฑ ุงููููุบู')
name = string.gsub(name,'14','โ๏ธูุงุนุฏุฏ ุนุธุงู ุงููุฌู ุ\n1- 15\n2- 13\n3- 14')
name = string.gsub(name,'ุงููู','โ๏ธูุฑุงุณู ุจูุถุงุก ูุฌุฏุฑุงู ูุฑุฏูู ุงุฐุง ุงุบููุชู ุงุตุจุญ ุธูุงู  ููู ุงููู ุ\n1- ุงููู\n2- ุงูุงุฐู\n3- ุงูุซูุงุฌู')
name = string.gsub(name,'11','โ๏ธูู ุฌุฒุก ูุญุชูู ูุณูุณู ูุงุฏู ุงูุฐุฆุงุจ ุ\n1- 7\n2- 15\n3- 11')
name = string.gsub(name,'30','โ๏ธูู ุฌุฒุก ูุญุชูู ุงููุฑุงู ุงููุฑูู ุ\n1- 60\n2- 70\n3- 30')
name = string.gsub(name,'ุจูุชูู','โ๏ธูู ููู ุงุบูู ุฑุฆูุณ ูู ุงูุนุงูู ุ\n1- ุชุฑุงูุจ\n2- ุงูุจุงูุง\n3- ุจูุชูู')
name = string.gsub(name,'ุณุชูู ุฌูุจุฑ','โ๏ธูู ููู ูุคุณุณ ุดุฑูู ุงุจู ุงูุนุงูููู  ุ\n1- ูุงุฑู ุจุงูุฌ\n2- ุจูู ุฌูุชุณ\n3- ุณุชูู ุฌูุจุฑ')
name = string.gsub(name,'ุจุงุฑูุณ','ูุงูู ุนุงุตูู ูุฑูุณุง ุ\n1- ุจุงุฑูุณ\n2- ูููู\n3- ููุณูู')
name = string.gsub(name,'10','โ๏ธูุงุนุฏุฏ ุฏูู ุงูุนุฑุจูู ุงูุชู ุชูุฌุฏ ูู ุงูุฑูููุง ุ\n1- 10\n2- 17\n3- 9')
name = string.gsub(name,'ุงูููู','โ๏ธูุงูู ุงูุญููุงู ุงูุฐู ูุญูู 50 ููู ูุฒูู ุ\n1- ุงูููู\n2- ุงูููู\n3- ุงูุซูุฑ')
name = string.gsub(name,'ุญุฑู ุงููุงู','โ๏ธูุงุฐุง ููุฌุฏ ุจููู ูุจููู ุ\n1- ุงูุถู\n2- ุงูุงุฎูุงู\n3- ุญุฑู ุงููุงู')
name = string.gsub(name,'ุงูุดุนุฑ','โ๏ธูุงูู ุงูุดูุก ุงููุจุงุช ููุจุช ููุงูุณุงู ุจูุง ุจุฐุฑ ุ\n1- ุงูุงุถุงูุฑ\n2- ุงูุงุณูุงู\n3- ุงูุดุนุฑ')
name = string.gsub(name,'ุณุญุงุจ','โ๏ธูุง ูู ุงูุดููุก ุงูุฐู ูุณุชุทูุน ุงููุดู ุจุฏูู ุฃุฑุฌู ูุงูุจูุงุก ุจุฏูู ุฃุนูู ุ\n1- ุณุญุงุจ\n2- ุจุฆุฑ\n3- ููุฑ')
name = string.gsub(name,'ุงูุงุณู','โ๏ธูุง ุงูุดูุก ุงูุฐู ููุชููู , ูููู ุบูุฑูุง ูุณุชุนููู ุฃูุซุฑ ูููุง ุ\n1- ุงูุนูุฑ\n2- ุณุงุนู\n3- ุงูุงุณู')
name = string.gsub(name,'ุฐูุจ','โ๏ธุงุตูุฑ ุงูููู ุณุงุฑู ุนููู ุงูู ุงูููู ูุญุงุฑููู ูุฐูุฐ ุงูููู ุ\n1- ูุญุงุณ\n2- ุงููุงุณ\n3- ุฐูุจ')
name = string.gsub(name,'ุญุฑู ุงูุงู','โ๏ธูู ุงูููู ุซูุงุซุฉ ูููู ูู ุงูููุงุฑ ูุงุญุฏู ููุง ูู ุ\n1- ุญุฑู ุงูุจุงุก\n2- ุญุฑู ุงูุงู\n3- ุญุฑู ุงูุฑุงุก')
name = string.gsub(name,'ุงูุนุฒุงุฆู','โ๏ธุนูู ูุฏุฑ ุงุตู ุงูุนุฒู ุชุฃุชู ุ\n1- ุงูุนุฒุงุฆู\n2- ุงูููุงุฑู\n3- ุงููุจุงุฆุจ')
name = string.gsub(name,'ุงูุณุงุช','โ๏ธูุงูู ุฌูุน ูููู ุงูุณู ุ\n1- ุณูุฏุงุช\n2- ุงูุณุงุช\n3- ููุงูุต')
name = string.gsub(name,'ุงูููุฌููู','โ๏ธุงูู ุงุชุณุนููุช ูุฏููุง ูู ุงูุญุฑูุจ ุ\n1- ุงูุตุงุฑูุฎ\n2- ุงููุณุฏุณ\n3- ุงูููุฌููู')
name = string.gsub(name,'ุงุณูุง','โ๏ธุชูุน ูุจูุงู ูู ูุงุฑู ุ\n1- ุงูุฑูููุง\n2- ุงุณูุง\n3- ุงูุฑููุง ุงูุดูุงููู')
name = string.gsub(name,'6','โ๏ธูู ุตูุฑุง ููููููู ุ\n1- 4\n2- 3\n3- 6')
name = string.gsub(name,'ุงูุงุณุฏ','โ๏ธูุงูู ุงูุญููุงู ุงูุฐู ูููุจ ุจููู ุงูุบุงุจู ุ\n1- ุงูููู\n2- ุงูุงุณุฏ\n3- ุงูููุฑ')
name = string.gsub(name,'ููุฑ','โ๏ธูุง ุงุณู ุตุบูุฑ ุงูุญุตุงู ุ\n1- ููุฑ\n2- ุฌุฑู\n3- ุนุฌู')
name = string.gsub(name,'ุงูุฏููููู','โ๏ธูุง ุงูุญููุงู ุงูุฐู ููุงู ูุงุญุฏู ุนููู ููุชูุญู ุ\n1- ุงููุฑุด\n2- ุงูุฏููููู\n3- ุงูุซุนูุจ\n')
name = string.gsub(name,'ุงูุฑูุจุง','โ๏ธูุงูู ุงููุงุฑู ุงูุชู ุชููุจ ุจุงููุงุฑู ุงูุนุฌูุฒ ุ\n1- ุงูุฑูุจุง\n2- ุงูุฑููุง ุงูุดูุงููู\n3- ุงูุฑูููุง')
name = string.gsub(name,'ุงูุฒุฆุจู','โ๏ธูุง ุงุณู ุงููุนุฏู ุงูููุฌูุฏ ููู ุงูุญุงูู ุงูุณุงุฆูู ุ\n1- ุงููุญุงุณ\n2- ุงูุญุฏูุฏ\n3- ุงูุฒุฆุจู')
name = string.gsub(name,'ููุฏู','โ๏ธูุงูู ุนุงุตูู ุงูุฌูุชุฑุง ุ\n1- ููุฏู\n2- ููุฑุณูู\n3- ุชุฑููุง')
name = string.gsub(name,'ุงูุงูุณุงู','โ๏ธูุงูู ุงูุดุฆ ุงูุฐู ุจุฑุฃุณู ุณุจุน ูุชุญุงุช ุ\n1- ุงููุงุชู\n2- ุงูุชููุงุฒ\n3- ุงูุงูุณุงู')
name = string.gsub(name,'ุทูููู','โ๏ธูุงูู ุนุงุตูู ุงููุงุจุงู ุ\n1- ุจุงูููู\n2- ููู ุฏููู\n3- ุทูููู')
name = string.gsub(name,'ุฎุฏูุฌู','โ๏ธูู ูู ุฒูุฌู ุงูุฑุณูู ุงูุงูุจุฑ ููู ุณูุข ุ\n1- ุญูุถู\n2- ุฒููุจ\n3- ุฎุฏูุฌู')
stormTeam = name..'\nโ๏ธุงุฑุณู ุงูุฌูุงุจ ุงูุตุญูุญ ููุท'
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
return false
end end
if text == DevRio:get(storm..'Rio:GameNum8'..msg.chat_id_) then
if not DevRio:get(storm..'Rio:Games:Ids'..msg.chat_id_) then 
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
DevRio:del(storm..'Rio:GameNum8'..msg.chat_id_)
stormTeam = 'โ๏ธูุจุฑูู ููุฏ ุฑุจุญุช ูู ุงููุนุจู \nโ๏ธุงุฑุณู โคฝ ุงูุงุณุฆูู ููุนุจ ูุฑู ุงุฎุฑู'
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md')
end
DevRio:set(storm..'Rio:Games:Ids'..msg.chat_id_,true)
end  
--     Source Storm     --
if DevRio:get(storm.."GAME:TKMEN"..msg.chat_id_.."" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
Dev_Rio(msg.chat_id_, msg.id_, 1,"โ๏ธุนุฐุฑุง ูุง ููููู ุชุฎููู ุนุฏุฏ ุงูุจุฑ ูู ุงูู20 ุฎูู ุฑูู ูุง ุจูู ุงูู1 ูุงูู20", 1, 'md')
return false  end 
local GETNUM = DevRio:get(storm.."GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
DevRio:del(storm..'Set:Num'..msg.chat_id_..msg.sender_user_id_)
DevRio:del(storm.."GAME:TKMEN"..msg.chat_id_.."" .. msg.sender_user_id_)   
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_,5)  
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธ*ุงูุชุฎููู ุงูุตุญูุญ ูู* โคฝ '..NUM..'\nโ๏ธ*ูุจุฑูู ููุฏ ุฑุจุญุช ูุญุตูุช ุนูู 5 ููุงุท ููููู ุงุณุชุจุฏุงููุง ุจุงูุฑุณุงุฆู*', 1, 'md')
elseif tonumber(NUM) ~= tonumber(GETNUM) then
DevRio:incrby(storm..'Set:Num'..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(DevRio:get(storm..'Set:Num'..msg.chat_id_..msg.sender_user_id_)) >= 3 then
DevRio:del(storm..'Set:Num'..msg.chat_id_..msg.sender_user_id_)
DevRio:del(storm.."GAME:TKMEN"..msg.chat_id_.."" .. msg.sender_user_id_)   
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธ*ุงูุชุฎููู ุงูุตุญูุญ ูู* โคฝ '..GETNUM..'\nโ๏ธ*ููุงุณู ููุฏ ุฎุณุฑุช ุญุงูู ูุฑู ุงุฎุฑู ูุชุฎููู ุงูุฑูู ุงูุตุญูุญ*', 1, 'md')
else
if tonumber(DevRio:get(storm..'Set:Num'..msg.chat_id_..msg.sender_user_id_)) == 1 then
SetNum = 'ูุญุงููุชุงู ููุท'
elseif tonumber(DevRio:get(storm..'Set:Num'..msg.chat_id_..msg.sender_user_id_)) == 2 then
SetNum = 'ูุญุงููู ูุงุญุฏู ููุท'
end
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธููุฏ ุฎููุช ุงูุฑูู ุงูุฎุทุง ูุชุจูู ูุฏูู '..SetNum..' ุงุฑุณู ุฑูู ุชุฎููู ูุฑู ุงุฎุฑู ููููุฒ', 1, 'md')
end
end
end
end
if text == 'ุฎูู' and ChCheck(msg) or text == 'ุชุฎููู' and ChCheck(msg) or text == 'โคฝ ุชุฎููู โ' and ChCheck(msg) then   
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
Num = math.random(1,20)
DevRio:set(storm.."GAMES:NUM"..msg.chat_id_,Num) 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุงููุง ุจู ุนุฒูุฒู ูู ูุนุจุฉ ุงูุชุฎููู โคฝ โค\n โ โ โ โ โ โ โ โ โ\nโ๏ธุณูุชู ุชุฎููู ุนุฏุฏ ูุง ุจูู ุงูู1 ูุงูู20 ุงุฐุง ุชุนุชูุฏ ุงูู ุชุณุชุทูุน ุงูููุฒ ุฌุฑุจ ูุงููุนุจ ุงูุงู .\nโ๏ธููุงุญุธู ูุฏูู ุซูุงุซ ูุญุงููุงุช ููุท ููุฑ ูุจู ุงุฑุณุงู ุชุฎูููู !', 1, 'md')
DevRio:setex(storm.."GAME:TKMEN"..msg.chat_id_.."" .. msg.sender_user_id_, 100, true)  
return false  
end
end
--     Source Storm     --
if text == 'ุฑูููุช' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
DevRio:del(storm.."Rio:NumRolet"..msg.chat_id_..msg.sender_user_id_) 
DevRio:del(storm..'Rio:ListRolet'..msg.chat_id_)  
DevRio:setex(storm.."Rio:StartRolet"..msg.chat_id_..msg.sender_user_id_,3600,true)  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุญุณูุง ูููุนุจ , ุงุฑุณู ุนุฏุฏ ุงููุงุนุจูู ููุฑูููุช .', 1, 'md')
return false  
end
end
if text and text:match("^(%d+)$") and DevRio:get(storm.."Rio:StartRolet"..msg.chat_id_..msg.sender_user_id_) then
if text == "1" then
Text = "โ๏ธูุง ุงุณุชุทูุน ุจุฏุก ุงููุนุจู ุจูุงุนุจ ูุงุญุฏ ููุท"
else
DevRio:set(storm.."Rio:NumRolet"..msg.chat_id_..msg.sender_user_id_,text)  
Text = 'โ๏ธุชู ุจุฏุก ุชุณุฌูู ุงููุณุชู ูุฑุฌู ุงุฑุณุงู ุงููุนุฑูุงุช \nโ๏ธุงููุงุฆุฒ ูุญุตู ุนูู 5 ููุงุท ุนุฏุฏ ุงููุทููุจูู โคฝ '..text..' ูุงุนุจ'
end
DevRio:del(storm.."Rio:StartRolet"..msg.chat_id_..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,Text)
return false
end
if text and text:match('^(@[%a%d_]+)$') and DevRio:get(storm.."Rio:NumRolet"..msg.chat_id_..msg.sender_user_id_) then 
if DevRio:sismember(storm..'Rio:ListRolet'..msg.chat_id_,text) then
send(msg.chat_id_,msg.id_,'โ๏ธุงููุนุฑู โคฝ ['..text..'] ููุฌูุฏ ุงุณุงุณุง')
return false
end
tdcli_function ({ID = "SearchPublicChat",username_ = text},function(extra, res, success) 
if res and res.message_ and res.message_ == "USERNAME_NOT_OCCUPIED" then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุงููุนุฑู ุบูุฑ ุตุญูุญ ูุฑุฌู ุงุฑุณุงู ูุนุฑู ุตุญูุญ', 1, 'md')
return false 
end
DevRio:sadd(storm..'Rio:ListRolet'..msg.chat_id_,text)
local CountAdd = DevRio:get(storm.."Rio:NumRolet"..msg.chat_id_..msg.sender_user_id_)
local CountAll = DevRio:scard(storm..'Rio:ListRolet'..msg.chat_id_)
local CountUser = CountAdd - CountAll
if tonumber(CountAll) == tonumber(CountAdd) then 
DevRio:del(storm.."Rio:NumRolet"..msg.chat_id_..msg.sender_user_id_) 
DevRio:setex(storm.."Rio:WittingStartRolet"..msg.chat_id_..msg.sender_user_id_,1400,true) 
local Text = "โ๏ธุชู ุงุฏุฎุงู ุงููุนุฑู โคฝ ["..text.."]\nโ๏ธูุชู ุงูุชูุงู ุงูุนุฏุฏ ุงูููู ูู ุงูุช ูุณุชุนุฏ ุ"
keyboard = {} 
keyboard.inline_keyboard = {{{text="ูุนู",callback_data="/YesRolet"},{text="ูุง",callback_data="/NoRolet"}},{{text="ุงููุงุนุจูู",callback_data="/ListRolet"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end 
local Text = "โ๏ธุชู ุงุฏุฎุงู ุงููุนุฑู โคฝ ["..text.."] ูุชุจูู โคฝ "..CountUser.." ูุงุนุจูู ูููุชูู ุงูุนุฏุฏ ุงุฑุณู ุงููุนุฑู ุงูุงุฎุฑ"
keyboard = {} 
keyboard.inline_keyboard = {{{text="ุงูุบุงุก",callback_data="/NoRolet"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil) 
end
--     Source Storm     --
if text == 'ูุช ุชููุช' and ChCheck(msg) or text == 'ูุช' and ChCheck(msg) or text == 'ุชููุช' and ChCheck(msg) or text == 'โคฝ ูุช โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
local stormTeam = {
'ุขุฎุฑ ูุฑุฉ ุฒุฑุช ูุฏููุฉ ุงูููุงููุ','ุขุฎุฑ ูุฑุฉ ุฃููุช ุฃููุชู ุงูููุถููุฉุ','ุงููุถุน ุงูุญุงููุ\nโ1. ุณูุฑุงู\nโ2. ุถุงูุฌ\nโ3. ุฃุชุฃูู','ุขุฎุฑ ุดูุก ุถุงุน ูููุ','ูููุฉ ุฃุฎูุฑุฉ ูุดุงุบู ุงูุจุงูุ','ุทุฑููุชู ุงููุนุชุงุฏุฉ ูู ุงูุชุฎููุต ูู ุงูุทุงูุฉ ุงูุณูุจูุฉุ','ุดูุฑ ูู ุฃุดูุฑ ุงูุนุงู ูู ุฐูุฑู ุฌูููุฉ ูุนูุ','ูููุฉ ุบุฑูุจุฉ ูู ููุฌุชู ููุนูุงูุงุ๐ค','โ- ุดูุก ุณูุนุชู ุนุงูู ูู ุฐููู ูุงููููููุ','ูุชู ุชูุฑู ุงูุดุฎุต ุงูุฐู ุฃูุงูู ุญุชู ูู ููุช ููู ุฃุดุฏ ูุนุฌุจูููุ','โ- ุฃุจุฑุฒ ุตูุฉ ุญุณูุฉ ูู ุตุฏููู ุงูููุฑุจุ','ูู ุชุดุนุฑ ุฃู ููุงูู ููู ููุญุจูุ','ุงุฐุง ุงูุชุดูุช ุฃู ุฃุนุฒ ุฃุตุฏูุงุฆู ูุถูุฑ ูู ุงูุณูุกุ ููููู ุงูุตุฑูุญุ','ุฃุฌูู ุดูุก ุญุตู ูุนู ุฎูุงู ูุงููููุ','ุตูู ุดุนูุฑู ูุฃูุช ุชูุญุจ ุดุฎุต ููุญุจ ุบูุฑูุ๐๐','ูููุฉ ูุดุฎุต ุบุงูู ุงุดุชูุช ุฅูููุ๐','ุขุฎุฑ ุฎุจุฑ ุณุนูุฏุ ูุชู ูุตููุ','ุฃูุง ุขุณู ุนูู ....ุ','ุฃูุตู ููุณู ุจูููุฉุ','ุตุฑูุญุ ูุดุชุงูุ','โ- ุตุฑูุญุ ูู ุณุจู ูุฎุฐูุช ุฃุญุฏูู ููู ุนู ุบูุฑ ูุตุฏุ','โ- ูุงุฐุง ุณุชุฎุชุงุฑ ูู ุงููููุงุช ูุชุนุจุฑ ููุง ุนู ุญูุงุชู ุงูุชู ุนุดุชูุง ุงูู ุงูุขูุ๐ญ','โ- ููุงู/ุฉ ุชูุฏ ูู ูุฏุนููู ุนูู ูุงุฆุฏุฉ ุนุดุงุกุ๐โค','โ- ุชุฎููู ุดูุก ูุฏ ูุญุฏุซ ูู ุงููุณุชูุจูุ','โ- ููุดุจุงุจ | ุขุฎุฑ ูุฑุฉ ูุตูู ุบุฒู ูู ูุชุงุฉุ๐','ุดุฎุต ุฃู ุตุงุญุจ ุนูุถู ููุณุงู ููุฑ ุงูุญูุงุฉ ูุง ุงุณูู ุ','| ุงุฐุง ุดูุช ุญุฏ ูุงุนุฌุจู ูุนูุฏู ุงูุฌุฑุฃู ุงูู ุชุฑูุญ ูุชุชุนุฑู ุนููู ุ ููุฏูุฉ ุงูุญุฏูุซ ุดู ุฑุงุญ ุชููู ุ.','ูู ูุฑู ุชุณุจุญ ุจุงูููู','ูุณุจุฉ ุงููุนุงุณ ุนูุฏู ุญุงูููุงุ','ูู ููุท ูุณููุญ ุดุฎุต ูุงุญุฏ ุชุชุงุจุนู ูุงูุณูุงุจ ููู ุจูููู ุ','ูููู ููุงุจุณู ุชููู ูุงุฑูุฉ ุ','ูุด ุงูุดูุก ุงูู ุชุทูุน ุญุฑุชู ููู ู ุฒุนูุช ุ','ุนูุฏู ุฃุฎูุงู ุงู ุฎูุงุช ูู ุงูุฑุถุงุนุฉุ','ุนูุฏู ูุนุฌุจูู ููุง ูุญุฏ ุฏุฑุง ุนููุ','ุฃุตุนุจ ุตูุฉ ูุฏ ุชุชูุงุฌุฏ ูู ุงูุฑุฌู .ุ','ูู ุงููุฏู ุงูู ุชุฎููู ุชููุน ุจุญุจ ุงูุดุฎุตุ.','ุชุญุณ ุงูู ูุณุชุนุฏ ูููุงุก ุงููู ููุง ุจุงูู.ุ','ูุชุตุงูุญ ูุน ููุณูุ.','ูุณูุฑ ุนูู ุฃุตุจุนู ุงูุจุงุจ ููุง ุชุนุถ ูุณุงูู  ุจุงูุบูุทุ!','ุนูุฏู ุบูุงุฒุงุชุ.','โุฃููุงูู ุงูููุถููุฉุ','ุฑุฏุฉ ูุนูู ููุง ุชูุธูู ูู ุดุฎุต ุ','ูุด ุงูุญุจ ุจูุธุฑูุ','ุฃูุซุฑ ุดูุก ุชูุฏุฑู ูู ุงูุตุฏุงูุงุชุ','โููุฎูุฑูู โ ุงูุงูู ูู ุงููุช ุ!','ุนุงุฌุจู ูุฌูุฏู ูู ุงูุชูู ููุง ุชุชููู ุชุญุฐูุฉ.ุ','ุงูุถู ูุฏูู ูููู ุชูุงุณุจูุ','ุดุนูุฑู ุงูุญุงูู ูู ุฌููุฉุ','ุฃูุง ุญุฒูู ุฌุฏุงู ุฃุฌุนููู ุฃุจุชุณู.ุ','ุจูุงุฐุง ูุชุนุงูู ุงููุฑุกุ','ุชุงู ูุดุฎุต ููุณููุ','ุดุงุฑููุง ุจูุช ุดุนุฑู ุญุฒูู ุนูู ุฐููู.ุ','ุงุบููุฉ ุนูุฏู ุจููุง ุฐูุฑูุงุชุ','ุงุดูุงุก ุชูุชุฎุฑ ุงูู ู ุณููุชูุง ุ','ุงูุตุฑุงุญุฉ ููุงุญุฉ ููุง ุตุฏู ุชุนุงูู.ุ','ุงููู ุงุตุฏู ูุธุฑุฉ ุงูุนูู ุงู ูุจุฑุฉ ุงูุตูุช ุ','โูููุฉ ุงููุงู ูุฏู ุงูุฑุฌู ูู ูุฐุง ุงูุฒูู ูุนุชุจุฑูุง ุงูุนุฏูุฏ ูุงููุง ุนูุจุ ูุน ุฃู ุถุฏุ','ุฅูููุง ุชููุถู ุญูุจ ูุงุฌุญ ุฃู ุตุฏุงูุฉ ุฏุงุฆูุฉ.ุ','ุนูู ููุงุชููู ุชูุฑุฒููู ุชุงู ูุดุฎุต ููุทุจู ุนููุฉ ูุฐุง ุงูุดูุก.ุ','ุงูุซุฑ ูููุฉ ุชุฑูุน ุถุบุทู ุ','ูู ุฃุตุญุงุจ ุงููุงุถู ูุงูุญููู ููุง ุงูุตูุญุงุช ุงููุทููุฉ.ุ','ูู ุฃุตุญุงุจ ุงููุณูุงู ุงู ุงูุชุฌุงูุฒ ุฑุบู ุงูุฐูุฑู.ุ','ุบุฒู ุจููุฌุชู ุ','ูุตุฑููู ููุ.','ููุญุชูุช โ ูุงุฐุง ุชูุถูููู ุฃู ุชููู ูููุฉ ุดุฑูู ุญูุงุชู ุงููุณุชูุจูู.ุ','ูููู ุถุงุน ุนููุ','ูุง ุงูุฐู ุงุณุนุฏู ุงูููู .ุ','ููู ุชุชุนุงูู ูุน ุงูุดุฎุต ุงูููุชุทูู ( ุงููุถููู ) ุ','ุฃุตุนุจ ุตูุฉ ูุฏ ุชุชูุงุฌุฏ ูู ุงููุฑุฃุฉ.ุ','ูุน ุฃู ุถุฏ ูู ูุงู ุฎูุฑุงู ูุจูุฆ.ุ','ูุตูุญุฉ ููู ุดุฎุต ูุฐูุฑ ุฃุญุฏ ุจุบูุงุจุฉ ุจุงูุณูุก.ุ','ูู ุดูุก ูููู ุงูุง ุ','ูู ุฃูุช ูู ุงูููุน ุงูุฐู ููุงุฌู ุงููุดุงูู ุฃู ูู ุงูููุน ุงูุฐู ููุฑุจ ุ','ูููู ูุดุฎุต ุฎุงูู!ุ.','ุชุญุจ ุชุญุชูุธ ุจุงูุฐูุฑูุงุช ุ','ุดุงุฑููุง ุฃููู ุจูุช ุดูุนุฑ ูู ุชุฃููููุ','โุงุณุฑุน ุดูุก ูุญุณูู ูู ูุฒุงุฌูุ','ูููุชู ุงูุชุณููููู ุ','ูู ุณุงุนุงุช ููููุ.','ุนูุฏู ููุจูุง ุงู ุฎูู ุดุฏูุฏ ูู ุดูุก ูุนูู ุ','ูููุจุฉ ุชููุฒ ุจูุฏุญ ุงููุงุณ ูู.ุ','ูุฏูุชู ูู ุงูุฃุฌูุงู ุงูุณุงุจูุฉุ','ุดุฎุต ุชุชููุฆ ูู ุงูููุชุ.','ุนุงุฏุฉู ุชูุญุจ ุงูููุงุด ุงูุทููู ุฃู ุชุญุจ ุงูุงุฎุชุตุงุฑุ','ุชุงู ูุดุฎุต ููุชู ุฒุจุงูู๐ุ','ุตูุชู ุญูู ุ .','ูููุชูู ุชูุฑุฑูุง ุฏุงููุ!','ุงูุถู ุฑูุงูู ูุฑูุชููุงุ.','ูุชู ุญุฏุซ ุงูุชุบููุฑ ุงููุจูุฑ ูุงูููุญูุธ ูู ุดุฎุตูุชูุ','ุฃูุซุฑ ุงูููู ุชุญุจูุงุ.','โูููุง ุงุฒุฏุงุฏุช ุซูุงูุฉ ุงููุฑุก ุงุฒุฏุงุฏ ุจุคุณู','ุชุชูู.ุ','ุงุบุจู ูุฐุจู ุตุฏูุชูุง ุจุทูููุชูุ.','ูู ุงููุฏู ุงูู ุชุฎููู ุชููุน ุจุญุจ ุงูุดุฎุตุ.','ุชุณุงูุญ ุดุฎุต ูุฌุน ููุจู ุ.','ุฑุฏุฉ ูุนูู ููุง ุชูุธูู ูู ุดุฎุต ุ','ุดูุก ูุนุฏู ููุณูุชู ุจุซูุงูู.ุ','โุชุชููุน ุงูุฅูุณุงู ูุญุณ ุจูุฑุจ ููุชูุ','ููุช ุญุฒูู ุชูุฌุฃ ููู ูุฎูู ุนูู.ุ','โุฃูุซุฑ ุดูุก ุดุฎุตู ุถุงุน ูููุ','ุชุฒุนูู ุงูุฏููุง ููุฑุถูู ุ','ูุง ุงูุฐู ูุดุบู ุจุงูู ูู ุงููุชุฑุฉ ุงูุญุงููุฉุ','ููุงุฑู ูุตูุฑ ุฃุฌูู ุจูุฌูุฏ ..ุ','ุญุณูุช ุงูู ุธููุช ุดุฎุต.ุ','ุตูุฉ ูุทูููุง ุนููู ูู ุญููู ุจูุซุฑุฉุ','โููู ูุง ููููู ูุณูุงููุ','ุฃูุซุฑ ุงูููู ุชุญุจูุงุ.','ุงุฎุฑ ูููุฉ ูุงููุง ูู ุญุจูุจูุ.','ูู ุงูุดุฎุต ุงูุงูุฑุจ ูููุจูุ.','ูู ุงููุฏู ุงูู ุชุฎููู ุชููุน ุจุญุจ ุงูุดุฎุตุ.','ูุงูู ุงููุฏูุฉ ุงูุชู ุชุชููู ุฃู ุชูุชุธุฑู ููููุง ุฃูุงู ุจุงุจ ููุฒููุ','โุงุณู ุงู ุชุงู ูุดุฎุต ูุง ุชุฑุชุงุญ ูู ูููู ุฅูุง ุฅุฐุง ุญุงุฌูุชูุ','ุตุฏูู ุฃูู ููุง ุฃุจูู. ุ','ููุงุฐุง ุงูุฃุดูุงุก ุงูุชู ูุฑูุฏูุง ุจุดุบู ุชุฃุชู ูุชุฃุฎุฑุฉุ','โุชูุจู ุจุงูุนูุฏุฉ ูุดุฎุต ูุณุฑ ููุจู ูุฑุชููุ','ุงูุถู ูุฏูู ูููู ุชูุงุณุจูุ','ูููุฉ ุบุฑูุจุฉ ููุนูุงูุงุ','ุงุฐุง ุงุดุชูุช ุชูุงุจุฑ ููุง ุชุจุงุฏุฑ ุ.','ุจุงููุงูู ุชูุฒุน ุดุนูุฑ ูู ููุจู ููุงุจุฏ ุ ุงูุด ููุ.','ูู ุจุชุบูุฑ ุงุณูู ุงูุด ุจูููู ุงูุฌุฏูุฏ ุ','โุดุฎุตูุฉ ูุง ุชุณุชุทูุน ุชูุจููุงุ','ูุง ูู ุทุฑููุชู ูู ุงูุญุตูู ุนูู ุงูุฑุงุญุฉ ุงูููุณูุฉุ','โุงูููุฌู ููุตู ูุฒุงุฌู ุญุงูููุง ุจุฏูุฉุ','ุชุงุฑูุฎ ูููุงุฏูุ','ููู ุชุญุฏ ุงูุฏููุฉ ูู ุงูููุฑ ุงูููุชุฒุงูุฏ.ุ','โุดู ูุณุชุญูู ูุชุบูุฑ ูููุ','ูู ุงุฎุฐูู ููุณุชุดูู ุงููุฎุงุจูู ููู ุชุซุจุช ุงูุช ุตุงุญูุ','ุฅูููุฌู ูุนุจูุฑ ุนู ูุฒุงุฌู ุงูุญุงููุ','ููุช ุญุฒูู ุชูุฌุฃ ููู ูุฎูู ุนูู.ุ','ุงุนุชุฑู ุจุงู ุญุงุฌู ุ','ุดุงุฑููู ุขุฎุฑ ุตูุฑุฉ ุฌูููุฉ ูู ูุงููุฑุง ูุงุชูู.ุ','ูุชุตุงูุญ ูุน ููุณูุ.','ูู ุนูุฏู ุงูููู ูุจุชุญูู ูุด ููุ.','ูู ุงูุช ุดุฎุต ูุงุฏู.ุ','ุฃุฎุฑ ุงุชุตุงู ุฌุงู ูู ููู ุ','ุชุงู ูุตุฏููู ุงููููุฑุจุ.','ุชุญุจ ุงูุนูุงูุงุช ุงูุนุงุทููู ููุง ุงูุตุฏุงููุ.','ุงูุนูู ุงูู ุชุณุชุตุบุฑู........ุ','ุชุฌุงูู ุงููุงุณ ููุง ุงููู ุจููุจู ุนูู ูุณุงููุ','ููุช ุญุฒูู ุชูุฌุฃ ููู ูุฎูู ุนูู.ุ','ุงูุซุฑ ุงููุชุงุจุนูู ุนูุฏู ุจุงู ุจุฑูุงูุฌุ','ุตูู ุชุชููุงูุง ุจุดุฑูู ุญูุงุชูุ.','ูู ุงุตุฏู ูู ุงูุญุจ ุงูููุฏ ููุง ุงูุจูุชุ.','ูุฑุฏ ุนููู ูุชุฃุฎุฑ ุนูู ุฑุณุงูุฉ ูููุฉ ูุจูู ุจุฑูุฏุ ูููููุ','ูููุฉ ูุดุฎุต ุจุนูุฏุ','ุฑุญุชู ูุนุฑุณ ูุฃูุชุดูุชู ุงูุนุฑูุณ ุญุจูุจู ุดูู ุฑุฏุฉ ูุนูู.ุ','ุชุณุงูุญ ุดุฎุต ูุฌุน ููุจู ุ.','ุงุญูุฑ ูููู ุตุงุฑ ููุ.','ูุงุฐุง ูู ูุงูุช ูุดุงุนุฑ ุงูุจุดุฑ ูุฑุฆูุฉ ุ','ููู ูููู ุงูุณุนุงุฏู ุจุฑุงููุ','ูุฏ ุชุฎููุช ุดู ูู ุจุงูู ูุตุงุฑ ุ','ุตูุฉ ูุทูููุง ุนููู ุงูุดุฎุต ุงูููุถููุ','ุงุฎุฑ ุฎูุงููุ.','ุชุญุจ ุชุญุชูุธ ุจุงูุฐูุฑูุงุช ุ','ูู ุจุชุบูุฑ ุงุณูู ุงูุด ุจูููู ุงูุฌุฏูุฏ ุ','ุงูุงุนุชุฐุงุฑ ุฃุฎูุงู ููุง ุถุนู.ุ','ูู ุฃูุช ูู ุงูููุน ุงูุฐู ููุงุฌู ุงููุดุงูู ุฃู ูู ุงูููุน ุงูุฐู ููุฑุจ ุ','โ ุชูุฑู ุฃุญุฏ ูู ููุจู ุ','ุชุงู ูุดุฎุต ููููู ุงุนุชุฑู ููุ','ูุน ุฃู ุถุฏ ูู ูุงู ุฎูุฑุงู ูุจูุฆ.ุ','โูู ูุฏูู ุดุฎุต ูุง ุชุฎูู ุนูู ุดูุฆูุงุ','ุงุบููู ุชุฃุซุฑ ุจููุ','ุงููุทูุนุฉ ูุงูุนุงููุฉ ูู ุดูุชู.ุ','ููุงุตูุงุช ุงููุฑ/ุฉ ุงุญูุงููุ.','โูููุฉ ูุตุฏููู ุงูุจุนูุฏุ','ุชุชุงุจุน ุงูููุ ุฅุฐุง ูุนู ูุง ุฃูุถู ุงููู ุดุงูุฏุชูุ','ูุฑุงุฑุชู ุฑุงุถู ุนููุง ุงู ูุง ุ','ุชุณุงูุญ ุดุฎุต ุณุจุจ ูู ุจูุงุฆู.ุ','ูู ุญุตู ูุงุดุชุฑูุช ุฌุฒูุฑุฉุ ูุงุฐุง ุณุชุฎุชุงุฑ ุงุณููุง ููุง.ุ','ุงุบููุชู ุงูููุถูุฉุ.','ุดุงุฑููุง ุงููุฆ ููุชุฉ ุนูุฏู.ุ','ูุงุฐุง ูู ุนุงุฏ ููุดุชุงูุงู.ุ','ูุณูุณู ูุฑุชููู ูู ุฐูุฑูุงุช ุฌูููุฉ ุนูุฏูุ','ุฃุฎุฑ ุงุชุตุงู ุฌุงู ูู ููู ุ','ุญููุงูู ุงูููุถูุ','ุงูู ููุฏ ูู ุดูู ุฑุญ ุชุณููู ุ','ุณุจุจ ุงูุฑุญูู.ุ','ููููุง ุจููุฌุชู ยซ ูุง ุฃููู ุงููุงู ยป.ุ','ููุงุฑู ูุตูุฑ ุฃุฌูู ุจูุฌูุฏ ..ุ','โูู ุฎูุฑููุ ุงูุฒูุงุฌ ุจูู ุชูุญุจ ุงู ุชุงุฎุฐ ููููู ุฏููุงุฑุ','ุชุงู ูุดุฎุต ุณูุงููู ุญููู ุ','ุชุตุฑู ูุง ููููู ุฃู ุชุชุญููู.ุ','ูุงูู ุงูุงุทุจุงุน ููู ุงูุชู ุชุญุงูู ุงุฎูุงุฆูุง ุนู ุงููุงุณุ.','ุดูุก ุนูุฏู ุงูู ูู ุงููุงุณุ','ูุฏ ุชุฎููุช ุดู ูู ุจุงูู ูุตุงุฑ ุ','ุชูุญู ุงูุนุดุฑุฉ ุงูุทูุจุฉ ุนุดุงู ูููู ูุงุนุฌุจู ุฃู ุณูุก ููู.ุ','ุฌุฑุจุช ุดุนูุฑ ุงุญุฏ ูุญุจู ุจุณ ุงูุช ูุชูุฏุฑ ุชุญุจูุ','ุจููุณู ุชุจูุณ ุดุฎุต ุจูุงู ุงูุญุธูุ','ุฅุฐุง ูุงูุช ุงูุตุฑุงุญุฉ ุณุชุจุนุฏ ุนูู ูู ุชุญุจ ูู ุชูุชูู ุงูุดุฌุงุนุฉ ูููุตุงุฑุญุฉ ุงู ูุง .ุ','ุฃููู ุงูุฏุนุงุก ุจูุง ุดุฆุช โุงูููู ุฃุฑุฒููู ..ุ','ุงูุตู ุงุฎุฑ ุดูุก ูุณุฎุชู .ุ','โุชูุถู ุฌููุฉ ูู ุงูุบุงุจุฉ ุฃู ุฌููุฉ ุจุญุฑูุฉุ','โุชุงู ูุดุฎุต ูุฏูู ูุง ุชุฎูู ุนูู ุดูุ','ูููุฉ ุบุฑูุจุฉ ููุนูุงูุงุ','โุงููุงุช ูุง ุชุญุจ ุงู ููููู ูููุง ุงุญุฏุ','ุชููู ูุณูุงุณ ูู ุดูุก ูุนูู ุ','ุงุดูุฑ ููุทุน ูู ุงุบููู ูุชุทูุน ููุฑุงุณูุ','ูู ุชุชุฃุซุฑูู ุจุงูููุงู ุงูุฑููุงูุณู ูู ุงูุดุจุงุจุ','ูุง ุงูู ุดูุก ูููุช ุงูุชุจุงูู ูู ุงูุฑุฌูุ','ูุงุฐุง ุชูุนููู ุงุฐุง ุชุนุฑุถุชู ููุชุญุฑุด ูู ูุจู ุดุฎุต ูุง..ุ','ุงุฐุง ููุช ุดุฎุตุงู ุบูู ูู ุชูุงูู ุนูู ุงูุฒูุงุฌ ูู ูุชุงุฉ ูููุฑุฉ..ุ','ูุง ูู ุฃูุซุฑ ุดุฆ ูุง ุชุณุชุทูุน ุชุญููู..ุ','ูุง ูู ููุงุท ุงูุถุนู ูู ุดุฎุตูุชู..ุ','ูู ุชูุงูู ุฃู ุฒูุฌุชู ุชุฏูุน ุงูุญุณุงุจ ูู ุฅุญุฏู ุงููุทุงุนู ูุฃูุช ููุฌูุฏุ','ูุงุฐุง ุชูุนู ูู ุฃูุชุดูุช ุงู ุฒูุฌุชู ุนูู ุนูุงูุฉ ุจุตุฏูููุ','ูุง ูู ุฃูุซุฑ ุตูุฉ ุชูุฑููุง ูู ุฒูุฌุชู..ุ','ุงุฐุง ูุงู ูุฏูู ูุฑุตุฉ ููุฎุฑูุฌ ูุน ูู ุณูู ุชุฎุฑุฌ ุฑุจุนู ุงู ุฒูุฌุชู..ุ','ูุงุฐุง ุชูุนู ุนูุฏูุง ุชุฑู ุฏููุน ุฒูุฌุชู..ุ','ุฅูู ุฃู ุงูุฑุฌุงู ุชูุฑูุฏูู ุฃู ูููู ุงูุชูุงุคูุ','ูู ูุฑุฉ ุฎูุฏุนุช ูู ุฃุดุฎุงุตูุ ูุซูุชู ูููู ุซูุฉู ุนููุงุกุ','ูู ูุง ุฒุงู ุฃุตุฏูุงุก ุงูุทูููุฉ ุฃุตุฏูุงุกู ูู ุญุชู ุงูุขูุ','ูู ุชุฑุบุจูู ูู ุฃู ูููู ุฎุทูุจู ูุณูููุงุ','ูู ูุฑุฉู ูุนูุช ุดูุฆูุง ูุง ุชุฑุบุจูู ูู ุงูุฅูุตุงุญ ุนููุ','ูู ุงุณุชุทุนุช ุฃู ุชูุญููู ุขูุงูู ุงูุนูููุฉ ูุงูุนุงุทููุฉุ','ุฃูุซุฑ ุดุฆ ูุฏูุช ุนูู ูุนูู..ุ','ูู ุชุดุนุฑูู ุฃูู ูุชุงุฉ ูุญุธูุธุฉ..ุ','ูู ุนูุงูุฉ ุงูุญุจ ุงูุชู ูุงูุช ูู ุตุบุฑูุ ูุงุฒุงูุช ูุณุชูุฑุฉุ','ูุง ูู ุฃูุซุฑ ุดุฆ ููุฑุญู ูู ูุฐู ุงูุญูุงุฉ..ุ','ูู ูุฑุฉ ุฃุฑุฏุช ุดุฑุงุก ููุงุจุณ ูุฃููุง ุฌูููุฉ ูููููุง ูุง ุชูุงุณุจู..ุ','ูู ุนุฏุฏ ุงููุฑุงุช ุงูุชู ููุช ูููุง ุจุฅุณุชุจุฏุงู ุดุฆ ุงุดุชุฑูุชู ููู ูุนุฌุจู ุจุนุฏ ุฐูู.ุ','ูู ูุฑุฉ ููุช ุจูุณุฑ ุงูุฑุฌูู ูู ุฃุฌู ุชูุงูู ุทุนุงูู ุงูููุถู..ุ','ูู ุชุนุฑุถุช ููุธูู ูููุงู ูุง ูุนูู ูุฏ ูู..ุ','ูู ูุฐุจุช ุนูู ูุงูุฏูู ูู ูุจู..ุ','ูู ุฎุฑุฌุชู ูุน ุดุฎุต ุชุนุฑูุชู ุนููู ูู ุฎูุงู ุงูุชูููุฑุงู ูู ูุจู..ุ','ูู ูู ุชูุฏู ุดุฎุต ูุงุฎุชู ูู ุฃุฌู ุฎุทุจุชูุง ููุงูุช ุจุฑูุถู ุชูุจููู ุจู..ุ','ููู ุชููููู ูุง ุฃุณุชุทูุน ุงูุนูุด ุจุฏููู..ุ','ูู ุนุฏุฏ ุงููุฑุงุช ุงูุชู ุชุนุฑุถุชู ูููุง ุฅูู ุฃุฒูุฉ ููุณูุฉ ูุฃุฑุฏุชู ุงูุตุฑุงุฎ ุจุฃุนูู ุตูุชู..ุ','ูุงุฐุง ุชููู ููุจุญุฑุ','ุฃุตุนุจ ุตูุฉ ูุฏ ุชุชูุงุฌุฏ ูู ุฑุฌูุ','ูุง ุฃุฌูู ุงูุญูุงุฉ ุจุฏูู ...ุ','ููุงุฐุง ูู ุชุชู ุฎุทุจุชู ุญุชู ุงูุขู..ุ','ูุณุจุฉ ุฑุถุงู ุนู ุงูุฃุดุฎุงุต ูู ุญููู ูุงููุชุฑุฉ ุ','ูุง ุงูุณูุก ูู ูุฐู ุงูุญูุงุฉ ุ','ุงููููุณ ุงู ุงูุญุจ ุ','ุฃุฌูู ุดูุก ุญุตู ูุนู ุฎูุงู ูุฐุง ุงูุงุณุจูุน ุ','ุณุคุงู ููุฑูุฒู ุ','ูู ูู ุญุณุงุจู ุงูุจููู ุ','ุดู ุนูุฏู ุงูู ูู ุงููุงุณ ุ','ุงูู ููุฏ ุงู ุจูุช ุงูู ุดูู ุชุณูู ุ','ุชูุถูู ุงูููุงุด ุงูุทููู ุงู ุชุญุจ ุงูุงุฎุชุตุงุฑ ุ','ุนุงุฏู ุชุชุฒูุฌ ุงู ุชุชุฒูุฌูู ูู ุฎุงุฑุฌ ุงูุนุดูุฑู ุ','ูู ูุฑู ุญุจูุช ุ','ุชุจุงุฏู ุงููุฑุงููุฉ ุจุงููุฑุงููุฉุ ููุง ุชุญุฑุฌู ุจุงูุทูุจ ุ','ููุจู ุนูู ููุจู ูููุง ุตุงุฑ ูููู ุชููููุง ุ','ุงูุซุฑ ุงููุชุงุจุนูู ุนูุฏู ุจุงู ุจุฑูุงูุฌ ุ','ูุณุจุฉ ุงููุนุงุณ ุนูุฏู ุญุงูููุง ุ','ูุณุจู ุงููุฏู ุนูุฏู ููู ูุซูุช ุจููู ุ','ุงูู ุดุฎุต ุชุนุฑูุช ุนููู ุจุงูุชูููุฑุงู ุจุนุฏู ููุฌูุฏ ุ','ุงุฐุง ูุฏููู ุดุฎุต ุถููู ุดูู ููููู ุ','ุงูุถู ุนูุฑ ููุฒูุงุฌ ุจุฑุฆูู ุ','ุงูุช ูู ุงูููุน ุงูู ุฏุงุฆูุง ููุบุฏุฑ ูู ุงูุฑุจ ุงููุงุณ ุงูู ุ','ูุงูู ุญููุงูู ุงูููุถู ุ','ุชุงุฑูุฎ ูููุงุฏู ุ','ูููู ุงูููุถู ุ','ุงูุช ูู ุงูููุน ุงูุนุงุทูู ูุงูู ูููุฏุฑ ููุชู ุงูุจุฏุงุฎูู ุ','ุงุฐุง ูุฏููู ุดุฎุต ุฎุงูู ููุฑูุฏ ูุฑุฌุนูู ุชูุจู ุ','ุดู ุจุงูุญูุงู ูุฎููู ุนุงูุด ูุญุฏ ุงูุงู ุ','ุชุญุจ ุงูููู ูู ุงูุดุบู ุ','ุงูุถู ููุงู ุฑุญุช ุนููู ุ','ุงุฎุชุตุฑ ุงููุงุถู ุจูููู ูุญุฏู ุ','ูู ุณุจู ูููุช ูุตุฑ ุนูู ุฃูุฑ ูุง ููู ุซู ุงูุชุดูุช ุฃูู ููุช ุนูู ุฎุทุฃ ุ','ุงูุซุฑ ูููุฉ ุชุฑูุน ุถุบุทู ุ','ูุน ุงู ุถุฏ ุณุจ ุงูุจูุช ููุฏูุงุน ุนู ููุณูุง ุ','ูููู ุธู ุงููุงุณ ุจูู ูู ูุงุ','ุนุจูุฑ ุนู ููุฏู ุจุตูุฑู ุ','ุงุบูุจ ููุชู ุถุงูุน ูู ุ','ููู ูุชูุฏุฑ ุชูุณุงู ุ','ุชุญุณ ุงูู ูุญุธูุธ ุจุงูุงุดุฎุงุต ุงูู ุญููู ุ','ุชุณุชุบู ููุช ูุฑุงุบู ุจุดูู ุ','ูุน ุงู ุถุฏ ููููุฉ ูุญุฏ ูุฏูู ู ุงุญุฏ ุ','ูู ุงุฎุฐูู ูุณุชุดูู ุงููุฌุงููู ููู ุชุซุจุช ููู ุงูู ุตุงุญู ุ','ูุบูู ุชูุงุญุธ ุฃู ุตูุชู ูุนุฌุจ ุงูุฌููุน ุฅูุง ุฃูุช ุ','ุงุฎุฑ ุฎูุงูู ุ','ุชุตุฑู ูุงุชุชุญููู ุ','ูู ููููู ุงููุฐุจ ูุงูุงุณุชูุฑุงุฑ ุจุงุฑุชูุงุจ ุงูุฃุฎุทุงุก ููุญุงููุฉ ููู ูุนุฏู ุงููุดู ุฃูู ูุฎุทุฆ ุ','ุงูุตู ุงุฎุฑ ุดู ูุณุฎุชู ุ','ุนูุฑู ุงูุชููุช ูู ุฃุญุฏ ุ','ูู ูุตูู ุฑุณุงูุฉ ุบูุฑ ูุชููุนุฉ ูู ุดุฎุต ูุฃุซุฑุช ููู ุ','โ-ูู ุงูุชููุช ุงูุนุตุง ุงูุณุญุฑูุฉ ูููู ูุงุญุฏ ูุงุฐุง ุณุชูุนู ุ','ุฌุงุจู ุทุงุฑู ุดุฎุต ุชูุฑู ุนูุฏู ุชุดุงุฑููู ููุง ุชููุนูู ุ','ุฃูููุฉ ููุช ุชุชููุงูุง ูุญููุชูุง ุ','ูู ุงูุชุนูุฏ ุนูู ุดุฎุต ูุงูุชุญุฏุซ ูุนู ุจุดูู ูููู ูุนุชุจุฑ ููุน ูู ุฃููุงุน ุงูุญุจ ุ','ูุณุจุฉ ุฌูุงู ุตูุชู ุ','ุตูุฉ ูุทูููุง ุนููู ุงูุดุฎุต ุงูููุถู ุ','ุดูู ูุฏูู ุจุงููุณุชูุจู ุงููุฑูุจ ุ','ุชุญุจ ุงููุฑุงุฆู ุ','ูููู ุชุชููู ุชููุจู ุจููุง ุ',
'ุฃุทูู ูุฏุฉ ูุถูุชูุง ุจุนูุฏ ุนู ุฃููู ุ','ูู ูุฌู ุนูุฏ ูููุงุฏู ุชุชููุน ูุฌูู ูุฏูุฉุ','ูุจุงู ุนููู ุงูุญุฒู ูู " ุตูุชู - ููุงูุญู','ููู ุชุดูู ููุณู ุจุนุฏ ุณูุชููุ','ูุด ูููููู ูู ููุง ุชุบูู ุ','ุนูุฏู ุญุณ ููุงูู ููุง ููุณูุฉุ','ููู ุชุชุตุฑู ูุน ุงูุดุฎุต ุงููุถููู ุ','ููู ูู ุฃุญูุงู ููุจูุ','ุญุงุฌุฉ ุชุดูู ููุณู ูุจุฏุน ูููุง ุ','ูุชู ุญุจูุชุ','ุดูุก ูู ู ุชุฐูุฑุชู ุชุจุชุณู ...','ุงูุนูุงูู ุงูุณุฑูู ุฏุงููุงู ุชููู ุญูููุ','ุตูุช ูุบูู ู ุชุญุจู','ูู ูุฌู ุนูุฏ ูููุงุฏู ุชุชููุน ูุฌูู ูุฏูุฉุ','ุงุฐุง ุงุญุฏ ุณุฃูู ุนู ุดูุก ู ุชุนุฑูู ุชููู ู ุงุนุฑู ููุง ุชุชููุณู ุ','ูุน ุงู ุถุฏ : ุงูููู ุงูุถู ุญู ูู ูุดุงูู ุงูุญูุงุฉุ','ูุณุงุญุฉ ูุงุฑุบุฉ (..............) ุงูุชุจ ุงู ุดูุก ุชุจูู','ุงุบุฑุจ ุงุณู ูุฑ ุนููู ุ','ุนูุฑู ูููุช ูููุณ ุงุญุฏ ุบูุฑ ุฌูุณูุ','ุงุฐุง ุบูุทุช ูุนุฑูุช ุงูู ุบูุทุงู ุชุญุจ ุชุนุชุฑู ููุง ุชุฌุญุฏุ','ูู ุนูุฏู ูููุณ ูุด ุงูุณูุงุฑุฉ ุงููู ุจุชุดุชุฑููุงุ','ูุด ุงุบุจู ุดูุก ุณููุชู ุ','ุดูุก ูู ุตุบุฑู ูุงุชุบูุฑ ูููุ','ูุด ููุน ุงูุฃููุงู ุงููู ุชุญุจ ุชุชุงุจุนูุ','ูุด ููุน ุงูุฃููุงู ุงููู ุชุญุจ ุชุชุงุจุนูุ','ุชุฌุงูู ุงุญุฏ ุนูู ุญุณุงุจ ูุตูุญุชู ุ','ุชุชูุจู ุงููุตูุญุฉ ูู ุงู ุดุฎุตุ','ูููู ูุงุณูู ูุนู ุงููุชุฑุฉ ูุฐู ุ','ูุชู ูุงุฒู ุชููู ูุง ุ','ุงูุซุฑ ุดูุก ุชุญุณ ุงูู ูุงุช ู ูุฌุชูุนูุงุ','ุชุคูู ุงู ูู "ุญูุจ ูู ุฃูู ูุธุฑุฉ" ููุง ูุง ุ.','ุชุคูู ุงู ูู "ุญูุจ ูู ุฃูู ูุธุฑุฉ" ููุง ูุง ุ.','ูู ุชุนุชูุฏ ุฃู ููุงูู ูู ูุฑุงูุจู ุจุดุบูุ','ุงุดูุงุก ุงุฐุง ุณููุชูุง ูุดุฎุต ุชุฏู ุนูู ุงูู ุชุญุจู ูุซูุฑ ุ','ุงุดูุงุก ุตุนุจ ุชุชูุจููุง ุจุณุฑุนู ุ','ุงูุชุจุงุณ ูุทููุ','ุฃูุซุฑ ุฌููุฉ ุฃุซุฑุช ุจู ูู ุญูุงุชูุ','ุนูุฏู ููุจูุง ูู ุดูุก ุ.',
'ุงูุซุฑ ููููู ุชุญุจูู ูุน ุจุนุถุ','ุฃุฌูู ุจูุช ุดุนุฑ ุณูุนุชู ...','ุณุจู ูุฑุงูุฏู ุดุนูุฑ ุฃูู ูู ุชุนุฏ ุชุนุฑู ููุณูุ','ุชุชููุน ููู ุงุญุฏ ุญุงูุฏ ุนููู ูููุฑูู ุ','ุฃุฌูู ุณูุฉ ูููุงุฏูุฉ ูุฑุช ุนููู ุ','ูู ูุฒุนุช/ู ูุตุฏูู/ู ููุงูู ูุงูู ุฏุฎู ูุด ุจุชุณูู/ููุ','ูุด ุชุญุณ ุงูู ุชุญุชุงุฌ ุงููุชุฑุฉ ูุงุฐู ุ','ูููู ุถุงุน ุนููุ','@ููุดู .. ุดุฎุต ุชุฎุงู ููู ุงุฐุง ุนุตุจ ...','ูููู ุนุงูู ูู ุฐููู ูุง ุชูุณุงู ููู ุฑูุนุชูุ','ุชุฎุชุงุฑ ุฃู ุชููู ุบุจู ุฃู ูุจูุญุ','ุงููููุณ ุงู ุงูุญุจ ุ','ุฃุฌูู ุจูุฏ ูู ูุงุฑุฉ ุขุณูุง ุจูุธุฑูุ','ูุง ุงูุฐู ูุดุบู ุจุงูู ูู ุงููุชุฑุฉ ุงูุญุงููุฉุ','ุงุญูุฑ ุงููุงุณ ูู ูู ...','ููู ูููู ุงูุณุนุงุฏู ุจุฑุงููุ','ุงุดูุงุก ุชูุชุฎุฑ ุงูู ู ุณููุชูุง ุ','ุชุฒุนูู ุงูุฏููุง ููุฑุถูู ุ','ูุด ุงูุญุจ ุจูุธุฑูุ','ุงูุถู ูุฏูู ูููู ุชูุงุณุจูุ','ูู ูู ุญุณุงุจู ุงูุจููู ุ','ูููุฉ ูุดุฎุต ุฃุณุนุฏู ุฑุบู ุญุฒูู ูู ูููู ูู ุงูุฃูุงู ุ','ุนูุฑู ุงูุชููุช ูู ุฃุญุฏ ุ!','ูุง ุงูุณูุก ูู ูุฐู ุงูุญูุงุฉ ุ','ุบููุฉ ุนูุฏู ูุนุงูุง ุฐูุฑูุงุช๐ต๐ป','/','ุฃูุถู ุตูุฉ ุชุญุจู ุจููุณูุ','ุงูุซุฑ ููุช ุชุญุจ ุชูุงู ููู ...','ุฃุทูู ูุฏุฉ ููุช ูููุง ูู ุณุงุนุฉุ','ุฃุตุนุจ ูุฑุงุฑ ูููู ุชุชุฎุฐู ุ','ุฃูุถู ุตูุฉ ุชุญุจู ุจููุณูุ','ุงูุซุฑ ููุช ุชุญุจ ุชูุงู ููู ...','ุฃูุช ูุญุจูุจ ุจูู ุงููุงุณุ ููุงูุฑููุ','ุฅุญุณุงุณู ูู ูุงููุญุธุฉุ','ุงุฎุฑ ุดูุก ุงููุชู ุ','ุชุดูู ุงูุบูุฑู ุงูุงููู ุงู ุญุจุ','ุงุฐูุฑ ูููู ูุงุชูุณุงู ุจุนูุฑูุ','ุงูุซุฑ ูุดุงููู ุจุณุจุจ ุ','ุงูู ูุงุชุตุญู ูู ุงูููู ููู ุชููููุ','ุขุฎุฑ ูุฑุฉ ุถุญูุช ูู ูู ููุจูุ','ูู ุงูุฌูุณูุฉ ุญุณุจ ููุงูุญู ูุด ุจุชููู ุฌูุณูุชูุ','ุงูุซุฑ ุดูุก ูุฑูุน ุถุบุทู','ุงุฐูุฑ ูููู ูุงุชูุณุงู ุจุนูุฑูุ','ูู ูุงููุง ูู  ุชูุงูู ุตูู ูุงุญุฏ ููุท ูู ุงูุทุนุงู ููุฏุฉ ุดูุฑ .',
'ููู ุชุดูู ุงูุฌูู ุฐุงุ','ุฑุฏุฉ ูุนูู ูู ูุฒุญ ูุนู ุดุฎุต ู ุชุนุฑูู ุ','ุงุญูุฑ ุงููุงุณ ูู ูู ...','ุชุญุจ ุงุจูู ููุง ุงูู','ุขุฎุฑ ูููู ูุณูุณู ูุงูุชูููู๐ฅุ','ุฃูุจุญ ุงููุจุญูู ูู ุงูุนูุงูุฉ: ุงูุบุฏุฑ ุฃู ุงูุฅููุงู๐คท๐ผุ','ูููุฉ ูุฃูุฑุจ ุดุฎุต ูููุจู๐คุ','ุญุท@ููุดู ูุดุฎุต ููููู "ุญุฑูุชู ูุงููุง ุฏุงุนู"๐ผ!','ุงุฐุง ุฌุงู ุฎุจุฑ ููุฑุญ ุงูู ูุงุญุฏ ุชุนููู ููู ููู๐๐ฝุ','ุทุจุน ูููู ูุฎููู ุชูุฑู ุดุฎุต ุญุชู ูู ููุช ุชูุญุจู๐๐ปโโ๏ธุ','ุงูุถู ุงูุงู ุงูุงุณุจูุน ุนูุฏู๐ุ','ูููููู ุงู ุงูุญูุงุฉ ุฏุฑูุณ ุ ูุงูู ุฃููู ุฏุฑุณ ุชุนููุชู ูู ุงูุญูุงุฉ๐ุ','ุชุงุฑูุฎ ูู ุชูุณุงู๐ุ','ุชุญุจ ุงูุตูู ูุงูุง ุงูุดุชุงุกโ๏ธโ๏ธุ','ุดุฎุต ุชุญุจ ุชุณุชูุฒู๐ุ','ุดูู ููุงุฏููู ูุงูุช ุตุบูุฑ (ุนูุงุฑุชู)๐ผ๐ปุ','ุนูู ููููู/ุฌ ููุง ููุจ ูุญุจู/ุฌโค๏ธุ','ุงูู ุณูุฑู ูู ููู ุฑุญ ุชูููโ๏ธุ','ูู ุนุฏุฏ ุงููู ูุนุทููู ุจููู๐นุ','ููุนูุฉ ูู ุงูุฃุดุฎุงุต ุชุชุฌูุจูู ูู ุญูุงุชูโุ','ุดุงุฑููุง ุตูุฑุฉ ุงู ููุฏูู ูู ุชุตููุฑูุ๐ธ','ูู ูู ุนุดุฑู ุชุนุทู ุญุธู๐ฉุ','ุงูุซุฑ ุจุฑูุงูุฌ ุชูุงุตู ุงุฌุชูุงุนู ุชุญุจู๐ุ','ูู ุงู ุฏููู ุงูุช๐ุ','ุงูุซุฑ ุฏููู ูุฏู ุชุณุงูุฑ ููุง๐ุ','ููููุฉ "ููุจุฑ ูููุณู" ูู ุชุคูู ุจุตุญุชูุง๐ง๐ผุ','ุชุนุชูุฏ ููู ุฃุญุฏ ูุฑุงูุจู๐ฉ๐ผโ๐ปุ','ูู ุจูุฏู ุชุบูุฑ ุงูุฒูู ุ ุชูุฏูู ููุง ุชุฑุฌุนู๐ฐุ','ูุดุฑูุจู ุงูููุถู๐นุ','โูู ุจูุตู ุขุฎุฑ ุงูุชุจุงุณ ูุณุฎุชูุ๐ญ','ูู ูุฒูู/ุฌ ุทููู/ุฌุ๐','ูู ูุงู ุนูุฑู/ุฌ ูุจู ูจ ุณููู๐ุ','ุฏููู ูุฏูุช ุงูู ุณุงูุฑุช ููุง๐ุ','ูู ูุงูู ูู ูฃ ุฃูููุงุช ุฑุงุญ ุชุชุญูู ุนุงูุณุฑูุน ุดูู ุชููู๐งโโ๏ธุ','โ- ูุณุจุฉ ุงุญุชูุงุฌู ููุนุฒูุฉ ูู 10๐ุ','ุดุฎุต ุชุญุจู ุญุธุฑู ุจุฏูู ุณุจุจ ูุงุถุญุ ุฑุฏุฉ ูุนูู๐งุ','ูุจุฏุฃ ูู ุงูุญูุงุฉ ุชุนุชูุฏ ุนููู ุฏุงุฆูุง๐ฏุ',
}  
Dev_Rio(msg.chat_id_, msg.id_, 1, ''..stormTeam[math.random(#stormTeam)]..'' , 1, 'md')  
return false
end
end
--     Source Storm     --
if text == 'ุงูุงูุนุงุจ' and ChCheck(msg) or text == 'ุงูุนุงุจ' and ChCheck(msg) or text == 'ุงููุนุจู' and ChCheck(msg) or text == 'โคฝ ุงูุงูุนุงุจ โ' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Games'..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1,[[
โ๏ธูุงุฆูุฉ ุงูุนุงุจ ุงููุฌููุนู โคฝ โค
โ โ โ โ โ โ โ โ โ
โ๏ธูุนุจุฉ ุงูุชุฎููู โคฝ ุฎูู
โ๏ธูุนุจุฉ ุงูุงูุซูู โคฝ ุงูุซูู
โ๏ธูุนุจุฉ ุงูุนูุณ โคฝ ุงูุนูุณ
โ๏ธูุนุจุฉ ุงูุงุณุฆูู โคฝ ุงุณุฆูู
โ๏ธูุนุจุฉ ุงูุฑูููุช โคฝ ุฑูููุช
โ๏ธูุนุจุฉ ุงูุญุฒูุฑู โคฝ ุญุฒูุฑู
โ๏ธูุนุจุฉ ุงูุชุฑุชูุจ โคฝ ุชุฑุชูุจ
โ๏ธูุนุจุฉ ุงููุนุงูู โคฝ ูุนุงูู
โ๏ธูุนุจุฉ ุงูุชููุช โคฝ ูุช ุชููุช
โ๏ธูุนุจุฉ ุงููุฎุชูู โคฝ ุงููุฎุชูู
โ๏ธูุนุจุฉ ุงูุณูุงููุงุช โคฝ ุณูุงููุงุช
โ๏ธูุนุจุฉ ุงููุญูุจุณ โคฝ ุงููุญูุจุณ
โ๏ธูุนุจุฉ ุงูุฑูุงุถูุงุช โคฝ ุฑูุงุถูุงุช
โ๏ธูุนุจุฉ ุงูุงููููุฒูู โคฝ ุงููููุฒูู
โ โ โ โ โ โ โ โ โ
โ๏ธููุงุทู โข ุจูุน ููุงุทู
โ โ โ โ โ โ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]], 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุนุฐุฑุง ุงูุงูุนุงุจ ูุนุทูู ูู ุงููุฌููุนู', 1, 'md')
end
end
--     Source Storm     --
if text == 'ุจูุน ููุงุทู' and ChCheck(msg) then
if tonumber((DevRio:get(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_) or 0)) == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูู ุชุฑุจุญ ุงู ููุทู\nโ๏ธุงุฑุณู โคฝ ุงูุงูุนุงุจ ููุนุจ', 1, 'md')
else
DevRio0 = (DevRio:get(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_) * 50)
DevRio:incrby(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_,DevRio0)
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุชู ุจูุน '..(DevRio:get(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_))..' ูู ููุงุทู\nโ๏ธูู ููุทู ุชุณุงูู 50 ุฑุณุงูู', 'md')
DevRio:del(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_)
end
end
--     Source Storm     --
if text == 'ุฑูุน ุงููุดุฑููู' and ChCheck(msg) or text == 'ุฑูุน ุงูุงุฏูููู' and ChCheck(msg) then  
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 200},function(arg,rio) 
local num = 0
local admins = rio.members_  
for i=0 , #admins do   
if rio.members_[i].bot_info_ == false and rio.members_[i].status_.ID == "ChatMemberStatusEditor" then
DevRio:sadd(storm..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)   
num = num + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,dp) 
if dp.first_name_ == false then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)   
end
end,nil)   
else
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)   
end 
if rio.members_[i].status_.ID == "ChatMemberStatusCreator" then  
Manager_id = admins[i].user_id_  
DevRio:sadd(storm..'Rio:BasicConstructor:'..msg.chat_id_,Manager_id)  
DevRio:sadd(storm..'Rio:RioConstructor:'..msg.chat_id_,Manager_id)   
end  
end  
if num == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุง ููุฌุฏ ุงุฏูููู ููุชู ุฑูุนูู\nโ๏ธุชู ุฑูุน ูุงูู ุงููุฌููุนู", 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุฑูุน '..num..' ูู ุงูุงุฏูููู \nโ๏ธุชู ุฑูุน ูุงูู ุงููุฌููุนู', 1, 'md')
end
end,nil) 
end
--     Source Storm     --
if text == 'ุบุงุฏุฑ' and SudoBot(msg) and ChCheck(msg) then
if DevRio:get(storm.."Rio:Left:Bot"..storm) then
Dev_Rio(msg.chat_id_,msg.id_, 1, "โ๏ธุงููุบุงุฏุฑู ูุนุทูู ูู ูุจู ุงููุทูุฑ ุงูุงุณุงุณู", 1, 'md')
return false  
end
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ูุบุงุฏุฑุฉ ุงููุฌููุนู \nโ๏ธุชู ุญุฐู ุฌููุน ุจูุงูุงุชูุง ', 1, 'md')
ChatLeave(msg.chat_id_, storm)
DevRio:srem(storm.."Rio:Groups",msg.chat_id_)
end
--     Source Storm     --
if text ==('ูููุนู') and ChCheck(msg) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
rtpa = 'ุงูููุดุฆ'
elseif da.status_.ID == "ChatMemberStatusEditor" then
rtpa = 'ุงูุงุฏูู'
elseif da.status_.ID == "ChatMemberStatusMember" then
rtpa = 'ุนุถู'
end
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุนู โคฝ '..rtpa, 1, 'md')
end,nil)
end
--     Source Storm     --
if text == "ูุนูููุงุชู" and ChCheck(msg) then
function get_me(extra,result,success)
local msguser = tonumber(DevRio:get(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_))
local user_msgs = DevRio:get(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
local cont = (tonumber(DevRio:get(storm..'Rio:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_)) or 0)
local user_nkt = tonumber(DevRio:get(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_) or 0)
if result.username_ then username = '@'..result.username_ else username = 'ูุง ููุฌุฏ' end
if result.last_name_ then lastname = result.last_name_ else lastname = '' end
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงุณูู โคฝ โจ ['..result.first_name_..'] โฉ\nโ๏ธูุนุฑูู โคฝ โจ ['..username..'] โฉ\nโ๏ธุงูุฏูู โคฝ โจ `'..result.id_..'` โฉ\nโ๏ธููุงุทู โคฝ โจ '..user_nkt..' โฉ\nโ๏ธุฑุณุงุฆูู โคฝ โจ '..user_msgs..' โฉ\nโ๏ธุฌูุงุชู โคฝ โจ '..cont..' โฉ\nโ๏ธุชูุงุนูู โคฝ '..formsgs(msguser)..'\nโ๏ธุฑุชุจุชู โคฝ '..IdRank(msg.sender_user_id_, msg.chat_id_), 1, 'md')
end
getUser(msg.sender_user_id_,get_me)
end
end
--     Source Storm     --
if text == "ุชุนููู ููุงุฉ ุงูุงุดุชุฑุงู" or text == "ุชุบููุฑ ููุงุฉ ุงูุงุดุชุฑุงู" or text == "ุชุนููู ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู" or text == "ูุถุน ููุงุฉ ุงูุงุดุชุฑุงู" or text == "โคฝ ุชุนููู ููุงุฉ ุงูุงุดุชุฑุงู โ" then
if not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท ', 1, 'md')
else
DevRio:setex(storm..'DevRio4'..msg.sender_user_id_,360,true)
send(msg.chat_id_, msg.id_, 'โ๏ธุงุฑุณู ูู ูุนุฑู ููุงุฉ ุงูุงุดุชุฑุงู ุงูุงู')
end
return false  
end
if text == "ุชูุนูู ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู" or text == "โคฝ  ุชูุนูู ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู โ" then  
if not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท ', 1, 'md')
else
if DevRio:get(storm..'Rio:ChId') then
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..DevRio:get(storm.."Rio:ChId"))
local GetInfo = JSON.decode(Check)
send(msg.chat_id_, msg.id_,"โ๏ธุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู ููุนู \nโ๏ธุนูู ุงูููุงุฉ โคฝ [@"..GetInfo.result.username.."]")
else
DevRio:setex(storm..'DevRio4'..msg.sender_user_id_,360,true)
send(msg.chat_id_, msg.id_,"โ๏ธูุงุชูุฌุฏ ููุงุฉ ูุชูุนูู ุงูุงุดุชุฑุงู\nโ๏ธุงุฑุณู ูู ูุนุฑู ููุงุฉ ุงูุงุดุชุฑุงู ุงูุงู")
end
end
return false  
end
if text == "ุชุนุทูู ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู" or text == "โคฝ  ุชุนุทูู ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู โ" then  
if not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท ', 1, 'md')
else
DevRio:del(storm..'Rio:ChId')
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end
return false  
end
if text == "ุญุฐู ููุงุฉ ุงูุงุดุชุฑุงู" or text == "ุญุฐู ููุงู ุงูุงุดุชุฑุงู" or text == "โคฝ ุญุฐู ููุงุฉ ุงูุงุดุชุฑุงู โ" then
if not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท ', 1, 'md')
else
DevRio:del(storm..'Rio:ChId')
Dev_Rio(msg.chat_id_, msg.id_, 1,"โ๏ธุชู ุญุฐู ููุงุฉ ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู", 1, 'md') 
end
end
if Sudo(msg) then
if text == 'ุฌูุจ ููุงุฉ ุงูุงุดุชุฑุงู' or text == 'ููุงุฉ ุงูุงุดุชุฑุงู' or text == 'ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู' or text == 'ููุงุฉ ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู' or text == 'โคฝ ููุงุฉ ุงูุงุดุชุฑุงู โ' then
if DevRio:get(storm..'Rio:ChId') then
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..DevRio:get(storm.."Rio:ChId"))
local GetInfo = JSON.decode(Check)
send(msg.chat_id_, msg.id_, "โ๏ธููุงุฉ ุงูุงุดุชุฑุงู โคฝ [@"..GetInfo.result.username.."]")
else
send(msg.chat_id_, msg.id_, "โ๏ธูุงุชูุฌุฏ ููุงุฉ ูู ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู")
end
return false  
end end
--     Source Storm     --
if SudoBot(msg) then
if text == 'ุงุฐุงุนู ูููู ุจุงูุชูุฌูู' and tonumber(msg.reply_to_message_id_) > 0 then
function stormTeam(extra,result,success)
if DevRio:get(storm.."Rio:Send:Bot"..storm) and not SecondSudo(msg) then 
send(msg.chat_id_, msg.id_,"โ๏ธุงูุงุฐุงุนู ูุนุทูู ูู ูุจู ุงููุทูุฑ ุงูุงุณุงุณู")
return false
end
local GpList = DevRio:smembers(storm.."Rio:Groups")
for k,v in pairs(GpList) do
tdcli_function({ID="ForwardMessages", chat_id_ = v, from_chat_id_ = msg.chat_id_, message_ids_ = {[0] = result.id_}, disable_notification_ = 0, from_background_ = 1},function(a,t) end,nil) 
end
local PvList = DevRio:smembers(storm.."Rio:Users")
for k,v in pairs(PvList) do
tdcli_function({ID="ForwardMessages", chat_id_ = v, from_chat_id_ = msg.chat_id_, message_ids_ = {[0] = result.id_}, disable_notification_ = 0, from_background_ = 1},function(a,t) end,nil) 
end
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงุฐุงุนุฉ ุฑุณุงูุชู ุจุงูุชูุฌูู \nโ๏ธโูู โคฝ โจ '..#GpList..' โฉ ูุฌููุนู \nโ๏ธูุงูู โคฝ โจ '..#PvList..' โฉ ูุดุชุฑู \n โ', 1, 'md')
end
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),stormTeam)
end
end
--     Source Storm     --
if text == "ูุดุงูุฏู ุงูููุดูุฑ" and ChCheck(msg) or text == "ูุดุงูุฏุงุช ุงูููุดูุฑ" and ChCheck(msg) or text == "ุนุฏุฏ ุงููุดุงูุฏุงุช" and ChCheck(msg) then
DevRio:set(storm..'Rio:viewget'..msg.sender_user_id_,true)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุญุณูุง ูู ุจุงุนุงุฏุฉ ุชูุฌูู ููููุดูุฑ ุงูุฐู ุชุฑูุฏูู ุญุณุงุจ ูุดุงูุฏุงุชู', 1, 'md')
end
--     Source Storm     --
if text == 'ุงูุณูุฑุณ' or text == 'ุณูุฑุณ' or text == 'ูุงุณูุฑุณ' or text == 'ูุง ุณูุฑุณ' then
local Text =[[
 ูุฑุญุจุง ุจู ูู ุณูุฑุณ ุณุชูุฑูโโฏ
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'ููุงุฉ ุงูุณูุฑุณ', url="t.me/So_ST0RM"},
},
{
{text = '๐ฉ๐ถ๐ซ๐', url="t.me/Xx_BoDa_UXB"},
{rext = '๐จ๐ฉ๐ถ๐จ๐ณ๐ด๐จ๐ฎ๐ซ', url ="t.me/A_B_O_2"},
{text = '๐จ๐ฏ๐ด๐ฌ๐ซ', url="t.me/A7maaaaaaaaaaaaaaa"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == "ุงุจูุงููุฌุฏ" then
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ = 1871165209,},function(arg,result) 
local function taha(extra, taha, success)
if taha.photos_[0] then
local Name = ' ๐ฆ๐จ๐ฅ๐๐ ๐๐๐ฉ๐๐๐ข๐ฃ๐๐ฅ\n['..result.first_name_..'](t.me/A_B_O_2)\n'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '  โจ '..result.first_name_..'  โฉ ',url="t.me/A_B_O_2"},
},
{
{text = '๐๐ ๐พ๐๐ผ๐๐๐๐๐  ', url="t.me/So_ST0RM"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Name)..'&photo='..taha.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
 end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = 1871165209, offset_ = 0, limit_ = 1 }, taha, nil)
end,nil)
end
end
if text == "ุจูุฏุง" then
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ = 1962004752,},function(arg,result) 
local function taha(extra, taha, success)
if taha.photos_[0] then
local Name = ' ๐ฆ๐จ๐ฅ๐๐ ๐๐๐ฉ๐๐๐ข๐ฃ๐๐ฅ\n['..result.first_name_..'](t.me/Xx_BoDa_UXB)\n'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '  โจ '..result.first_name_..'  โฉ ',url="t.me/Xx_BoDa_UXB"},
},
{
{text = '๐๐ ๐พ๐๐ผ๐๐๐๐๐  ', url="t.me/So_ST0RM"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Name)..'&photo='..taha.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
 end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = 1962004752, offset_ = 0, limit_ = 1 }, taha, nil)
end,nil)
end
end
if text == "ุงุญูุฏ" then
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ = 1966856869,},function(arg,result) 
local function taha(extra, taha, success)
if taha.photos_[0] then
local Name = ' ๐ฆ๐จ๐ฅ๐๐ ๐๐๐ฉ๐๐๐ข๐ฃ๐๐ฅ\n['..result.first_name_..'](t.me/A7maaaaaaaaaaaaaaa)\n'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '  โจ '..result.first_name_..'  โฉ ',url="t.me/A7maaaaaaaaaaaaaaa"},
},
{
{text = '๐๐ ๐พ๐๐ผ๐๐๐๐๐  ', url="t.me/So_ST0RM"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Name)..'&photo='..taha.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
 end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = 1966856869, offset_ = 0, limit_ = 1 }, taha, nil)
end,nil)
end
end
if text == 'ุณูุฑุณ ุณุชูุฑู' or text == 'ุณุชูุฑู' then  
local Text = [[  
ุงูุถู ุณูุฑุณ ูู ุงูุชููุฌุฑุงู
keyboard = {}   
keyboard.inline_keyboard = {  
{{text = 'TEAM STORM',url="t.me/So_ST0RM"}},  

}  
local msg_id = msg.id_/2097152/0.5  
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/HASNAA828&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == 'ุฑูุน ุฎูุฒูุฑ' or text == 'ุฑูุน ุฎูุฒูุฑ' or text == 'ุฑูุน ุฎูุฒูุฑ' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู ุฎูุฒูุฑ ูู ุงูููุน
โช ุงูุงูู ูู ุงูุงู ุฎูุฒูุฑ ุงูุฑูู ๐น๐น
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ููุจ' or text == 'ุฑูุน ููุจ' or text == 'ุฑูุน ููุจ' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู ูู ูุฒุฑุนู ุงูููุงุจ
โช ุญุฏ ูุฏููู ุนุถูู ูุงูุง ๐ฆด๐
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุจููุจู' or text == 'ุฑูุน ุจููุจู' or text == 'ุฑูุน ููุจู' then
Text = [[=
โช ุชู ุฑูุน ุงูุนุถู ุฏุงุฎู ููุจู. 
โช ูู ุงูุงู ูู ููุจู ุฎูู ุจุงูู ูููุณุฑู ๐๐๐
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุดุงุฐ' or text == 'ุฑูุน ุดุงุฐ' or text == 'ุฑูุน ุดุงุฐ' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู ุจูุฌุงุญ ูู ุงูุงู ูู ูุงุฏู ุงูุดูุงุฐ ๐ณโ๐
โช ููู ูุจุนุฏ ุนู ุงูุดุงุฐ ุฏู ๐๐
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุชูุฒูู ุดุงุฐ' or text == 'ุชูุฒูู ุดุงุฐ' or text == 'ุชูุฒูู ุดุงุฐ' then
Text = [[
ุชู ุฑูุน ุงูุนุถู ุจูุฌุงุญ ูู ุงูุงู ูู ูุงุฏู ุงูุดูุงุฐ ๐ณโ๐
ููู ูุจุนุฏ ุนู ุงูุดุงุฐ ุฏู ๐๐
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุญูุงุฑ' or text == 'ุฑูุน ุญูุงุฑ' or text == 'ุฑูุน ุญูุงุฑ' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู ุญูุงุฑ ุจูุฌุงุญ
โช ูู ุงูุงู ุญูุงุฑ ุงูุฑูู ๐น๐น
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุฒูุงุฌ' or text == 'ุฒูุงุฌ' or text == 'ุฑูุน ุฒูุฌุชู' then
Text = [[
โช ุชู ุฒูุงุฌู ุจูุนุถู ููุง ุงูุงู ุญูุงูู โค๏ธ
โช ูุงูุง ุฑูุญู ุงุนููู ูุงุญุฏ ุจุณ ูุด ูู ุงูุฑูู ๐น๐น๐
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุทูุงู' or text == 'ุทูุงู' or text == 'ุทูุงู' then
Text = [[
โช ุชู ุทูุงู ุงูุฎุงููู ููุง 
โช ูุทููู ุชุนุงูู ูุชุฌูุฒ ุงูุง ูุงูุช ๐น๐น
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุฑูุงุตู' or text == 'ุฑูุน ุฑูุงุตู' or text == 'ุฑูุน ุฑูุงุตู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุฑูุงุตู ุจูุฌุงุญโค๏ธ 
โช ููุง ุชุนุงูู ูุงุฑูุงุตู ูููุทู ุจุงูุฏููุงุฑุงุช 
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ูุชูู' or text == 'ุฑูุน ูุชูู' or text == 'ุฑูุน ูุชูู' then
Text = [[
โช ุงูุนุถู ูุชูู ุจุงููุนู 
โช ูุงููู ุจููุฑุงุด ุนูููุง ุฎุฏ ุจุงูู ๐๐
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุญููุงู' or text == 'ุฑูุน ุญููุงู' or text == 'ุฑูุน ุญููุงู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุญููุงู ูุฑุฒ ุงูู 
โช ููุง ุชุนุงูู ุฌูููุฉ ุงูุญููุงูุงุช ูุณุชููุงู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ูุงุดู' or text == 'ุฑูุน ูุงุดู' or text == 'ุฑูุน ูุงุดู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุงููุงุดู ุจูุฌุงุญ 
โช ููุง ุชุนุงูู ูุงูุงุดู ูุณูุจ ุงููุชุงุจ ูุฏู ูุฏู ูุชุณูุท
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุงุจูู' or text == 'ุฑูุน ุงุจูู' or text == 'ุฑูุน ุงุจูู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุงุจู ุจูุช ุจูุชู 
โช ุชุนุงูู ูุงุจูู ูุงุชููุง ุดุงู ุงู ุญุณู 
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุฏูุฑู' or text == 'ุฑูุน ุฏูุฑู' or text == 'ุฑูุน ุฏูุฑู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุฏูุฑู ูุงุจู ุนูุงูู 
โช ููุง ุชุนุงูู ูุงุฏูุฑู ุงุฏู ุงุจููุง ุจููุงุฏู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ูุทุชู' or text == 'ุฑูุน ูุทุชู' or text == 'ุฑูุน ูุทุชู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ูุทุชู ููู ุนููุง 
โช ููุง ุชุนุงูู ูุงูุทุชู ูุดุชุฑู ุชููู ูููู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุจูุชู' or text == 'ุฑูุน ุจูุชู' or text == 'ุฑูุน ุจูุชู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุจูุชู ููู ุนููุง 
โช ุชุน ูุจูุชู ุดููู ุจุงุจุง ุนุงูุฒ ุงู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุฎุงูู' or text == 'ุฑูุน ุฎุงูู' or text == 'ุฑูุน ุฎุงูู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุงูุฎุงูู ูููู ุงูุงุตู 
โช ุชุนุงูู ุจููุงุฏู ุนููู ูุงุฎุงูู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุฎุงููู' or text == 'ุฑูุน ุฎุงููู' or text == 'ุฑูุน ุฎุงููู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุงูุฎุงููู ุจูุฌุงุญ 
โช ุชุนุงูู ูุงุฎุงููู ูุถุญุชููุง ููููุชู ุนูููุง ุงููุงุณ
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุนุจูุท' or text == 'ุฑูุน ุนุจูุท' or text == 'ุฑูุน ุนุจูุท' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุนุจูุท ูุงูุจู 
โช ูุงุฑุจ ุงุณุชุฑูุง ูุนุงู ุงุตู ูู ุนุจูุท
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ูุชุฎุฒูู' or text == 'ุฑูุน ูุชุฎุฒูู' or text == 'ุฑูุน ูุชุฎุฒูู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุงููุชุฎุฒูู ุงูุญุฒูู 
โช ููุง ุชุนุงูู ูุงูุชุฎุฒูู ูุณุชููุฏ ูู ุฎุจุฑุชู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ูุชุฎุฒูู' or text == 'ุฑูุน ูุชุฎุฒูู' or text == 'ุฑูุน ูุชุฎุฒูู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุงููุชุฎุฒูู ุงูุญุฒูู 
โช ููุง ุชุนุงูู ูุงูุชุฎุฒูู ูุณุชููุฏ ูู ุฎุจุฑุชู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ูุชูุญุฏ' or text == 'ุฑูุน ูุชูุญุฏ' or text == 'ุฑูุน ูุชูุญุฏ' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุงูู ูุงุฆูู ุงููุชูุญุฏูู ูุงููุฑุถู ุงูููุณููู
โช ุฑุงุญ ูุฌุจูู ุฏูุชูุฑ ููุณุงูู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุจูุฑู' or text == 'ุฑูุน ุจูุฑู' or text == 'ุฑูุน ุจูุฑู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุงูุจูุฑู ุงูุญููุจู 
โช ููุง ุชุนุงูู ูุงุจูุฑู ุจุฏูุง ูุจู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุบุจู' or text == 'ุฑูุน ุบุจู' or text == 'ุฑูุน ุบุจู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุบุจู ูู ุงุบุจูุงุก ุงูุฌุฑูุจ 
โช ูููููู ููุทูุง ุจุณูุงุชู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุบุจู' or text == 'ุฑูุน ุบุจู' or text == 'ุฑูุน ุบุจู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุบุจู ูู ุงุบุจูุงุก ุงูุฌุฑูุจ 
โช ูููููู ููุทูุง ุจุณูุงุชู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุนุฑู' or text == 'ุฑูุน ุนุฑู' or text == 'ุฑูุน ุนุฑู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุนุฑู ุงูุฌุฑูุจ 
โช ูุด ุนูุจ ุงูุง ุชููู ุนุฑู ูุฏู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ูุฑุฏ' or text == 'ุฑูุน ูุฑุฏ' or text == 'ุฑูุน ูุฑุฏ' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ุงููุฑุฏ ุงููุณูุงู 
โช ุญุฏ ูุดููู ููุฒู ุจุณุฑุนู
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ูุฑุณู' or text == 'ุฑูุน ูุฑุณู' or text == 'ุฑูุน ูุฑุณู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู  ูุฑุณู ุจูุฌุงุญ 
โช ูููููููููููู ุตุงุงุงุฑูุฎ ูุงูุงุณ
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ุนูู' or text == 'ุฑูุน ุนูู' or text == 'ุฑูุน ุนูู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู ุจูุงุฏู 
ุงูุนููููู ุณุจูุฑุช ุงููุง ุจู ๐น๐น
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ููุฑูู' or text == 'ุฑูุน ููุฑูู' or text == 'ุฑูุน ููุฑูู' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู ููุฑูู 
ุงูุงู ูู ุฌุณูู ุตุงุฑูุฎ ๐คค๐น โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--     By Developer STORM     --
if text == 'ุฑูุน ููุงุช' or text == 'ุฑูุน ููุงุช' or text == 'ุฑูุน ููุงุช' then
Text = [[
โช ุชู ุฑูุน ุงูุนุถู ููุงุช ูู ุงูุงู ุฌุณูู 
ูุนุถู ูููุฑู ๐๐น
โ
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
if text == 'ุญุตู' then
local Text = [[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'ใ๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  ใ', url="t.me/So_ST0RM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendvideo?chat_id=' .. msg.chat_id_ .. '&video=https://t.me/ahmedstorm/3&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == 'ุงูุง ุฌูุช' then
local Text = [[
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = ' ใ๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  ใ', url="t.me/So_ST0RM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendsticker?chat_id=' .. msg.chat_id_ .. '&sticker=https://t.me/ahmedstorm/4&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Storm     --
if ChatType == 'sp' or ChatType == 'gp'  then
if text == "ุงุทุฑุฏูู" and ChCheck(msg) or text == "ุงุฏูุฑูู" and ChCheck(msg) then
if DevRio:get(storm.."Rio:Kick:Me"..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุนุฐุฑุง ูุฐู ุงูุฎุงุตูู ูุนุทูู ', 1, 'md')
return false
end
DevRio:set(storm..'yes'..msg.sender_user_id_, 'delyes')
DevRio:set(storm..'no'..msg.sender_user_id_, 'delno')
local Text = 'โ๏ธูู ุงูุช ูุชุฃูุฏ ูู ุงููุบุงุฏุฑู'
keyboard = {} 
keyboard.inline_keyboard = {{{text="ูุนู",callback_data="/delyes"},{text="ูุง",callback_data="/delno"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
--     Source Storm     --
if text == 'ุชุนุทูู ุงุทุฑุฏูู' and Manager(msg) and ChCheck(msg) then
DevRio:set(storm.."Rio:Kick:Me"..msg.chat_id_, true)
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุฑ ุงุทุฑุฏูู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end
if text == 'ุชูุนูู ุงุทุฑุฏูู' and Manager(msg) and ChCheck(msg) then
DevRio:del(storm.."Rio:Kick:Me"..msg.chat_id_)
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุฑ ุงุทุฑุฏูู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end
--     Source Storm     --
if text == "ูุฒููู" and ChCheck(msg) then
if DevRio:get(storm.."Rio:Del:Me"..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุนุฐุฑุง ูุฐู ุงูุฎุงุตูู ูุนุทูู ', 1, 'md')
return false
end
DevRio:set(storm..'yesdel'..msg.sender_user_id_, 'delyes')
DevRio:set(storm..'nodel'..msg.sender_user_id_, 'delno')
local Text = 'โ๏ธูู ุงูุช ูุชุฃูุฏ ูู ุชูุฒููู'
keyboard = {} 
keyboard.inline_keyboard = {{{text="ูุนู",callback_data="/yesdel"},{text="ูุง",callback_data="/nodel"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
--     Source Storm     --
if text == 'ุชุนุทูู ูุฒููู' and BasicConstructor(msg) and ChCheck(msg) then
DevRio:set(storm.."Rio:Del:Me"..msg.chat_id_, true)
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุฑ ูุฒููู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end
if text == 'ุชูุนูู ูุฒููู' and BasicConstructor(msg) and ChCheck(msg) then
DevRio:del(storm.."Rio:Del:Me"..msg.chat_id_)
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุฑ ูุฒููู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end
--     Source Storm     --
if text and (text == 'ุชูุนูู ุงูุชุงู' or text == 'ุชูุนูู ุงูุชุงู ูููู' or text == 'ุชูุนูู ุชุงู ูููู') and Admin(msg) and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุฑ ุชุงู ูููู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Lock:TagAll'..msg.chat_id_)
end
if text and (text == 'ุชุนุทูู ุงูุชุงู' or text == 'ุชุนุทูู ุงูุชุงู ูููู' or text == 'ุชุนุทูู ุชุงู ูููู') and Admin(msg) and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุฑ ุชุงู ูููู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Lock:TagAll'..msg.chat_id_,true)
end
if Admin(msg) then
if text == "ุชุงู ูููู" and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:TagAll'..msg.chat_id_) then
function TagAll(dp1,dp2)
local text = "โ๏ธููููู ูุงูุฑุจุน \nโ โ โ โ โ โ โ โ โ\n"
i = 0
for k, v in pairs(dp2.members_) do
i = i + 1
if DevRio:get(storm..'Save:UserName'..v.user_id_) then
text = text..i.."~ : [@"..DevRio:get(storm..'Save:UserName'..v.user_id_).."]\n"
else
text = text..i.."~ : "..v.user_id_.."\n"
end
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, 'md')
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID, offset_ = 0,limit_ = 200000},TagAll,nil)
end
end
--     Source Storm     --
if text and text:match("^ููููู (.*)$") and ChCheck(msg) then
local txt = {string.match(text, "^(ููููู) (.*)$")}
if not DevRio:get(storm..'Rio:Lock:TagAll'..msg.chat_id_) then
function TagAll(dp1,dp2)
local text = "โ๏ธ"..txt[2].." \nโ โ โ โ โ โ โ โ โ\n"
i = 0
for k, v in pairs(dp2.members_) do
i = i + 1
if DevRio:get(storm..'Save:UserName'..v.user_id_) then
text = text..i.."~ : [@"..DevRio:get(storm..'Save:UserName'..v.user_id_).."]\n"
else
text = text..i.."~ : "..v.user_id_.."\n"
end
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, 'md')
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID, offset_ = 0,limit_ = 200000},TagAll,nil)
end
end
end
--     Source Storm     --
if text == "ุฑุณุงุฆูู" and msg.reply_to_message_id_ == 0 and ChCheck(msg) then
local user_msgs = DevRio:get(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุนุฏุฏ ุฑุณุงุฆูู ููุง โคฝ *โจ "..user_msgs.." โฉ*", 1, 'md')
end
if text == "ุงูุชูุงุนู" and ChCheck(msg) then
local EntryNumber = (DevRio:get(storm..'Rio:EntryNumber'..msg.chat_id_..':'..os.date('%d')) or 0)
local ExitNumber = (DevRio:get(storm..'Rio:ExitNumber'..msg.chat_id_..':'..os.date('%d')) or 0)
local MsgNumberDay = (DevRio:get(storm..'Rio:MsgNumberDay'..msg.chat_id_..':'..os.date('%d')) or 0)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงูุถูุงู ุงูุงุนุถุงุก ุงูููู โคฝ *"..EntryNumber.."*\nโ๏ธูุบุงุฏุฑุฉ ุงูุงุนุถุงุก ุงูููู โคฝ *"..ExitNumber.."*\nโ๏ธุนุฏุฏ ุงูุฑุณุงุฆู ุงูููู โคฝ *"..MsgNumberDay.."*\nโ๏ธูุณุจุฉ ุงูุชูุงุนู ุงูููู โคฝ *"..math.random(40,100).."%*", 1, 'md')
end
--     Source Storm     --
if text == "ุชุนุทูู ุชูุงุนูู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุชูุงุนูู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:msg:Rio'..msg.chat_id_) 
end
if text == "ุชูุนูู ุชูุงุนูู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุชูุงุนูู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:msg:Rio'..msg.chat_id_,true)  
end
if DevRio:get(storm.."Rio:msg:Rio"..msg.chat_id_) then
if msg.content_.ID then
get_msg = DevRio:get(storm.."Rio:msg:Rio"..msg.sender_user_id_..":"..msg.chat_id_) or 0
gms = get_msg + 1
DevRio:setex(storm..'Rio:msg:Rio'..msg.sender_user_id_..":"..msg.chat_id_,86400,gms)
end
if text == "ุชูุงุนูู" and tonumber(msg.reply_to_message_id_) == 0 then    
get_msg = DevRio:get(storm.."Rio:msg:Rio"..msg.sender_user_id_..":"..msg.chat_id_) or 0
send(msg.chat_id_, msg.id_,"โ๏ธุนุฏุฏ ุฑุณุงุฆูู ุงูููู ูู โฌ\n"..get_msg.." ูู ุงูุฑุณุงุฆู")
end  
if text == "ุชูุงุนูู" and tonumber(msg.reply_to_message_id_) > 0 then    
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
get_msg = DevRio:get(storm.."Rio:msg:Rio"..result.sender_user_id_..":"..msg.chat_id_) or 0
send(msg.chat_id_, msg.id_,"โ๏ธุนุฏุฏ ุฑุณุงุฆูู ุงูููู ูู โฌ\n"..get_msg.." ูู ุงูุฑุณุงุฆู")
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
end
--     Source Storm     --
if text == "ุฌูุงุชู" and ChCheck(msg) or text == "ุงุถุงูุงุชู" and ChCheck(msg) then add = (tonumber(DevRio:get(storm..'Rio:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_)) or 0) Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุนุฏุฏ ุฌูุงุชู ุงููุถุงูู โคฝ *โจ "..add.." โฉ* ", 1, 'md') end
if text == "ุชุนุฏููุงุชู" or text == "ุณุญูุงุชู" and ChCheck(msg) then local edit_msg = DevRio:get(storm..'Rio:EditMsg'..msg.chat_id_..msg.sender_user_id_) or 0  Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุนุฏุฏ ุชุนุฏููุงุชู โคฝ *โจ "..edit_msg.." โฉ* ", 1, 'md') end
if text == "ุฑุชุจุชู" and ChCheck(msg) then Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุฑุชุจุชู โคฝ '..IdRank(msg.sender_user_id_, msg.chat_id_), 1, 'html') end
if text == "ุงูุฏู ุงููุฌููุนู" and ChCheck(msg) then Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงูุฏู ุงููุฌููุนู โคฝ `"..msg.chat_id_.."`", 1, 'md') end
if text == 'ูุณุญ ุณุญูุงุชู' or text == 'ูุณุญ ุชุนุฏููุงุชู' or text == 'ุญุฐู ุณุญูุงุชู' or text == 'ุญุฐู ุชุนุฏููุงุชู' then DevRio:del(storm..'Rio:EditMsg'..msg.chat_id_..msg.sender_user_id_) Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญุฐู ุฌููุน ุชุนุฏููุงุชู ุจูุฌุงุญ' , 1, 'md') end
if text == 'ูุณุญ ุฌูุงุชู' or text == 'ูุณุญ ุงุถุงูุงุชู' or text == 'ุญุฐู ุฌูุงุชู' or text == 'ุญุฐู ุงุถุงูุงุชู' then DevRio:del(storm..'Rio:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_) Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญุฐู ุฌููุน ุฌูุงุชู ุงููุถุงูู' , 1, 'md') end
--     Source Storm     --
if text and text:match('^ูููู @(.*)') and ChCheck(msg) or text and text:match('^ููููุง @(.*)') and ChCheck(msg) then 
if not DevRio:get(storm..'Rio:Lock:Stupid'..msg.chat_id_) then
local username = text:match('^ูููู @(.*)') or text:match('^ููููุง @(.*)') 
function stormTeam(extra,result,success)
if result.id_ then  
if tonumber(result.id_) == tonumber(storm) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'ุดู ุชูุถุฑุท ุงูู ูุงุญุฏ ูููู ููุณูุ๐ค๐๐ฟ', 1, 'md')  
return false 
end  
if tonumber(result.id_) == tonumber(DevId) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'ุฏู ููู ุชุฑูุฏ ุงูููู ุชุงุฌ ุฑุงุณููุ๐๐๐ฟ', 1, 'md') 
return false  
end  
if tonumber(result.id_) == tonumber(1871165209) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'ุฏู ููู ุชุฑูุฏ ุงูููู ุชุงุฌ ุฑุงุณููุ๐๐๐ฟ', 1, 'md') 
return false  
end  
if DevRio:sismember(storm.."Rio:RioConstructor:"..msg.chat_id_,result.id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'ุฏู ููู ุชุฑูุฏ ุงูููู ุชุงุฌ ุฑุงุณููุ๐๐๐ฟ', 1, 'md')
return false
end 
local stormTeam = "ุตุงุฑุฑ ุณุชุงุฐูู ๐๐ปโโ๏ธโฅ๏ธ" 
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md') 
local stormTeam = { "ููู ุฌุฑุฌู @"..username.." ุงุญุชุฑู ุงุณูุงุฏูู ูุง ุงูุชููู ูุงุฒุฑุจุจ ุนูู ูุจุฑููุ๐ฉ๐๐ฟ","ูุดุด ููู ูุงุดู @"..username.." ูุชุถู ุชูุณูุช ูุง ุงุฎุฑุจุท ุชุถุงุฑูุณ ูุฌูู ุฌูู ุงุจุท ุนุจุฏูุ ๐๐๐ฟ","ุญุจูุจู @"..username.." ุฑุงุญ ุงุญุงูู ุงุญุชุฑููู ูุงููุฑู ุจููู ุชุจุทู ุญููููุ ๐ค๐ช","ุฏูุดู ูู @"..username.." ููุจูุน ุงููุดู ูู ุฒูู ููููู ููุญุฌู ููุงู ูู ููุจูุฐ ๐๐๐ฟ","ูุง ุงูุบููุถ ุงูุชูุณ ุงุจู ุฑุงุณ ุงููุฑุจุน @"..username.." ูุชุนูููู ุฌู ุญุฌุงูู ูุฌุงู ุชุทูุทููู ุนูููู ุฏุจุทู๐๐ช",}
Dev_Rio(msg.chat_id_, result.id_, 1,''..stormTeam[math.random(#stormTeam)], 1, 'html') 
else  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู ุบูุฑ ููุฌูุฏ ูู ุงููุฌููุนู', 1, 'md') 
end 
end 
resolve_username(username,stormTeam)
end
end
--     Source Storm     --
if text == ("ูููู") or text == ("ุจุนุฏ ูููู") or text == ("ูููู ุจุนุฏ") or text == ("ูู ูููู") or text == ("ููููุง") or text == ("ููููู") or text == ("ุฑุฒูู") or text == ("ุฑุฒููู") or text == ("ุฑุฒููุง") then
if not DevRio:get(storm..'Rio:Lock:Stupid'..msg.chat_id_) then
function hena(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(storm) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'ุดู ุชูุถุฑุท ุงูู ูุงุญุฏ ูููู ููุณูุ๐ค๐๐ฟ', 1, 'md') 
return false  
end  
if tonumber(result.sender_user_id_) == tonumber(DevId) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'ุฏู ููู ุชุฑูุฏ ุงูููู ุชุงุฌ ุฑุงุณููุ๐๐๐ฟ', 1, 'md')
return false
end 
if tonumber(result.sender_user_id_) == tonumber(1871165209) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'ุฏู ููู ุชุฑูุฏ ุงูููู ุชุงุฌ ุฑุงุณููุ๐๐๐ฟ', 1, 'md')
return false
end 
if DevRio:sismember(storm.."Rio:RioConstructor:"..msg.chat_id_,result.sender_user_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'ุฏู ููู ุชุฑูุฏ ุงูููู ุชุงุฌ ุฑุงุณููุ๐๐๐ฟ', 1, 'md')
return false
end 
local stormTeam = "ุตุงุฑุฑ ุณุชุงุฐูู ๐๐ปโโ๏ธโฅ๏ธ" 
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md') 
local stormTeam = {"ููู ุฌุฑุฌู ุงุญุชุฑู ุงุณูุงุฏูู ูุง ุงูุชููู ูุงุฒุฑุจุจ ุนูู ูุจุฑููุ๐ฉ๐๐ฟ","ูุดุด ูุงุดู ูุชุถู ุชูุณูุช ูุง ุงุฎุฑุจุท ุชุถุงุฑูุณ ูุฌูู ุฌูู ุงุจุท ุนุจุฏูุ ๐๐๐ฟ","ุฏูุดู ูู ููุจูุน ุงููุดู ูู ุฒูู ููููู ููุญุฌู ููุงู ูู ููุจูุฐ ๐๐๐ฟ","ูุง ุงูุบููุถ ุงูุชูุณ ุงุจู ุฑุงุณ ุงููุฑุจุน ูุชุนูููู ุฌู ุญุฌุงูู ูุฌุงู ุชุทูุทููู ุนูููู ุฏุจุทู๐๐ช","ุญุจูุจู ุฑุงุญ ุงุญุงูู ุงุญุชุฑููู ูุงููุฑู ุจููู ุชุจุทู ุญููููุ ๐ค๐ช"} 
Dev_Rio(msg.chat_id_, result.id_, 1,''..stormTeam[math.random(#stormTeam)], 1, 'md') 
end 
if tonumber(msg.reply_to_message_id_) == 0 then
else 
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),hena)   
end
end
end
if text == ("ุจูุณู") or text == ("ุจุนุฏ ุจูุณู") or text == ("ุถู ุจูุณ") or text == ("ุจูุณู ุจุนุฏ") or text == ("ุจูุณูุง") or text == ("ุจุนุฏ ุจูุณูุง") or text == ("ุถู ุจูุณ") or text == ("ุจูุณูุง ุจุนุฏ") or text == ("ุจูุณูู") then
if not DevRio:get(storm..'Rio:Lock:Stupid'..msg.chat_id_) then
function bosh(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(storm) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'ูููููู ุดูููู ุฑุงุญุญ ุงุจูุณ ููุณููุ๐ถ๐', 1, 'md') 
return false  
end  
if tonumber(result.sender_user_id_) == tonumber(DevId) then  
Dev_Rio(msg.chat_id_, result.id_, 1, 'ููุงุญุญุญ ุงุญูุงุง ุจูุณุฉุฉ ุงููุทูุฑูู๐ป๐ฅ๐', 1, 'html')
return false
end 
local stormTeam = "ุตุงุฑุฑ ุณุชุงุฐูู ๐๐ปโโ๏ธโฅ๏ธ" 
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md') 
local stormTeam = {"ููุงุญุญุญ ุงููุด ุนุงููููู๐๐ฅ๐","ุงูููููุงุงูุญุญ ุดููุนุณู๐ฅบ๐ฏ๐","ููุงุญุญุญุุกููู ุงุฐูุจ๐คค๐"} 
Dev_Rio(msg.chat_id_, result.id_, 1,''..stormTeam[math.random(#stormTeam)], 1, 'md') 
end 
if tonumber(msg.reply_to_message_id_) == 0 then
else 
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),bosh)   
end
end
end
if text == ("ุตูุญู") or text == ("ุตูุญูุง") or text == ("ุตูุญูู") or text == ("ุตูุญ") then
if not DevRio:get(storm..'Rio:Lock:Stupid'..msg.chat_id_) then
function seha(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(storm) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'ูููููู ุดูููู ุฑุงุญุญ ุงุตูุญ ููุณููุ๐ถ๐', 1, 'md') 
return false  
end  
if tonumber(result.sender_user_id_) == tonumber(DevId) then  
Dev_Rio(msg.chat_id_, result.id_, 1, 'ุชุนุงู ูุทูุฑูู ูุญุชุงุฌููู๐๐ปโโ๏ธโฅ๏ธ', 1, 'html')
return false
end 
local stormTeam = "ุตุงุฑุฑ ุณุชุงุฐูู ๐๐ปโโ๏ธโฅ๏ธ" 
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md') 
local stormTeam = {"ุชุชุนุงู ุญุญุจ ูุญุชุงุฌูู๐๐ญ","ุชุนุงู ูููู ุงุณุชุงุฐูู ุงูุฑูุฏููู๐๐ช","ููุนููุฏ ุชุนุงุงู ูุฑูุฏููู๐คโฅ๏ธ","ุชุนุงู ููู ุฏูุตูุญูู๐๐ค"} 
Dev_Rio(msg.chat_id_, result.id_, 1,''..stormTeam[math.random(#stormTeam)], 1, 'md') 
end 
if tonumber(msg.reply_to_message_id_) == 0 then
else 
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),seha)   
end
end
end
--     Source Storm     --
if text and text:match('^ุตูุญู @(.*)') and ChCheck(msg) or text and text:match('^ุตูุญ @(.*)') and ChCheck(msg) then 
if not DevRio:get(storm..'Rio:Lock:Stupid'..msg.chat_id_) then
local username = text:match('^ุตูุญู @(.*)') or text:match('^ุตูุญ @(.*)') 
function stormTeam(extra,result,success)
if result.id_ then  
if tonumber(result.id_) == tonumber(storm) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'ูููููู ุดูููู ุฑุงุญุญ ุงุตูุญ ููุณููุ๐ถ๐', 1, 'md')  
return false 
end  
if tonumber(result.id_) == tonumber(DevId) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'ุชุนุงู ูุทูุฑูู ูุญุชุงุฌููู๐๐ปโโ๏ธโฅ๏ธ @'..username, 1, 'html') 
return false  
end  
local stormTeam = "ุตุงุฑุฑ ุณุชุงุฐูู ๐๐ปโโ๏ธโฅ๏ธ" 
Dev_Rio(msg.chat_id_, msg.id_, 1,stormTeam, 1, 'md') 
local stormTeam = { "ุชุชุนุงู ุญุญุจ @"..username.." ูุญุชุงุฌูู๐๐ญ","ุชุนุงู ูููู @"..username.." ุงุณุชุงุฐูู ุงูุฑูุฏููู๐๐ช","ููุนููุฏ @"..username.." ุชุนุงุงู ูุฑูุฏููู๐คโฅ๏ธ","ุชุนุงู ููู @"..username.." ุฏูุตูุญูู๐๐ค",}
Dev_Rio(msg.chat_id_, result.id_, 1,''..stormTeam[math.random(#stormTeam)], 1, 'html') 
else  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุถู ุบูุฑ ููุฌูุฏ ูู ุงููุฌููุนู', 1, 'md') 
end 
end 
resolve_username(username,stormTeam)
end
end
end
--     Source Storm     --
if text == ("ุชูุฒูู ุงููู") and msg.reply_to_message_id_ ~= 0 and Manager(msg) and ChCheck(msg) then 
function promote_by_reply(extra, result, success)
if SudoId(result.sender_user_id_) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุงุชุณุชุทูุน ุชูุฒูู ุงููุทูุฑ ุงูุงุณุงุณู", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:RioSudo:',result.sender_user_id_) then
riosudo = 'ุงููุทูุฑูู ุงูุงุณุงุณููู โข ' else riosudo = '' end
if DevRio:sismember(storm..'Rio:SecondSudo:',result.sender_user_id_) then
secondsudo = 'ุงููุทูุฑูู ุงูุซุงููููู โข ' else secondsudo = '' end
if DevRio:sismember(storm..'Rio:SudoBot:',result.sender_user_id_) then
sudobot = 'ุงููุทูุฑูู โข ' else sudobot = '' end
if DevRio:sismember(storm..'Rio:BasicConstructor:'..msg.chat_id_, result.sender_user_id_) then
basicconstructor = 'ุงูููุดุฆูู ุงูุงุณุงุณููู โข ' else basicconstructor = '' end
if DevRio:sismember(storm..'Rio:Constructor:'..msg.chat_id_, result.sender_user_id_) then
constructor = 'ุงูููุดุฆูู โข ' else constructor = '' end 
if DevRio:sismember(storm..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_) then
manager = 'ุงููุฏุฑุงุก โข ' else manager = '' end
if DevRio:sismember(storm..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_) then
admins = 'ุงูุงุฏูููู โข ' else admins = '' end
if DevRio:sismember(storm..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_) then
vipmem = 'ุงููููุฒูู โข ' else vipmem = '' end
if DevRio:sismember(storm..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_) then
cleaner = 'ุงูููุธููู โข ' else cleaner = ''
end
if RankChecking(result.sender_user_id_,msg.chat_id_) ~= false then
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ูู โคฝ โค\n~ ( "..riosudo..secondsudo..sudobot..basicconstructor..constructor..manager..admins..vipmem..cleaner.." ) ~")  
else 
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธูู ุชุชู ุชุฑููุชู ูุณุจูุง")  
end
if RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'sudoid' then
DevRio:srem(storm..'Rio:RioSudo:', result.sender_user_id_)
DevRio:srem(storm..'Rio:SecondSudo:', result.sender_user_id_)
DevRio:srem(storm..'Rio:SudoBot:', result.sender_user_id_)
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'riosudo' then
DevRio:srem(storm..'Rio:SecondSudo:', result.sender_user_id_)
DevRio:srem(storm..'Rio:SudoBot:', result.sender_user_id_)
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'secondsudo' then
DevRio:srem(storm..'Rio:SudoBot:', result.sender_user_id_)
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'sudobot' then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'rioconstructor' then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'basicconstructor' then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'constructor' then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'manager' then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,promote_by_reply)
end
if text and text:match("^ุชูุฒูู ุงููู @(.*)$") and Manager(msg) and ChCheck(msg) then
local rem = {string.match(text, "^(ุชูุฒูู ุงููู) @(.*)$")}
function remm(extra, result, success)
if result.id_ then
if SudoId(result.id_) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุงุชุณุชุทูุน ุชูุฒูู ุงููุทูุฑ ุงูุงุณุงุณู", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:RioSudo:',result.id_) then
Riosudo = 'ุงููุทูุฑูู ุงูุงุณุงุณููู โข ' else Riosudo = '' end
if DevRio:sismember(storm..'Rio:SecondSudo:',result.id_) then
secondsudo = 'ุงููุทูุฑูู ุงูุซุงููููู โข ' else secondsudo = '' end
if DevRio:sismember(storm..'Rio:SudoBot:',result.id_) then
sudobot = 'ุงููุทูุฑูู โข ' else sudobot = '' end
if DevRio:sismember(storm..'Rio:BasicConstructor:'..msg.chat_id_, result.id_) then
basicconstructor = 'ุงูููุดุฆูู ุงูุงุณุงุณููู โข ' else basicconstructor = '' end
if DevRio:sismember(storm..'Rio:Constructor:'..msg.chat_id_, result.id_) then
constructor = 'ุงูููุดุฆูู โข ' else constructor = '' end 
if DevRio:sismember(storm..'Rio:Managers:'..msg.chat_id_, result.id_) then
manager = 'ุงููุฏุฑุงุก โข ' else manager = '' end
if DevRio:sismember(storm..'Rio:Admins:'..msg.chat_id_, result.id_) then
admins = 'ุงูุงุฏูููู โข ' else admins = '' end
if DevRio:sismember(storm..'Rio:VipMem:'..msg.chat_id_, result.id_) then
vipmem = 'ุงููููุฒูู โข ' else vipmem = '' end
if DevRio:sismember(storm..'Rio:Cleaner:'..msg.chat_id_, result.id_) then
cleaner = 'ุงูููุธููู โข ' else cleaner = ''
end
if RankChecking(result.id_,msg.chat_id_) ~= false then
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุชูุฒููู ูู โคฝ โค\n~ ( "..riosudo..secondsudo..sudobot..basicconstructor..constructor..manager..admins..vipmem..cleaner.." ) ~")  
else 
ReplyStatus(msg,result.id_,"Reply","โ๏ธูู ุชุชู ุชุฑููุชู ูุณุจูุง")  
end 
if RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'sudoid' then
DevRio:srem(storm..'Rio:RioSudo:', result.id_)
DevRio:srem(storm..'Rio:SecondSudo:', result.id_)
DevRio:srem(storm..'Rio:SudoBot:', result.id_)
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'riosudo' then
DevRio:srem(storm..'Rio:SecondSudo:', result.id_)
DevRio:srem(storm..'Rio:SudoBot:', result.id_)
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'secondsudo' then
DevRio:srem(storm..'Rio:SudoBot:', result.id_)
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'sudobot' then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.id_)
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'rioconstructor' then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.id_)
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'basicconstructor' then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.id_)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'constructor' then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'manager' then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_, result.id_)
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end
end
resolve_username(rem[2],remm)
end
--     Source Storm     --
--     Set RioSudo     --
if Sudo(msg) then
if text ==('ุงุถู ูุทูุฑ ุงุณุงุณู') or text ==('ุฑูุน ูุทูุฑ ุงุณุงุณู') and ChCheck(msg) then
function sudo_reply(extra, result, success)
DevRio:sadd(storm..'Rio:RioSudo:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุทูุฑูู ุงูุงุณุงุณููู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),sudo_reply)
end end 
if text and (text:match('^ุงุถู ูุทูุฑ ุงุณุงุณู @(.*)') or text:match('^ุฑูุน ูุทูุฑ ุงุณุงุณู @(.*)')) and ChCheck(msg) then
local username = text:match('^ุงุถู ูุทูุฑ ุงุณุงุณู @(.*)') or text:match('^ุฑูุน ูุทูุฑ ุงุณุงุณู @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:sadd(storm..'Rio:RioSudo:',result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุทูุฑูู ุงูุงุณุงุณููู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^ุงุถู ูุทูุฑ ุงุณุงุณู (%d+)') or text:match('^ุฑูุน ูุทูุฑ ุงุณุงุณู (%d+)')) and ChCheck(msg) then
local user = text:match('ุงุถู ูุทูุฑ ุงุณุงุณู (%d+)') or text:match('ุฑูุน ูุทูุฑ ุงุณุงุณู (%d+)')
DevRio:sadd(storm..'Rio:RioSudo:',user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุทูุฑูู ุงูุงุณุงุณููู")  
end
--     Source Storm     --
--     Rem SecondSudo     --
if text ==('ุญุฐู ูุทูุฑ ุงุณุงุณู') or text ==('ุชูุฒูู ูุทูุฑ ุงุณุงุณู') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(storm..'Rio:RioSudo:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุทูุฑูู ุงูุงุณุงุณููู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and (text:match('^ุญุฐู ูุทูุฑ ุงุณุงุณู @(.*)') or text:match('^ุชูุฒูู ูุทูุฑ ุงุณุงุณู @(.*)')) and ChCheck(msg) then
local username = text:match('^ุญุฐู ูุทูุฑ ุงุณุงุณู @(.*)') or text:match('^ุชูุฒูู ูุทูุฑ ุงุณุงุณู @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(storm..'Rio:RioSudo:',result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุทูุฑูู ุงูุงุณุงุณููู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^ุญุฐู ูุทูุฑ ุงุณุงุณู (%d+)') or text:match('^ุชูุฒูู ูุทูุฑ ุงุณุงุณู (%d+)')) and ChCheck(msg) then
local user = text:match('ุญุฐู ูุทูุฑ ุงุณุงุณู (%d+)') or text:match('ุชูุฒูู ูุทูุฑ ุงุณุงุณู (%d+)')
DevRio:srem(storm..'Rio:RioSudo:',user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุทูุฑูู ุงูุงุณุงุณููู")  
end end
--     Source Storm     --
--     Set SecondSudo     --
if RioSudo(msg) then
if text ==('ุงุถู ูุทูุฑ ุซุงููู') or text ==('ุฑูุน ูุทูุฑ ุซุงููู') and ChCheck(msg) then
function sudo_reply(extra, result, success)
DevRio:sadd(storm..'Rio:SecondSudo:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุทูุฑูู ุงูุซุงููููู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),sudo_reply)
end end 
if text and (text:match('^ุงุถู ูุทูุฑ ุซุงููู @(.*)') or text:match('^ุฑูุน ูุทูุฑ ุซุงููู @(.*)')) and ChCheck(msg) then
local username = text:match('^ุงุถู ูุทูุฑ ุซุงููู @(.*)') or text:match('^ุฑูุน ูุทูุฑ ุซุงููู @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:sadd(storm..'Rio:SecondSudo:',result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุทูุฑูู ุงูุซุงููููู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^ุงุถู ูุทูุฑ ุซุงููู (%d+)') or text:match('^ุฑูุน ูุทูุฑ ุซุงููู (%d+)')) and ChCheck(msg) then
local user = text:match('ุงุถู ูุทูุฑ ุซุงููู (%d+)') or text:match('ุฑูุน ูุทูุฑ ุซุงููู (%d+)')
DevRio:sadd(storm..'Rio:SecondSudo:',user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุทูุฑูู ุงูุซุงููููู")  
end
--     Source Storm     --
--     Rem SecondSudo     --
if text ==('ุญุฐู ูุทูุฑ ุซุงููู') or text ==('ุชูุฒูู ูุทูุฑ ุซุงููู') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(storm..'Rio:SecondSudo:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุทูุฑูู ุงูุซุงููููู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and (text:match('^ุญุฐู ูุทูุฑ ุซุงููู @(.*)') or text:match('^ุชูุฒูู ูุทูุฑ ุซุงููู @(.*)')) and ChCheck(msg) then
local username = text:match('^ุญุฐู ูุทูุฑ ุซุงููู @(.*)') or text:match('^ุชูุฒูู ูุทูุฑ ุซุงููู @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(storm..'Rio:SecondSudo:',result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุทูุฑูู ุงูุซุงููููู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^ุญุฐู ูุทูุฑ ุซุงููู (%d+)') or text:match('^ุชูุฒูู ูุทูุฑ ุซุงููู (%d+)')) and ChCheck(msg) then
local user = text:match('ุญุฐู ูุทูุฑ ุซุงููู (%d+)') or text:match('ุชูุฒูู ูุทูุฑ ุซุงููู (%d+)')
DevRio:srem(storm..'Rio:SecondSudo:',user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุทูุฑูู ุงูุซุงููููู")  
end end
--     Source Storm     --
--       Set SudoBot      --
if SecondSudo(msg) then
if text ==('ุงุถู ูุทูุฑ') or text ==('ุฑูุน ูุทูุฑ') and ChCheck(msg) then
function sudo_reply(extra, result, success)
DevRio:sadd(storm..'Rio:SudoBot:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุทูุฑูู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),sudo_reply)
end end 
if text and (text:match('^ุงุถู ูุทูุฑ @(.*)') or text:match('^ุฑูุน ูุทูุฑ @(.*)')) and ChCheck(msg) then
local username = text:match('^ุงุถู ูุทูุฑ @(.*)') or text:match('^ุฑูุน ูุทูุฑ @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:sadd(storm..'Rio:SudoBot:',result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุทูุฑูู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^ุงุถู ูุทูุฑ (%d+)') or text:match('^ุฑูุน ูุทูุฑ (%d+)')) and ChCheck(msg) then
local user = text:match('ุงุถู ูุทูุฑ (%d+)') or text:match('ุฑูุน ูุทูุฑ (%d+)')
DevRio:sadd(storm..'Rio:SudoBot:',user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุทูุฑูู")  
end
--     Source Storm     --
--       Rem SudoBot      --
if text ==('ุญุฐู ูุทูุฑ') or text ==('ุชูุฒูู ูุทูุฑ') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(storm..'Rio:SudoBot:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุทูุฑูู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and (text:match('^ุญุฐู ูุทูุฑ @(.*)') or text:match('^ุชูุฒูู ูุทูุฑ @(.*)')) and ChCheck(msg) then
local username = text:match('^ุญุฐู ูุทูุฑ @(.*)') or text:match('^ุชูุฒูู ูุทูุฑ @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(storm..'Rio:SudoBot:',result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุทูุฑูู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^ุญุฐู ูุทูุฑ (%d+)') or text:match('^ุชูุฒูู ูุทูุฑ (%d+)')) and ChCheck(msg) then
local user = text:match('ุญุฐู ูุทูุฑ (%d+)') or text:match('ุชูุฒูู ูุทูุฑ (%d+)')
DevRio:srem(storm..'Rio:SudoBot:',user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุทูุฑูู")  
end end
--     Source Storm     --
--   Set RioConstructor   --
if ChatType == 'sp' or ChatType == 'gp'  then
if SudoBot(msg) then
if text ==('ุฑูุน ูุงูู') and ChCheck(msg) then
function raf_reply(extra, result, success)
DevRio:sadd(storm..'Rio:RioConstructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ูุงูู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),raf_reply)
end end
if text and text:match('^ุฑูุน ูุงูู @(.*)') and ChCheck(msg) then
local username = text:match('^ุฑูุน ูุงูู @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:sadd(storm..'Rio:RioConstructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุฑูุนู ูุงูู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุฑูุน ูุงูู (%d+)') and ChCheck(msg) then
local user = text:match('ุฑูุน ูุงูู (%d+)')
DevRio:sadd(storm..'Rio:RioConstructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุฑูุนู ูุงูู")  
end
--     Source Storm     --
--   Rem RioConstructor   --
if text ==('ุชูุฒูู ูุงูู') and ChCheck(msg) then
function prom_reply(extra, result, success)
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
if tonumber(result.sender_user_id_) == tonumber(admins[i].user_id_) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ูููู ุชูุฒูู ุงููุงูู ุงูุงุณุงุณู', 1, 'md')
else
DevRio:srem(storm..'Rio:RioConstructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ุงููุงูููู")  
end end end
end,nil)
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end 
end
if text and text:match('^ุชูุฒูู ูุงูู @(.*)') and ChCheck(msg) then
local username = text:match('^ุชูุฒูู ูุงูู @(.*)')
function promreply(extra,result,success)
if result.id_ then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
if tonumber(result.id_) == tonumber(admins[i].user_id_) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ูููู ุชูุฒูู ุงููุงูู ุงูุงุณุงุณู', 1, 'md')
else
DevRio:srem(storm..'Rio:RioConstructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ุงููุงูููู")  
end end end
end,nil)
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุชูุฒูู ูุงูู (%d+)') and ChCheck(msg) then
local user = text:match('ุชูุฒูู ูุงูู (%d+)')
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
if tonumber(user) == tonumber(admins[i].user_id_) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ูููู ุชูุฒูู ุงููุงูู ุงูุงุณุงุณู', 1, 'md')
else
DevRio:srem(storm..'Rio:RioConstructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุชูุฒููู ูู ุงููุงูููู")  
end end end
end,nil)
end end
--     Source Storm     --
--  Set BasicConstructor  --
if RioConstructor(msg) then
if text ==('ุฑูุน ููุดุฆ ุงุณุงุณู') and ChCheck(msg) then
function raf_reply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
DevRio:sadd(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ููุดุฆ ุงุณุงุณู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),raf_reply)
end end
if text and text:match('^ุฑูุน ููุดุฆ ุงุณุงุณู @(.*)') and ChCheck(msg) then
local username = text:match('^ุฑูุน ููุดุฆ ุงุณุงุณู @(.*)')
function promreply(extra,result,success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
if result.id_ then
DevRio:sadd(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุฑูุนู ููุดุฆ ุงุณุงุณู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุฑูุน ููุดุฆ ุงุณุงุณู (%d+)') and ChCheck(msg) then
local user = text:match('ุฑูุน ููุดุฆ ุงุณุงุณู (%d+)')
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
DevRio:sadd(storm..'Rio:BasicConstructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุฑูุนู ููุดุฆ ุงุณุงุณู")  
end
--     Source Storm     --
--  Rem BasicConstructor  --
if text ==('ุชูุฒูู ููุดุฆ ุงุณุงุณู') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ููุดุฆ ุงุณุงุณู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^ุชูุฒูู ููุดุฆ ุงุณุงุณู @(.*)') and ChCheck(msg) then
local username = text:match('^ุชูุฒูู ููุดุฆ ุงุณุงุณู @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุชูุฒููู ููุดุฆ ุงุณุงุณู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุชูุฒูู ููุดุฆ ุงุณุงุณู (%d+)') and ChCheck(msg) then
local user = text:match('ุชูุฒูู ููุดุฆ ุงุณุงุณู (%d+)')
DevRio:srem(storm..'Rio:BasicConstructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุชูุฒููู ููุดุฆ ุงุณุงุณู")  
end end
if text ==('ุฑูุน ููุดุฆ ุงุณุงุณู') and not RioConstructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุฐุง ุงูุงูุฑ ูููุงูููู ูุงููุทูุฑูู ููุท', 1, 'md')
end
--     Source Storm     --
--    Set  Constructor    --
if BasicConstructor(msg) then
if text ==('ุฑูุน ููุดุฆ') and ChCheck(msg) then
function raf_reply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
DevRio:sadd(storm..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงูููุดุฆูู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),raf_reply)
end end
if text and text:match('^ุฑูุน ููุดุฆ @(.*)') and ChCheck(msg) then
local username = text:match('^ุฑูุน ููุดุฆ @(.*)')
function promreply(extra,result,success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
if result.id_ then
DevRio:sadd(storm..'Rio:Constructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงูููุดุฆูู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุฑูุน ููุดุฆ (%d+)') and ChCheck(msg) then
local user = text:match('ุฑูุน ููุดุฆ (%d+)')
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
DevRio:sadd(storm..'Rio:Constructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงูููุดุฆูู")  
end
--     Source Storm     --
--    Rem  Constructor    --
if text ==('ุชูุฒูู ููุดุฆ') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงูููุดุฆูู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^ุชูุฒูู ููุดุฆ @(.*)') and ChCheck(msg) then
local username = text:match('^ุชูุฒูู ููุดุฆ @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงูููุดุฆูู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุชูุฒูู ููุดุฆ (%d+)') and ChCheck(msg) then
local user = text:match('ุชูุฒูู ููุดุฆ (%d+)')
DevRio:srem(storm..'Rio:Constructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงูููุดุฆูู")  
end 
end
--     Source Storm     --
--      Set Manager       --
if Constructor(msg) then
if text ==('ุฑูุน ูุฏูุฑ') and ChCheck(msg) then
function prom_reply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
DevRio:sadd(storm..'Rio:Managers:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุฏุฑุงุก")  
end  
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^ุฑูุน ูุฏูุฑ @(.*)') and ChCheck(msg) then
local username = text:match('^ุฑูุน ูุฏูุฑ @(.*)')
function promreply(extra,result,success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
if result.id_ then
DevRio:sadd(storm..'Rio:Managers:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุฏุฑุงุก")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end 
if text and text:match('^ุฑูุน ูุฏูุฑ (%d+)') and ChCheck(msg) then
local user = text:match('ุฑูุน ูุฏูุฑ (%d+)')
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
DevRio:sadd(storm..'Rio:Managers:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุฏุฑุงุก")  
end
--     Source Storm     --
--       Rem Manager      --
if text ==('ุชูุฒูู ูุฏูุฑ') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุฏุฑุงุก")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^ุชูุฒูู ูุฏูุฑ @(.*)') and ChCheck(msg) then
local username = text:match('^ุชูุฒูู ูุฏูุฑ @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุฏุฑุงุก")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุชูุฒูู ูุฏูุฑ (%d+)') and ChCheck(msg) then
local user = text:match('ุชูุฒูู ูุฏูุฑ (%d+)')
DevRio:srem(storm..'Rio:Managers:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุฏุฑุงุก")  
end 
--     Source Storm     --
--       Set Cleaner      --
if text ==('ุฑูุน ููุธู') and ChCheck(msg) then
function prom_reply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
DevRio:sadd(storm..'Rio:Cleaner:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงูููุธููู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^ุฑูุน ููุธู @(.*)') and ChCheck(msg) then
local username = text:match('^ุฑูุน ููุธู @(.*)')
function promreply(extra,result,success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
if result.id_ then
DevRio:sadd(storm..'Rio:Cleaner:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงูููุธููู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุฑูุน ููุธู (%d+)') and ChCheck(msg) then
local user = text:match('ุฑูุน ููุธู (%d+)')
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
DevRio:sadd(storm..'Rio:Cleaner:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงูููุธููู")  
end
--     Source Storm     --
--       Rem Cleaner      --
if text ==('ุชูุฒูู ููุธู') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงูููุธููู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^ุชูุฒูู ููุธู @(.*)') and ChCheck(msg) then
local username = text:match('^ุชูุฒูู ููุธู @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงูููุธููู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุชูุฒูู ููุธู (%d+)') and ChCheck(msg) then
local user = text:match('ุชูุฒูู ููุธู (%d+)')
DevRio:srem(storm..'Rio:Cleaner:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงูููุธููู")  
end end
--     Source Storm     --
--       Set admin        --
if Manager(msg) then
if text ==('ุฑูุน ุงุฏูู') and ChCheck(msg) then
function prom_reply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
DevRio:sadd(storm..'Rio:Admins:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงูุงุฏูููู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^ุฑูุน ุงุฏูู @(.*)') and ChCheck(msg) then
local username = text:match('^ุฑูุน ุงุฏูู @(.*)')
function promreply(extra,result,success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
if result.id_ then
DevRio:sadd(storm..'Rio:Admins:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงูุงุฏูููู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุฑูุน ุงุฏูู (%d+)') and ChCheck(msg) then
local user = text:match('ุฑูุน ุงุฏูู (%d+)')
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
DevRio:sadd(storm..'Rio:Admins:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงูุงุฏูููู")  
end
--     Source Storm     --
--        Rem admin       --
if text ==('ุชูุฒูู ุงุฏูู') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงูุงุฏูููู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^ุชูุฒูู ุงุฏูู @(.*)') and ChCheck(msg) then
local username = text:match('^ุชูุฒูู ุงุฏูู @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงูุงุฏูููู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุชูุฒูู ุงุฏูู (%d+)') and ChCheck(msg) then
local user = text:match('ุชูุฒูู ุงุฏูู (%d+)')
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงูุงุฏูููู")  
end end
--     Source Storm     --
--       Set Vipmem       --
if Admin(msg) then
if text ==('ุฑูุน ูููุฒ') and ChCheck(msg) then
function prom_reply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
DevRio:sadd(storm..'Rio:VipMem:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููููุฒูู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^ุฑูุน ูููุฒ @(.*)') and ChCheck(msg) then
local username = text:match('^ุฑูุน ูููุฒ @(.*)')
function promreply(extra,result,success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
if result.id_ then
DevRio:sadd(storm..'Rio:VipMem:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููููุฒูู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุฑูุน ูููุฒ (%d+)') and ChCheck(msg) then
local user = text:match('ุฑูุน ูููุฒ (%d+)')
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุงุชุณุชุทูุน ุฑูุน ุงุญุฏ ูุฐุงูู ุจุณุจุจ ุชุนุทูู ุงูุฑูุน', 1, 'md')
return false
end
DevRio:sadd(storm..'Rio:VipMem:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููููุฒูู")  
end
--     Source Storm     --
--       Rem Vipmem       --
if text ==('ุชูุฒูู ูููุฒ') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููููุฒูู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^ุชูุฒูู ูููุฒ @(.*)') and ChCheck(msg) then
local username = text:match('^ุชูุฒูู ูููุฒ @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููููุฒูู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^ุชูุฒูู ูููุฒ (%d+)') and ChCheck(msg) then
local user = text:match('ุชูุฒูู ูููุฒ (%d+)')
DevRio:srem(storm..'Rio:VipMem:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููููุฒูู")  
end end 
--     Source Storm     --
if BasicConstructor(msg) then
if text and text:match("^ุฑูุน ูุดุฑู$") and msg.reply_to_message_id_ then
function promote_by_reply(extra, result, success)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..storm)
local GetInfo = JSON.decode(Check)
if GetInfo.result.can_promote_members == true then 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/promoteChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=false")
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ูุดุฑู ูู ุงููุฌููุนู")  
else
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธููุณุช ูุฏู ุตูุงุญูุฉ ุงุถุงูุฉ ูุดุฑููู ุฌุฏุฏ ูุฑุฌู ุงูุชุญูู ูู ุงูุตูุงุญูุงุช', 1, 'md')
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,promote_by_reply)
end
if text and text:match("^ุชูุฒูู ูุดุฑู$") and msg.reply_to_message_id_ then
function promote_by_reply(extra, result, success)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..storm)
local GetInfo = JSON.decode(Check)
if GetInfo.result.can_promote_members == true then 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/promoteChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุดุฑููู ุงููุฌููุนู")  
else
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธููุณุช ูุฏู ุตูุงุญูุฉ ุงุถุงูุฉ ูุดุฑููู ุฌุฏุฏ ูุฑุฌู ุงูุชุญูู ูู ุงูุตูุงุญูุงุช', 1, 'md')
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,promote_by_reply)
end 
if text and (text:match("^ุฑูุน ุจูู ุงูุตูุงุญูุงุช$") or text:match("^ุฑูุน ุจูู ุตูุงุญูุงุช$")) and msg.reply_to_message_id_ then
function promote_by_reply(extra, result, success)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..storm)
local GetInfo = JSON.decode(Check)
if GetInfo.result.can_promote_members == true then 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/promoteChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ูุดุฑู ูู ุฌููุน ุงูุตูุงุญูุงุช")  
else
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธููุณุช ูุฏู ุตูุงุญูุฉ ุงุถุงูุฉ ูุดุฑููู ุฌุฏุฏ ูุฑุฌู ุงูุชุญูู ูู ุงูุตูุงุญูุงุช', 1, 'md')
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,promote_by_reply)
end
if text and (text:match("^ูุถุน ููุจ (.*)$") or text:match("^ุฑูุน ูุดุฑู (.*)$") or text:match("^ุถุน ููุจ (.*)$")) and ChCheck(msg) then
local Rio = text:match("^ูุถุน ููุจ (.*)$") or text:match("^ุฑูุน ูุดุฑู (.*)$") or text:match("^ุถุน ููุจ (.*)$")
function ReplySet(extra, result, success)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..storm)
local GetInfo = JSON.decode(Check)
if GetInfo.result.can_promote_members == true then 
https.request("https://api.telegram.org/bot"..TokenBot.."/promoteChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุงุถุงูุฉ โคฝ "..Rio.." ูููุจ ูู")  
https.request("https://api.telegram.org/bot"..TokenBot.."/setChatAdministratorCustomTitle?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&custom_title="..Rio)
else
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธููุณุช ูุฏู ุตูุงุญูุฉ ุงุถุงูุฉ ูุดุฑููู ุฌุฏุฏ ูุฑุฌู ุงูุชุญูู ูู ุงูุตูุงุญูุงุช', 1, 'md')
end
end
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ReplySet)
end
end
end
if text == 'ููุจู' and ChCheck(msg) then
function ReplyGet(extra, result, success)
if GetCustomTitle(msg.sender_user_id_,msg.chat_id_) == false then
send(msg.chat_id_, msg.id_,'โ๏ธููุณ ูุฏูู ููุจ ููุง') 
else
send(msg.chat_id_, msg.id_,'โ๏ธููุจู โคฝ '..GetCustomTitle(result.sender_user_id_,msg.chat_id_)) 
end
end
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ReplyGet)
end
end
if text == 'ููุจู' and ChCheck(msg) then
if GetCustomTitle(msg.sender_user_id_,msg.chat_id_) == false then
send(msg.chat_id_, msg.id_,'โ๏ธููุณ ูุฏูู ููุจ ููุง') 
else
send(msg.chat_id_, msg.id_,'โ๏ธููุจู โคฝ '..GetCustomTitle(msg.sender_user_id_,msg.chat_id_)) 
end
end
if text == "ุฑุงุณููู" and ChCheck(msg) then
stormTeam = {"ูุง ููุงู","ุงูุทู","ููู","ุชูุถู","ุงุญุจู","ุนูุฑู","ูุงู"};
send(msg.sender_user_id_, 0,stormTeam[math.random(#stormTeam)])
end
--     Source Storm     --
if text == "ุตูุงุญูุชู" or text == "ุตูุงุญูุงุชู" and ChCheck(msg) then 
if tonumber(msg.reply_to_message_id_) == 0 then 
Validity(msg,msg.sender_user_id_)
end end
if text ==('ุตูุงุญูุชู') or text ==('ุตูุงุญูุงุชู') and ChCheck(msg) then
function ValidityReply(extra, result, success)
Validity(msg,result.sender_user_id_)
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ValidityReply)
end end
if text and (text:match('^ุตูุงุญูุชู @(.*)') or text:match('^ุตูุงุญูุงุชู @(.*)')) and ChCheck(msg) then
local username = text:match('^ุตูุงุญูุชู @(.*)') or text:match('^ุตูุงุญูุงุชู @(.*)')
function ValidityUser(extra,result,success)
if result.id_ then
Validity(msg,result.id_) 
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,ValidityUser)
end
if text and (text:match('^ุตูุงุญูุชู (%d+)') or text:match('^ุตูุงุญูุงุชู (%d+)')) and ChCheck(msg) then
local ValidityId = text:match('ุตูุงุญูุชู (%d+)') or text:match('ุตูุงุญูุงุชู (%d+)')
Validity(msg,ValidityId)  
end
--     Source Storm     --
if Admin(msg) then
if msg.reply_to_message_id_ ~= 0 then
if text and (text:match("^ูุณุญ$") or text:match("^ุญุฐู$")) and ChCheck(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.reply_to_message_id_})
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end end end
--     Source Storm     --
if RioConstructor(msg) then
if text == "ุชูุนูู ุงูุญุธุฑ" and ChCheck(msg) or text == "ุชูุนูู ุงูุทุฑุฏ" and ChCheck(msg) then
DevRio:del(storm.."Rio:Lock:KickBan"..msg.chat_id_)
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุทุฑุฏ ูุงูุญุธุฑ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end
if text == "ุชุนุทูู ุงูุญุธุฑ" and ChCheck(msg) or text == "ุชุนุทูู ุงูุทุฑุฏ" and ChCheck(msg) then
DevRio:set(storm.."Rio:Lock:KickBan"..msg.chat_id_,"true")
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุทุฑุฏ ูุงูุญุธุฑ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end
if text == "ุชูุนูู ุงููุชู" and ChCheck(msg) or text == "ุชูุนูู ุงูุชูููุฏ" and ChCheck(msg) then
DevRio:del(storm.."Rio:Lock:MuteTked"..msg.chat_id_)
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงููุชู ูุงูุชููุฏ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end
if text == "ุชุนุทูู ุงููุชู" and ChCheck(msg) or text == "ุชุนุทูู ุงูุชูููุฏ" and ChCheck(msg) then
DevRio:set(storm.."Rio:Lock:MuteTked"..msg.chat_id_,"true")
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงููุชู ูุงูุชููุฏ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end
end
if RioConstructor(msg) then
if text == "ุชูุนูู ุงูุฑูุน" and ChCheck(msg) or text == "ุชูุนูู ุงูุชุฑููู" and ChCheck(msg) then
DevRio:del(storm.."Rio:Lock:ProSet"..msg.chat_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุชูุนูู ุฑูุน โคฝ ุงูููุดุฆ ุงูุงุณุงุณู โข ุงูููุดุฆ โข ุงููุฏูุฑ โข ุงูุงุฏูู โข ุงููููุฒ', 1, 'md')
end
if text == "ุชุนุทูู ุงูุฑูุน" and ChCheck(msg) or text == "ุชุนุทูู ุงูุชุฑููู" and ChCheck(msg) then
DevRio:set(storm.."Rio:Lock:ProSet"..msg.chat_id_,"true")
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุชุนุทูู ุฑูุน โคฝ ุงูููุดุฆ ุงูุงุณุงุณู โข ุงูููุดุฆ โข ุงููุฏูุฑ โข ุงูุงุฏูู โข ุงููููุฒ', 1, 'md')
end
end
--     Source Storm     --
--          Kick          --
if Admin(msg) then
if text ==('ุทุฑุฏ') and ChCheck(msg) then
function KickReply(extra, result, success)
if not Constructor(msg) and DevRio:get(storm.."Rio:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'โ๏ธููุฏ ุชู ุชุนุทูู ุงูุทุฑุฏ ูุงูุญุธุฑ ูู ูุจู ุงูููุดุฆูู')
return false
end
if RankChecking(result.sender_user_id_, result.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุทุฑุฏ โคฝ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=result.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"โ๏ธููุณ ูุฏู ุตูุงุญูุฉ ุญุธุฑ ุงููุณุชุฎุฏููู ูุฑุฌู ุชูุนูููุง !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"โ๏ธูุง ุงุณุชุทูุน ุทุฑุฏ ูุดุฑููู ุงููุฌููุนู") 
return false  
end
ChatKick(result.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุทุฑุฏู ูู ุงููุฌููุนู")  
end,nil)
end
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),KickReply)
end end
if text and text:match('^ุทุฑุฏ @(.*)') and ChCheck(msg) then
local username = text:match('^ุทุฑุฏ @(.*)')
function KickUser(extra,result,success)
if not Constructor(msg) and DevRio:get(storm.."Rio:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'โ๏ธููุฏ ุชู ุชุนุทูู ุงูุทุฑุฏ ูุงูุญุธุฑ ูู ูุจู ุงูููุดุฆูู')
return false
end
if result.id_ then
if RankChecking(result.id_, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุทุฑุฏ โคฝ '..IdRank(result.id_, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=result.id_,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"โ๏ธููุณ ูุฏู ุตูุงุญูุฉ ุญุธุฑ ุงููุณุชุฎุฏููู ูุฑุฌู ุชูุนูููุง !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"โ๏ธูุง ุงุณุชุทูุน ุทุฑุฏ ูุดุฑููู ุงููุฌููุนู") 
return false  
end
ChatKick(msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุทุฑุฏู ูู ุงููุฌููุนู")  
end,nil)
end
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,KickUser)
end
if text and text:match('^ุทุฑุฏ (%d+)') and ChCheck(msg) then
local user = text:match('ุทุฑุฏ (%d+)')
if not Constructor(msg) and DevRio:get(storm.."Rio:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'โ๏ธููุฏ ุชู ุชุนุทูู ุงูุทุฑุฏ ูุงูุญุธุฑ ูู ูุจู ุงูููุดุฆูู')
return false
end
if RankChecking(user, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุทุฑุฏ โคฝ '..IdRank(user, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=user,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"โ๏ธููุณ ูุฏู ุตูุงุญูุฉ ุญุธุฑ ุงููุณุชุฎุฏููู ูุฑุฌู ุชูุนูููุง !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"โ๏ธูุง ุงุณุชุทูุน ุทุฑุฏ ูุดุฑููู ุงููุฌููุนู") 
return false  
end
ChatKick(msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุทุฑุฏู ูู ุงููุฌููุนู")  
end,nil)
end
end
end 
--     Source Storm     --
--          Ban           --
if Admin(msg) then
if text ==('ุญุถุฑ') or text ==('ุญุธุฑ') and ChCheck(msg) then
function BanReply(extra, result, success)
if not Constructor(msg) and DevRio:get(storm.."Rio:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'โ๏ธููุฏ ุชู ุชุนุทูู ุงูุทุฑุฏ ูุงูุญุธุฑ ูู ูุจู ุงูููุดุฆูู')
return false
end
if RankChecking(result.sender_user_id_, result.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุญุธุฑ โคฝ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=result.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"โ๏ธููุณ ูุฏู ุตูุงุญูุฉ ุญุธุฑ ุงููุณุชุฎุฏููู ูุฑุฌู ุชูุนูููุง !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"โ๏ธูุง ุงุณุชุทูุน ุญุธุฑ ูุดุฑููู ุงููุฌููุนู") 
return false  
end
ChatKick(result.chat_id_, result.sender_user_id_)
DevRio:sadd(storm..'Rio:Ban:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุญุธุฑู ูู ุงููุฌููุนู") 
end,nil) 
end 
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),BanReply)
end end
if text and (text:match('^ุญุถุฑ @(.*)') or text:match('^ุญุธุฑ @(.*)')) and ChCheck(msg) then
local username = text:match('^ุญุถุฑ @(.*)') or text:match('^ุญุธุฑ @(.*)')
function BanUser(extra,result,success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'โ๏ธููุฏ ุชู ุชุนุทูู ุงูุทุฑุฏ ูุงูุญุธุฑ')
return false
end
if result.id_ then
if RankChecking(result.id_, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุญุธุฑ โคฝ '..IdRank(result.id_, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=result.id_,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"โ๏ธููุณ ูุฏู ุตูุงุญูุฉ ุญุธุฑ ุงููุณุชุฎุฏููู ูุฑุฌู ุชูุนูููุง !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"โ๏ธูุง ุงุณุชุทูุน ุญุธุฑ ูุดุฑููู ุงููุฌููุนู") 
return false  
end
ChatKick(msg.chat_id_, result.id_)
DevRio:sadd(storm..'Rio:Ban:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุญุธุฑู ูู ุงููุฌููุนู")  
end,nil) 
end
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,BanUser)
end
if text and (text:match('^ุญุถุฑ (%d+)') or text:match('^ุญุธุฑ (%d+)')) and ChCheck(msg) then
local user = text:match('ุญุถุฑ (%d+)') or text:match('ุญุธุฑ (%d+)')
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'โ๏ธููุฏ ุชู ุชุนุทูู ุงูุทุฑุฏ ูุงูุญุธุฑ')
return false
end
if RankChecking(user, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุญุธุฑ โคฝ '..IdRank(user, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=user,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"โ๏ธููุณ ูุฏู ุตูุงุญูุฉ ุญุธุฑ ุงููุณุชุฎุฏููู ูุฑุฌู ุชูุนูููุง !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"โ๏ธูุง ุงุณุชุทูุน ุญุธุฑ ูุดุฑููู ุงููุฌููุนู") 
return false  
end
ChatKick(msg.chat_id_, user)
DevRio:sadd(storm..'Rio:Ban:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุญุธุฑู ูู ุงููุฌููุนู")  
end,nil) 
end
end
--     Source Storm     --
--         UnBan          --
if text ==('ุงูุบุงุก ุงูุญุธุฑ') or text ==('ุงูุบุงุก ุญุธุฑ') and ChCheck(msg) then
function UnBanReply(extra, result, success)
DevRio:srem(storm..'Rio:Ban:'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุงูุบุงุก ุญุธุฑู ูู ุงููุฌููุนู")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),UnBanReply)
end end
if text and (text:match('^ุงูุบุงุก ุงูุญุธุฑ @(.*)') or text:match('^ุงูุบุงุก ุญุธุฑ @(.*)')) and ChCheck(msg) then
local username = text:match('^ุงูุบุงุก ุงูุญุธุฑ @(.*)') or text:match('^ุงูุบุงุก ุญุธุฑ @(.*)')
function UnBanUser(extra,result,success)
if result.id_ then
DevRio:srem(storm..'Rio:Ban:'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุงูุบุงุก ุญุธุฑู ูู ุงููุฌููุนู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,UnBanUser)
end
if text and (text:match('^ุงูุบุงุก ุงูุญุธุฑ (%d+)') or text:match('^ุงูุบุงุก ุญุธุฑ (%d+)')) and ChCheck(msg) then
local user = text:match('ุงูุบุงุก ุงูุญุธุฑ (%d+)') or text:match('ุงูุบุงุก ุญุธุฑ (%d+)')
DevRio:srem(storm..'Rio:Ban:'..msg.chat_id_, user)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = user, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุงูุบุงุก ุญุธุฑู ูู ุงููุฌููุนู")  
end 
end 
--     Source Storm     --
--          Mute          --
if Admin(msg) then
if text ==('ูุชู') and ChCheck(msg) then
function MuteReply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'โ๏ธููุฏ ุชู ุชุนุทูู ุงููุชู ูุงูุชููุฏ')
return false
end
if RankChecking(result.sender_user_id_, result.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ูุชู โคฝ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md')
else
if DevRio:sismember(storm..'Rio:Muted:'..msg.chat_id_, result.sender_user_id_) then
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธูู ุจุงููุนู ููุชูู ูู ุงููุฌููุนู")  
else
DevRio:sadd(storm..'Rio:Muted:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ูุชูู ูู ุงููุฌููุนู")  
end 
end
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),MuteReply)
end end
if text and text:match('^ูุชู @(.*)') and ChCheck(msg) then
local username = text:match('^ูุชู @(.*)')
function MuteUser(extra,result,success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'โ๏ธููุฏ ุชู ุชุนุทูู ุงููุชู ูุงูุชููุฏ')
return false
end
if result.id_ then
if RankChecking(result.id_, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ูุชู โคฝ '..IdRank(result.id_, msg.chat_id_), 1, 'md')
else
if DevRio:sismember(storm..'Rio:Muted:'..msg.chat_id_, result.id_) then
ReplyStatus(msg,result.id_,"Reply","โ๏ธูู ุจุงููุนู ููุชูู ูู ุงููุฌููุนู")  
else
DevRio:sadd(storm..'Rio:Muted:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ูุชูู ูู ุงููุฌููุนู")  
end
end
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,MuteUser)
end
if text and text:match('^ูุชู (%d+)') and ChCheck(msg) then
local user = text:match('ูุชู (%d+)')
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'โ๏ธููุฏ ุชู ุชุนุทูู ุงููุชู ูุงูุชููุฏ')
return false
end
if RankChecking(user, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ูุชู โคฝ '..IdRank(user, msg.chat_id_), 1, 'md')
else
if DevRio:sismember(storm..'Rio:Muted:'..msg.chat_id_, user) then
ReplyStatus(msg,user,"Reply","โ๏ธูู ุจุงููุนู ููุชูู ูู ุงููุฌููุนู")  
else
DevRio:sadd(storm..'Rio:Muted:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ูุชูู ูู ุงููุฌููุนู")  
end
end
end
--     Source Storm     --
--         UnMute         --
if text ==('ุงูุบุงุก ุงููุชู') or text ==('ุงูุบุงุก ูุชู') and ChCheck(msg) then
function UnMuteReply(extra, result, success)
if not DevRio:sismember(storm..'Rio:Muted:'..msg.chat_id_, result.sender_user_id_) then
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธูู ููุณ ููุชูู ูุงูุบุงุก ูุชูู")  
else
DevRio:srem(storm..'Rio:Muted:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุงูุบุงุก ูุชูู ูู ุงููุฌููุนู")  
end
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),UnMuteReply)
end end
if text and (text:match('^ุงูุบุงุก ุงููุชู @(.*)') or text:match('^ุงูุบุงุก ูุชู @(.*)')) and ChCheck(msg) then
local username = text:match('^ุงูุบุงุก ุงููุชู @(.*)') or text:match('^ุงูุบุงุก ูุชู @(.*)')
function UnMuteUser(extra,result,success)
if result.id_ then
if not DevRio:sismember(storm..'Rio:Muted:'..msg.chat_id_, result.id_) then
ReplyStatus(msg,result.id_,"Reply","โ๏ธูู ููุณ ููุชูู ูุงูุบุงุก ูุชูู")  
else
DevRio:srem(storm..'Rio:Muted:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุงูุบุงุก ูุชูู ูู ุงููุฌููุนู")  
end
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,UnMuteUser)
end
if text and (text:match('^ุงูุบุงุก ุงููุชู (%d+)') or text:match('^ุงูุบุงุก ูุชู (%d+)')) and ChCheck(msg) then
local user = text:match('ุงูุบุงุก ุงููุชู (%d+)') or text:match('ุงูุบุงุก ูุชู (%d+)')
if not DevRio:sismember(storm..'Rio:Muted:'..msg.chat_id_, user) then
ReplyStatus(msg,user,"Reply","โ๏ธูู ููุณ ููุชูู ูุงูุบุงุก ูุชูู")  
else
DevRio:srem(storm..'Rio:Muted:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุงูุบุงุก ูุชูู ูู ุงููุฌููุนู")  
end
end 
end 
--     Source Storm     --
--          Tkeed           --
if Admin(msg) then
if text ==('ุชูููุฏ') or text ==('ุชููุฏ') and ChCheck(msg) then
function TkeedReply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'โ๏ธููุฏ ุชู ุชุนุทูู ุงููุชู ูุงูุชููุฏ')
return false
end
if RankChecking(result.sender_user_id_, result.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุชููุฏ โคฝ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md')
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
DevRio:sadd(storm..'Rio:Tkeed:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชููุฏู ูู ุงููุฌููุนู")  
end
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),TkeedReply)
end end
if text and (text:match('^ุชูููุฏ @(.*)') or text:match('^ุชููุฏ @(.*)')) and ChCheck(msg) then
local username = text:match('^ุชูููุฏ @(.*)') or text:match('^ุชููุฏ @(.*)')
function TkeedUser(extra,result,success)
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'โ๏ธููุฏ ุชู ุชุนุทูู ุงููุชู ูุงูุชููุฏ')
return false
end
if result.id_ then
if RankChecking(result.id_, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุชููุฏ โคฝ '..IdRank(result.id_, msg.chat_id_), 1, 'md')
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
DevRio:sadd(storm..'Rio:Tkeed:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุชููุฏู ูู ุงููุฌููุนู")  
end
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,TkeedUser)
end
if text and (text:match('^ุชูููุฏ (%d+)') or text:match('^ุชููุฏ (%d+)')) and ChCheck(msg) then
local user = text:match('ุชูููุฏ (%d+)') or text:match('ุชููุฏ (%d+)')
if not RioConstructor(msg) and DevRio:get(storm.."Rio:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'โ๏ธููุฏ ุชู ุชุนุทูู ุงููุชู ูุงูุชููุฏ')
return false
end
if RankChecking(user, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุชููุฏ โคฝ '..IdRank(user, msg.chat_id_), 1, 'md')
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..user)
DevRio:sadd(storm..'Rio:Tkeed:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุชููุฏู ูู ุงููุฌููุนู")  
end
end
--     Source Storm     --
--         UnTkeed          --
if text ==('ุงูุบุงุก ุชูููุฏ') or text ==('ุงูุบุงุก ุชููุฏ') and ChCheck(msg) then
function UnTkeedReply(extra, result, success)
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevRio:srem(storm..'Rio:Tkeed:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุงูุบุงุก ุชููุฏู ูู ุงููุฌููุนู")  
end
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),UnTkeedReply)
end end
if text and (text:match('^ุงูุบุงุก ุชูููุฏ @(.*)') or text:match('^ุงูุบุงุก ุชููุฏ @(.*)')) and ChCheck(msg) then
local username = text:match('^ุงูุบุงุก ุชูููุฏ @(.*)') or text:match('^ุงูุบุงุก ุชููุฏ @(.*)')
function UnTkeedUser(extra,result,success)
if result.id_ then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevRio:srem(storm..'Rio:Tkeed:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุงูุบุงุก ุชููุฏู ูู ุงููุฌููุนู")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,UnTkeedUser)
end
if text and (text:match('^ุงูุบุงุก ุชูููุฏ (%d+)') or text:match('^ุงูุบุงุก ุชููุฏ (%d+)')) and ChCheck(msg) then
local user = text:match('ุงูุบุงุก ุชูููุฏ (%d+)') or text:match('ุงูุบุงุก ุชููุฏ (%d+)')
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..user.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevRio:srem(storm..'Rio:Tkeed:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุงูุบุงุก ุชููุฏู ูู ุงููุฌููุนู")  
end
end 
end
--     Source Storm     --
--         BanAll         --
if SecondSudo(msg) then
if text ==('ุญุถุฑ ุนุงู') or text ==('ุญุธุฑ ุนุงู') and ChCheck(msg) then
function BanAllReply(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(storm) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ุญุธุฑ ุงูุจูุช ุนุงู*", 1, 'md')
return false 
end
if SudoId(result.sender_user_id_) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ุญุธุฑ ุงููุทูุฑ ุงูุงุณุงุณู*", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:RioSudo:',result.sender_user_id_) and not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ุญุธุฑ ุงููุทูุฑ ุงูุงุณุงุณู*", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:SecondSudo:',result.sender_user_id_) and not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ุญุธุฑ ุงููุทูุฑ ุงูุงุณุงุณูยฒ*", 1, 'md')
return false 
end
ChatKick(result.chat_id_, result.sender_user_id_)
DevRio:sadd(storm..'Rio:BanAll:', result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุญุธุฑู ุนุงู ูู ุงููุฌููุนุงุช")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),BanAllReply)
end end
if text and (text:match('^ุญุถุฑ ุนุงู @(.*)') or text:match('^ุญุธุฑ ุนุงู @(.*)')) and ChCheck(msg) then
local username = text:match('^ุญุถุฑ ุนุงู @(.*)') or text:match('^ุญุธุฑ ุนุงู @(.*)')
function BanAllUser(extra,result,success)
if tonumber(result.id_) == tonumber(storm) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ุญุธุฑ ุงูุจูุช ุนุงู*", 1, 'md')
return false 
end
if SudoId(result.id_) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ุญุธุฑ ุงููุทูุฑ ุงูุงุณุงุณู*", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:RioSudo:',result.id_) and not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ุญุธุฑ ุงููุทูุฑ ุงูุงุณุงุณู*", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:SecondSudo:',result.id_) and not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ุญุธุฑ ุงููุทูุฑ ุงูุงุณุงุณูยฒ*", 1, 'md')
return false 
end
if result.id_ then
ChatKick(msg.chat_id_, result.id_)
DevRio:sadd(storm..'Rio:BanAll:', result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุญุธุฑู ุนุงู ูู ุงููุฌููุนุงุช")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,BanAllUser)
end
if text and (text:match('^ุญุถุฑ ุนุงู (%d+)') or text:match('^ุญุธุฑ ุนุงู (%d+)')) and ChCheck(msg) then
local user = text:match('ุญุถุฑ ุนุงู (%d+)') or text:match('ุญุธุฑ ุนุงู (%d+)')
if tonumber(user) == tonumber(storm) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ุญุธุฑ ุงูุจูุช ุนุงู*", 1, 'md')
return false 
end
if SudoId(tonumber(user)) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ุญุธุฑ ุงููุทูุฑ ุงูุงุณุงุณู*", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:RioSudo:',user) and not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ุญุธุฑ ุงููุทูุฑ ุงูุงุณุงุณู*", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:SecondSudo:',user) and not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ุญุธุฑ ุงููุทูุฑ ุงูุงุณุงุณูยฒ*", 1, 'md')
return false 
end
ChatKick(msg.chat_id_, user)
DevRio:sadd(storm..'Rio:BanAll:', user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุญุธุฑู ุนุงู ูู ุงููุฌููุนุงุช")  
end
--     Source Storm     --
--         MuteAll        --
if text ==('ูุชู ุนุงู') and ChCheck(msg) then
function MuteAllReply(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(storm) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ูุชู ุงูุจูุช ุนุงู*", 1, 'md')
return false 
end
if SudoId(result.sender_user_id_) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ูุชู ุงููุทูุฑ ุงูุงุณุงุณู*", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:RioSudo:',result.sender_user_id_) and not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ูุชู ุงููุทูุฑ ุงูุงุณุงุณู*", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:SecondSudo:',result.sender_user_id_) and not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ูุชู ุงููุทูุฑ ุงูุงุณุงุณูยฒ*", 1, 'md')
return false 
end
DevRio:sadd(storm..'Rio:MuteAll:', result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ูุชูู ุนุงู ูู ุงููุฌููุนุงุช")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),MuteAllReply)
end end
if text and text:match('^ูุชู ุนุงู @(.*)') and ChCheck(msg) then
local username = text:match('^ูุชู ุนุงู @(.*)')
function MuteAllUser(extra,result,success)
if tonumber(result.id_) == tonumber(storm) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ูุชู ุงูุจูุช ุนุงู*", 1, 'md')
return false 
end
if SudoId(result.id_) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ูุชู ุงููุทูุฑ ุงูุงุณุงุณู*", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:RioSudo:',result.id_) and not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ูุชู ุงููุทูุฑ ุงูุงุณุงุณู*", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:SecondSudo:',result.id_) and not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ูุชู ุงููุทูุฑ ุงูุงุณุงุณูยฒ*", 1, 'md')
return false 
end
if result.id_ then
DevRio:sadd(storm..'Rio:MuteAll:', result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ูุชูู ุนุงู ูู ุงููุฌููุนุงุช")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,MuteAllUser)
end
if text and text:match('^ูุชู ุนุงู (%d+)') and ChCheck(msg) then
local user = text:match('ูุชู ุนุงู (%d+)')
if tonumber(user) == tonumber(storm) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ูุชู ุงูุจูุช ุนุงู*", 1, 'md')
return false 
end
if SudoId(tonumber(user)) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ูุชู ุงููุทูุฑ ุงูุงุณุงุณู*", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:RioSudo:',user) and not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ูุชู ุงููุทูุฑ ุงูุงุณุงุณู*", 1, 'md')
return false 
end
if DevRio:sismember(storm..'Rio:SecondSudo:',user) and not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชุณุชุทูุน ูุชู ุงููุทูุฑ ุงูุงุณุงุณูยฒ*", 1, 'md')
return false 
end
DevRio:sadd(storm..'Rio:MuteAll:', user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ูุชูู ุนุงู ูู ุงููุฌููุนุงุช")  
end
--     Source Storm     --
--         UnAll          --
if text ==('ุงูุบุงุก ุนุงู') or text ==('ุงูุบุงุก ุงูุนุงู') and ChCheck(msg) then
function UnAllReply(extra, result, success)
DevRio:srem(storm..'Rio:BanAll:', result.sender_user_id_)
DevRio:srem(storm..'Rio:MuteAll:', result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุงูุบุงุก (ุงูุญุธุฑ โข ุงููุชู) ุนุงู ูู ุงููุฌููุนุงุช")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),UnAllReply)
end end
if text and (text:match('^ุงูุบุงุก ุนุงู @(.*)') or text:match('^ุงูุบุงุก ุงูุนุงู @(.*)')) and ChCheck(msg) then
local username = text:match('^ุงูุบุงุก ุนุงู @(.*)') or text:match('^ุงูุบุงุก ุงูุนุงู @(.*)')
function UnAllUser(extra,result,success)
if result.id_ then
DevRio:srem(storm..'Rio:BanAll:', result.id_)
DevRio:srem(storm..'Rio:MuteAll:', result.id_)
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุงูุบุงุก (ุงูุญุธุฑ โข ุงููุชู) ุนุงู ูู ุงููุฌููุนุงุช")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
end end 
resolve_username(username,UnAllUser)
end
if text and (text:match('^ุงูุบุงุก ุนุงู (%d+)') or text:match('^ุงูุบุงุก ุงูุนุงู (%d+)')) and ChCheck(msg) then
local user = text:match('ุงูุบุงุก ุนุงู (%d+)') or text:match('ุงูุบุงุก ุงูุนุงู (%d+)')
DevRio:srem(storm..'Rio:BanAll:', user)
DevRio:srem(storm..'Rio:MuteAll:', user)
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุงูุบุงุก (ุงูุญุธุฑ โข ุงููุชู) ุนุงู ูู ุงููุฌููุนุงุช")  
end
end
end
--     Source Storm     --
if (text == "ุชุบูุฑ ุงููุทูุฑ ุงูุงุณุงุณู" or text == "ููู ููููู ุงูุจูุช" or text == "ุชุบููุฑ ุงููุทูุฑ ุงูุงุณุงุณู" or text == "โคฝ ุชุบูุฑ ุงููุทูุฑ ุงูุงุณุงุณู โ") and msg.reply_to_message_id_ == 0 and Sudo(msg) and ChCheck(msg) then 
send(msg.chat_id_, msg.id_,'โ๏ธูุฌุจ ุงูุชุงูุฏ ุงู ุงููุทูุฑ ุงูุฌุฏูุฏ ุงุฑุณู start ูุฎุงุต ุงูุจูุช ุจุนุฏ ุฐูู ููููู ุงุฑุณุงู ุงูุฏู ุงููุทูุฑ')
DevRio:setex(storm.."Rio:EditDev"..msg.sender_user_id_,300,true)
end
if DevRio:get(storm.."Rio:EditDev"..msg.sender_user_id_) then
if text and text:match("^ุงูุบุงุก$") then 
send(msg.chat_id_, msg.id_,'โ๏ธุชู ุงูุบุงุก ุงูุฑ ุชุบูุฑ ุงููุทูุฑ ุงูุงุณุงุณู')
DevRio:del(storm.."Rio:EditDev"..msg.sender_user_id_)
return false
end
if text and text:match("^(%d+)$") then 
tdcli_function ({ID = "GetUser",user_id_ = text},function(arg,dp) 
if dp.first_name_ ~= false then
DevRio:del(storm.."Rio:EditDev"..msg.sender_user_id_)
DevRio:set(storm.."Rio:NewDev"..msg.sender_user_id_,dp.id_)
if dp.username_ ~= false then DevUser = '\nโ๏ธุงููุนุฑู โคฝ [@'..dp.username_..']' else DevUser = '' end
local Text = 'โ๏ธุงูุงูุฏู โคฝ '..dp.id_..DevUser..'\nโ๏ธุงูุงุณู โคฝ ['..dp.first_name_..'](tg://user?id='..dp.id_..')\nโ๏ธุชู ุญูุธ ุงููุนูููุงุช ุจูุฌุงุญ\nโ๏ธุงุณุชุฎุฏู ุงูุงุฒุฑุงุฑ ููุชุงููุฏ โคฝ โค'
keyboard = {} 
keyboard.inline_keyboard = {{{text="ูุนู",callback_data="/setyes"},{text="ูุง",callback_data="/setno"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,"โ๏ธุงููุนูููุงุช ุฎุงุทุฆู ูู ุจุงูุชุงูุฏ ูุงุนุฏ ุงููุญุงููู")
DevRio:del(storm.."Rio:EditDev"..msg.sender_user_id_)
end
end,nil)
return false
end
end
--     Source Storm     --
if msg.reply_to_message_id_ ~= 0 then
if text and text:match("^ุฑูุน ูุทู$") and not DevRio:get(storm..'Rio:Lock:Stupid'..msg.chat_id_) and ChCheck(msg) then
function donky_by_reply(extra, result, success)
if DevRio:sismember(storm..'User:Donky:'..msg.chat_id_, result.sender_user_id_) then
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธูู ูุทู ุดุฑูุน ููู ุจุนุฏ๐น๐") 
else
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุนู ูู ูุงุฆูุฉ ุงููุทุงูู") 
DevRio:sadd(storm..'User:Donky:'..msg.chat_id_, result.sender_user_id_)
end end
getMessage(msg.chat_id_, msg.reply_to_message_id_,donky_by_reply)
end end
--     Source Storm     --
if msg.reply_to_message_id_ ~= 0  then
if text and text:match("^ุชูุฒูู ูุทู$") and not DevRio:get(storm..'Rio:Lock:Stupid'..msg.chat_id_) and ChCheck(msg) then
function donky_by_reply(extra, result, success)
if not DevRio:sismember(storm..'User:Donky:'..msg.chat_id_, result.sender_user_id_) then
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธูู ููุณ ูุทู ููุชู ุชูุฒููู") 
else
DevRio:srem(storm..'User:Donky:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชูุฒููู ูู ูุงุฆูุฉ ุงููุทุงูู") 
end end
getMessage(msg.chat_id_, msg.reply_to_message_id_,donky_by_reply)
end end
--     Source Storm     --
if Admin(msg) then
if text and (text:match('^ุชูููุฏ ุฏูููู (%d+)$') or text:match('^ูุชู ุฏูููู (%d+)$') or text:match('^ุชููุฏ ุฏูููู (%d+)$')) and ChCheck(msg) then 
local function mut_time(extra, result,success)
local mutept = text:match('^ุชูููุฏ ุฏูููู (%d+)$') or text:match('^ูุชู ุฏูููู (%d+)$') or text:match('^ุชููุฏ ุฏูููู (%d+)$')
local Minutes = string.gsub(mutept, 'm', '')
local num1 = tonumber(Minutes) * 60 
if RankChecking(result.sender_user_id_, msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุชููุฏ โคฝ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md') 
else 
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+num1))
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชููุฏู ููุฏุฉ โคฝ "..mutept.." ุฏ") 
DevRio:sadd(storm..'Rio:Tkeed:'..msg.chat_id_, result.sender_user_id_)
end end 
if tonumber(msg.reply_to_message_id_) == 0 then else
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, mut_time,nil) end 
end
if text and (text:match('^ุชูููุฏ ุณุงุนู (%d+)$') or text:match('^ูุชู ุณุงุนู (%d+)$') or text:match('^ุชููุฏ ุณุงุนู (%d+)$')) and ChCheck(msg) then 
local function mut_time(extra, result,success)
local mutept = text:match('^ุชูููุฏ ุณุงุนู (%d+)$') or text:match('^ูุชู ุณุงุนู (%d+)$') or text:match('^ุชููุฏ ุณุงุนู (%d+)$')
local hour = string.gsub(mutept, 'h', '')
local num1 = tonumber(hour) * 3600 
if RankChecking(result.sender_user_id_, msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุชููุฏ โคฝ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md') 
else 
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+num1))
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชููุฏู ููุฏุฉ โคฝ "..mutept.." ุณ") 
DevRio:sadd(storm..'Rio:Tkeed:'..msg.chat_id_, result.sender_user_id_)
end end
if tonumber(msg.reply_to_message_id_) == 0 then else
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, mut_time,nil) end 
end 
if text and (text:match('^ุชูููุฏ ููู (%d+)$') or text:match('^ูุชู ููู (%d+)$') or text:match('^ุชููุฏ ููู (%d+)$')) and ChCheck(msg) then 
local function mut_time(extra, result,success)
local mutept = text:match('^ุชูููุฏ ููู (%d+)$') or text:match('^ูุชู ููู (%d+)$') or text:match('^ุชููุฏ ููู (%d+)$')
local day = string.gsub(mutept, 'd', '')
local num1 = tonumber(day) * 86400 
if RankChecking(result.sender_user_id_, msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชุณุชุทูุน ุชููุฏ โคฝ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md') 
else 
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+num1))
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุชููุฏู ููุฏุฉ โคฝ "..mutept.." ู") 
DevRio:sadd(storm..'Rio:Tkeed:'..msg.chat_id_, result.sender_user_id_)
end end
if tonumber(msg.reply_to_message_id_) == 0 then else
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, mut_time,nil) end 
end 
end 
--     Source Storm     --
if text and text:match("^ุงุถู ุฑุณุงุฆู (%d+)$") and msg.reply_to_message_id_ == 0 and ChCheck(msg) then  
if Constructor(msg) then
TXT = text:match("^ุงุถู ุฑุณุงุฆู (%d+)$")
DevRio:set('stormTeam:'..storm..'id:user'..msg.chat_id_,TXT)  
DevRio:setex('stormTeam:'..storm.."numadd:user"..msg.chat_id_.."" .. msg.sender_user_id_, 300, true)  
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ุนุฏุฏ ุงูุฑุณุงุฆู ุงูุงู \nโ๏ธุงุฑุณู ุงูุบุงุก ูุงูุบุงุก ุงูุงูุฑ ", 1, "md")
Dev_Rio(msg.chat_id_, msg.id_, 1,numd, 1, 'md') 
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุฐุง ุงูุงูุฑ ููููุดุฆูู ููุท', 1, 'md') 
end 
end 
if text and text:match("^ุงุถู ุฑุณุงุฆู (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^ุงุถู ุฑุณุงุฆู (%d+)$")
function Reply(extra, result, success)
DevRio:del(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..result.sender_user_id_) 
DevRio:incrby(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..result.sender_user_id_,Num) 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงุถุงูุฉ "..Num..' ุฑุณุงูู', 1, 'md') 
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},Reply, nil)
return false
end
if text and text:match("^ุงุถู ููุงุท (%d+)$") and msg.reply_to_message_id_ == 0 and ChCheck(msg) then  
if Constructor(msg) then
TXT = text:match("^ุงุถู ููุงุท (%d+)$")
DevRio:set('stormTeam:'..storm..'ids:user'..msg.chat_id_,TXT)  
DevRio:setex('stormTeam:'..storm.."nmadd:user"..msg.chat_id_.."" .. msg.sender_user_id_, 300, true)  
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ุนุฏุฏ ุงูููุงุท ุงูุงู \nโ๏ธุงุฑุณู ุงูุบุงุก ูุงูุบุงุก ุงูุงูุฑ ", 1, "md")
Dev_Rio(msg.chat_id_, msg.id_, 1,numd, 1, 'md') 
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุฐุง ุงูุงูุฑ ููููุดุฆูู ููุท', 1, 'md') 
end 
end 
if text and text:match("^ุงุถู ููุงุท (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^ุงุถู ููุงุท (%d+)$")
function Reply(extra, result, success)
DevRio:incrby(storm..'Rio:GamesNumber'..msg.chat_id_..result.sender_user_id_,Num) 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงุถุงูุฉ "..Num..' ููุทู', 1, 'md') 
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},Reply, nil)
return false
end
if DevRio:get(storm..'Rio:Lock:Clean'..msg.chat_id_) then if msg.content_.video_ or msg.content_.document_ or msg.content_.sticker_ or msg.content_.photo_ or msg.content_.animation_ or msg.content_.animated_ then if msg.reply_to_message_id_ ~= 0 then DevRio:sadd(storm.."Rio:cleaner"..msg.chat_id_, msg.id_) else DevRio:sadd(storm.."Rio:cleaner"..msg.chat_id_, msg.id_) end end end
if DevRio:get(storm..'Rio:Lock:CleanNum'..msg.chat_id_) then if msg.content_.video_ or msg.content_.document_ or msg.content_.sticker_ or msg.content_.photo_ or msg.content_.animation_ or msg.content_.animated_ then if msg.reply_to_message_id_ ~= 0 then DevRio:sadd(storm.."Rio:cleanernum"..msg.chat_id_, msg.id_) else DevRio:sadd(storm.."Rio:cleanernum"..msg.chat_id_, msg.id_) end end end
if Manager(msg) and msg.reply_to_message_id_ ~= 0 then
if text and text:match("^ุชุซุจูุช$") and ChCheck(msg) then 
if DevRio:sismember(storm.."Rio:Lock:Pinpin",msg.chat_id_) and not BasicConstructor(msg) then
Dev_Rio(msg.chat_id_,msg.id_, 1, "โ๏ธุงูุชุซุจูุช ูุงูุบุงุก ูุงุนุงุฏุฉ ุงูุชุซุจูุช ุชู ูููู ูู ูุจู ุงูููุดุฆูู ุงูุงุณุงุณููู", 1, 'md')
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100",""),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
DevRio:set(storm..'Rio:PinnedMsg'..msg.chat_id_,msg.reply_to_message_id_)
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุซุจูุช ุงูุฑุณุงูู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
return false  
end
if data.code_ == 6 then
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุงูุจูุช ููุณ ุงุฏูู ููุง !', 1, 'md')
return false  
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธููุณุช ูุฏู ุตูุงุญูุฉ ุงูุชุซุจูุช ูุฑุฌู ุงูุชุญูู ูู ุงูุตูุงุญูุงุช', 1, 'md')
return false  
end
end,nil)
end 
end
--     Source Storm     --
if Admin(msg) then
if text == "ุงููููุฒูู" and ChCheck(msg) then 
local List = DevRio:smembers(storm..'Rio:VipMem:'..msg.chat_id_)
text = "โ๏ธูุงุฆูุฉ ุงููููุฒูู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "โ๏ธ*ูุง ููุฌุฏ ูููุฒูู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end end 
--     Source Storm     --
if Manager(msg) then
if text == "ุงูุงุฏูููู" and ChCheck(msg) or text == "ุงูุงุฏูููุฉ" and ChCheck(msg) then 
local rio =  'Rio:Admins:'..msg.chat_id_
local List = DevRio:smembers(storm..rio)
text = "โ๏ธูุงุฆูุฉ ุงูุงุฏูููู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "โ๏ธ*ูุง ููุฌุฏ ุงุฏูููู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end end
--     Source Storm     -- 
if Constructor(msg) then
if text == "ุงููุฏุฑุงุก" and ChCheck(msg) or text == "ูุฏุฑุงุก" and ChCheck(msg) then 
local List = DevRio:smembers(storm..'Rio:Managers:'..msg.chat_id_)
text = "โ๏ธูุงุฆูุฉ ุงููุฏุฑุงุก โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "โ๏ธ*ูุง ููุฌุฏ ูุฏุฑุงุก*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
if text == "ุงูููุธููู" and ChCheck(msg) then 
local List = DevRio:smembers(storm..'Rio:Cleaner:'..msg.chat_id_)
text = "โ๏ธูุงุฆูุฉ ุงูููุธููู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "โ๏ธ*ูุง ููุฌุฏ ููุธููู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end end 
--     Source Storm     --
if BasicConstructor(msg) then
if text == "ุงูููุดุฆูู" and ChCheck(msg) then 
local List = DevRio:smembers(storm..'Rio:Constructor:'..msg.chat_id_)
text = "โ๏ธูุงุฆูุฉ ุงูููุดุฆูู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "โ๏ธ*ูุง ููุฌุฏ ููุดุฆูู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end end 
--     Source Storm     --
if RioConstructor(msg) then
if text == "ุงููุงูููู" and ChCheck(msg) then 
local List = DevRio:smembers(storm..'Rio:RioConstructor:'..msg.chat_id_)
text = "โ๏ธูุงุฆูุฉ ุงููุงูููู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "โ๏ธ*ูุง ููุฌุฏ ูุงูููู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
if text == "ุงูููุดุฆูู ุงูุงุณุงุณููู" and ChCheck(msg) or text == "ููุดุฆูู ุงุณุงุณููู" and ChCheck(msg) or text == "ุงูููุดุฆูู ุงูุงุณุงุณูู" and ChCheck(msg) then 
local List = DevRio:smembers(storm..'Rio:BasicConstructor:'..msg.chat_id_)
text = "โ๏ธูุงุฆูุฉ ุงูููุดุฆูู ุงูุงุณุงุณููู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "โ๏ธ*ูุง ููุฌุฏ ููุดุฆูู ุงุณุงุณููู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
end 
if text ==("ุงูููุดุฆ") and ChCheck(msg) or text ==("ุงููุงูู") and ChCheck(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
Manager_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = Manager_id},function(arg,dp) 
if dp.first_name_ == false then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุญุณุงุจ ุงูููุดุฆ ูุญุฐูู", 1, "md")
return false  
end
local UserName = (dp.username_ or "So_ST0RM")
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุงูู ุงููุฌููุนู โคฝ ["..dp.first_name_.."](T.me/"..UserName..")", 1, "md")  
end,nil)   
end
end
end,nil)   
end
--     Source Storm     --
if Admin(msg) then
if text == "ุงูููุชูููู" and ChCheck(msg) then 
local List = DevRio:smembers(storm..'Rio:Muted:'..msg.chat_id_)
text = "โ๏ธูุงุฆูุฉ ุงูููุชูููู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "โ๏ธ*ูุง ููุฌุฏ ููุชูููู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
--     Source Storm     --
if text == "ุงููููุฏูู" and ChCheck(msg) then 
local List = DevRio:smembers(storm..'Rio:Tkeed:'..msg.chat_id_)
text = "โ๏ธูุงุฆูุฉ ุงููููุฏูู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "โ๏ธ*ูุง ููุฌุฏ ูููุฏูู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
--     Source Storm     --
if text == "ุงููุญุธูุฑูู" and ChCheck(msg) or text == "ุงููุญุถูุฑูู" and ChCheck(msg) then 
local List = DevRio:smembers(storm..'Rio:Ban:'..msg.chat_id_)
text = "โ๏ธูุงุฆูุฉ ุงููุญุธูุฑูู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "โ๏ธ*ูุง ููุฌุฏ ูุญุธูุฑูู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
if text == "ูุงุฆูู ุงูููุน" and ChCheck(msg) then
local List = DevRio:hkeys(storm..'Rio:Filters:'..msg.chat_id_)
text = "โ๏ธูุงุฆูุฉ ุงูููุน โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k, v in pairs(List) do
text = text..k..'~ โจ '..v..' โฉ\n'
end
if #List == 0 then
text = "โ๏ธูุง ุชูุฌุฏ ูููุงุช ููููุนู"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, 'md')
end
end 
--     Source Storm     --
if text == "ุงููุทุงูู" and ChCheck(msg) or text == "ุงููุทุงูุฉ" and ChCheck(msg) then
local List = DevRio:smembers(storm..'User:Donky:'..msg.chat_id_)
text = "โ๏ธูุงุฆูุฉ ูุทุงูุฉ ุงููุฌููุนู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "โ๏ธ*ูุง ููุฌุฏ ูุทุงูู ูููุง ุงูุงุฏู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end
--     Source Storm     --
if text == "ุงููุทูุฑูู ุงูุงุณุงุณููู" and ChCheck(msg) and RioSudo(msg) or text == "ุงูุงุณุงุณููู" and RioSudo(msg) and ChCheck(msg) or text == "โคฝ ุงูุงุณุงุณููู โ" and RioSudo(msg) and ChCheck(msg) then 
local List = DevRio:smembers(storm..'Rio:RioSudo:')
text = "โ๏ธูุงุฆูุฉ ุงููุทูุฑูู ุงูุงุณุงุณููู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..""..k.."~ : [@"..username.."]\n"
else
text = text..""..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "โ๏ธ*ุนุฐุฑุง ูู ูุชู ุฑูุน ุงู ูุทูุฑูู ุงุณุงุณููู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
--     Source Storm     --
if text == "ุงููุทูุฑูู ุงูุซุงููููู" and SecondSudo(msg) and ChCheck(msg) or text == "ุงูุซุงููููู" and SecondSudo(msg) and ChCheck(msg) or text == "โคฝ ุงูุซุงููููู โ" and SecondSudo(msg) and ChCheck(msg) then 
local List = DevRio:smembers(storm..'Rio:SecondSudo:')
text = "โ๏ธูุงุฆูุฉ ุงููุทูุฑูู ุงูุซุงููููู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "โ๏ธ*ุนุฐุฑุง ูู ูุชู ุฑูุน ุงู ูุทูุฑูู ุซุงููููู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
--     Source Storm     --
if SudoBot(msg) then
if text == "ูุงุฆูู ุงูุนุงู" and ChCheck(msg) or text == "ุงููุญุธูุฑูู ุนุงู" and ChCheck(msg) or text == "ุงูููุชูููู ุนุงู" and ChCheck(msg) or text == "โคฝ ูุงุฆูู ุงูุนุงู โ" and ChCheck(msg) or text == "โคฝ ูุงุฆูู ุงูุนุงู โ" and ChCheck(msg) then 
local BanAll = DevRio:smembers(storm..'Rio:BanAll:')
local MuteAll = DevRio:smembers(storm..'Rio:MuteAll:')
if #BanAll ~= 0 then 
text = "โ๏ธูุงุฆูุฉ ุงููุญุธูุฑูู ุนุงู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(BanAll) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
else
text = ""
end
if #MuteAll ~= 0 then 
text = text.."โ๏ธูุงุฆูุฉ ุงูููุชูููู ุนุงู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(MuteAll) do
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
else
text = text
end
if #BanAll ~= 0 or #MuteAll ~= 0 then 
text = text
else
text = "โ๏ธ*ูู ูุชู ุญุธุฑ ุงู ูุชู ุงู ุนุถู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
--     Source Storm     --
if text == "ุงููุทูุฑูู" and ChCheck(msg) or text == "โคฝ ุงููุทูุฑูู โ" and ChCheck(msg) then 
local List = DevRio:smembers(storm..'Rio:SudoBot:')
text = "โ๏ธูุงุฆูุฉ ุงููุทูุฑูู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local sudouser = DevRio:get(storm..'Rio:Sudos'..v) 
local username = DevRio:get(storm..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."] โฌ Gps : "..(sudouser or 0).."\n"
else
text = text..k.."~ : `"..v.."` โฌ Gps : "..(sudouser or 0).."\n"
end end
if #List == 0 then
text = "โ๏ธ*ุนุฐุฑุง ูู ูุชู ุฑูุน ุงู ูุทูุฑูู*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end
--     Source Storm     --
if text ==("ุฑูุน ุงูููุดุฆ") and ChCheck(msg) or text ==("ุฑูุน ุงููุงูู") and ChCheck(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
Manager_id = admins[i].user_id_
end
end
tdcli_function ({ID = "GetUser",user_id_ = Manager_id},function(arg,dp) 
if dp.first_name_ == false then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุญุณุงุจ ุงูููุดุฆ ูุญุฐูู", 1, "md")
return false  
end
local UserName = (dp.username_ or "So_ST0RM")
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุฑูุน ูุงูู ุงููุฌููุนู โคฝ ["..dp.first_name_.."](T.me/"..UserName..")", 1, "md") 
DevRio:sadd(storm.."Rio:RioConstructor:"..msg.chat_id_,dp.id_)
end,nil)   
end,nil)   
end
end 
--     Source Storm     --
if Manager(msg) then
if text == 'ููุน' and tonumber(msg.reply_to_message_id_) > 0 and ChCheck(msg) then 
function filter_by_reply(extra, result, success) 
if result.content_.sticker_ then
local idsticker = result.content_.sticker_.sticker_.persistent_id_
DevRio:sadd(storm.."Rio:FilterSteckr"..msg.chat_id_,idsticker)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ููุน ุงูููุตู ุจูุฌุงุญ ูู ูุชู ุงุฑุณุงูู ูุฌุฏุฏุง', 1, 'md')
return false
end
if result.content_.ID == "MessagePhoto" then
local photo = result.content_.photo_.id_
DevRio:sadd(storm.."Rio:FilterPhoto"..msg.chat_id_,photo)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ููุน ุงูุตูุฑู ุจูุฌุงุญ ูู ูุชู ุงุฑุณุงููุง ูุฌุฏุฏุง', 1, 'md')
return false
end
if result.content_.animation_ then
local idanimation = result.content_.animation_.animation_.persistent_id_
DevRio:sadd(storm.."Rio:FilterAnimation"..msg.chat_id_,idanimation)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ููุน ุงููุชุญุฑูู ุจูุฌุงุญ ูู ูุชู ุงุฑุณุงููุง ูุฌุฏุฏุง', 1, 'md')
return false
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,filter_by_reply) 
end
--     Source Storm     --
if text == 'ุงูุบุงุก ููุน' and tonumber(msg.reply_to_message_id_) > 0 and ChCheck(msg) then     
function unfilter_by_reply(extra, result, success) 
if result.content_.sticker_ then
local idsticker = result.content_.sticker_.sticker_.persistent_id_
DevRio:srem(storm.."Rio:FilterSteckr"..msg.chat_id_,idsticker)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ููุน ุงูููุตู ูููููู ุงุฑุณุงูู ุงูุงู', 1, 'md')
return false
end
if result.content_.ID == "MessagePhoto" then
local photo = result.content_.photo_.id_
DevRio:srem(storm.."Rio:FilterPhoto"..msg.chat_id_,photo)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ููุน ุงูุตูุฑู ูููููู ุงุฑุณุงููุง ุงูุงู', 1, 'md')
return false
end
if result.content_.animation_.animation_ then
local idanimation = result.content_.animation_.animation_.persistent_id_
DevRio:srem(storm.."Rio:FilterAnimation"..msg.chat_id_,idanimation)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ููุน ุงููุชุญุฑูู ูููููู ุงุฑุณุงููุง ุงูุงู', 1, 'md')
return false
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,unfilter_by_reply) 
end
end
--     Source Storm     --
if text and (text == "ุชูุนูู ุชุญููู ุงูุตูุบ" or text == "ุชูุนูู ุงูุชุญููู") and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุชุญููู ุงูุตูุบ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Thwel:Rio'..msg.chat_id_) 
end
if text and (text == "ุชุนุทูู ุชุญููู ุงูุตูุบ" or text == "ุชุนุทูู ุงูุชุญููู") and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุชุญููู ุงูุตูุบ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Thwel:Rio'..msg.chat_id_,true)  
end
if text == 'ุชุญููู' and not DevRio:get(storm..'Rio:Thwel:Rio'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then 
function ThwelByReply(extra, result, success)
if result.content_.photo_ then 
local Rio = json:decode(https.request('https://api.telegram.org/bot'.. TokenBot..'/getfile?file_id='..result.content_.photo_.sizes_[1].photo_.persistent_id_)) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..Rio.result.file_path,msg.sender_user_id_..'.png') 
sendSticker(msg.chat_id_, msg.id_, 0, 1,nil, './'..msg.sender_user_id_..'.png')
os.execute('rm -rf ./'..msg.sender_user_id_..'.png') 
end   
if result.content_.sticker_ then 
local Rio = json:decode(https.request('https://api.telegram.org/bot'.. TokenBot..'/getfile?file_id='..result.content_.sticker_.sticker_.persistent_id_)) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..Rio.result.file_path,msg.sender_user_id_..'.jpg') 
sendPhoto(msg.chat_id_, msg.id_, 0, 1,nil, './'..msg.sender_user_id_..'.jpg','โ๏ธุชู ุชุญููู ุงูููุตู ุงูู ุตูุฑู')     
os.execute('rm -rf ./'..msg.sender_user_id_..'.jpg') 
end
if result.content_.audio_ then 
local Rio = json:decode(https.request('https://api.telegram.org/bot'.. TokenBot..'/getfile?file_id='..result.content_.audio_.audio_.persistent_id_)) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..Rio.result.file_path,msg.sender_user_id_..'.ogg') 
sendVoice(msg.chat_id_, msg.id_, 0, 1,nil, './'..msg.sender_user_id_..'.ogg',"โ๏ธุชู ุชุญููู ุงููMp3 ุงูู ุจุตูู")
os.execute('rm -rf ./'..msg.sender_user_id_..'.ogg') 
end   
if result.content_.voice_ then 
local Rio = json:decode(https.request('https://api.telegram.org/bot'.. TokenBot..'/getfile?file_id='..result.content_.voice_.voice_.persistent_id_)) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..Rio.result.file_path,msg.sender_user_id_..'.mp3') 
sendAudio(msg.chat_id_, msg.id_, 0, 1,nil, './'..msg.sender_user_id_..'.mp3')  
os.execute('rm -rf ./'..msg.sender_user_id_..'.mp3') 
end
end
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ThwelByReply) 
end
end
--     Source Storm     --
if text ==("ูุดู") and msg.reply_to_message_id_ ~= 0 and ChCheck(msg) or text ==("ุงูุฏู") and msg.reply_to_message_id_ ~= 0 and ChCheck(msg) then 
function id_by_reply(extra, result, success) 
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local user_msgs = DevRio:get(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..data.id_) or 0
local user_nkt = tonumber(DevRio:get(storm..'Rio:GamesNumber'..msg.chat_id_..data.id_) or 0)
if DevRio:sismember(storm..'Rio:BanAll:',result.sender_user_id_) then
Tkeed = 'ูุญุธูุฑ ุนุงู'
elseif DevRio:sismember(storm..'Rio:MuteAll:',result.sender_user_id_) then
Tkeed = 'ููุชูู ุนุงู'
elseif DevRio:sismember(storm..'Rio:Ban:'..msg.chat_id_,result.sender_user_id_) then
Tkeed = 'ูุญุธูุฑ'
elseif DevRio:sismember(storm..'Rio:Muted:'..msg.chat_id_,result.sender_user_id_) then
Tkeed = 'ููุชูู'
elseif DevRio:sismember(storm..'Rio:Tkeed:'..msg.chat_id_,result.sender_user_id_) then
Tkeed = 'ูููุฏ'
else
Tkeed = false
end
if Tkeed ~= false then
Tked = '\nโ๏ธุงููููุฏ โคฝ '..Tkeed
else 
Tked = '' 
end
if DevRio:sismember(storm..'Rio:SudoBot:',result.sender_user_id_) and SudoBot(msg) then
sudobot = '\nโ๏ธุนุฏุฏ ุงูุฌุฑูุจุงุช โคฝ '..(DevRio:get(storm..'Rio:Sudos'..result.sender_user_id_) or 0)..'' 
else 
sudobot = '' 
end
if GetCustomTitle(result.sender_user_id_,msg.chat_id_) ~= false then
CustomTitle = '\nโ๏ธููุจู โคฝ '..GetCustomTitle(result.sender_user_id_,msg.chat_id_)
else 
CustomTitle = '' 
end
if data.first_name_ == false then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุงูุญุณุงุจ ูุญุฐูู', 1, 'md')
return false  end
if data.username_ == false then
Text = 'โ๏ธุงุณูู โคฝ ['..data.first_name_..'](tg://user?id='..result.sender_user_id_..')\nโ๏ธุงูุฏูู โคฝ โจ `'..result.sender_user_id_..'` โฉ\nโ๏ธุฑุชุจุชู โคฝ '..IdRank(result.sender_user_id_, msg.chat_id_)..sudobot..'\nโ๏ธุฑุณุงุฆูู โคฝ โจ '..user_msgs..' โฉ\nโ๏ธุชูุงุนูู โคฝ '..formsgs(user_msgs)..CustomTitle..'\nโ๏ธููุงุทู โคฝ โจ '..user_nkt..' โฉ'..Tked
SendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุนุฑูู โคฝ [@'..data.username_..']\nโ๏ธุงูุฏูู โคฝ โจ `'..result.sender_user_id_..'` โฉ\nโ๏ธุฑุชุจุชู โคฝ '..IdRank(result.sender_user_id_, msg.chat_id_)..sudobot..'\nโ๏ธุฑุณุงุฆูู โคฝ โจ '..user_msgs..' โฉ\nโ๏ธุชูุงุนูู โคฝ '..formsgs(user_msgs)..CustomTitle..'\nโ๏ธููุงุทู โคฝ โจ '..user_nkt..' โฉ'..Tked, 1, 'md')
end
end,nil)
end 
getMessage(msg.chat_id_, msg.reply_to_message_id_,id_by_reply) 
end
if text and text:match('^ูุดู @(.*)') and ChCheck(msg) or text and text:match('^ุงูุฏู @(.*)') and ChCheck(msg) then 
local username = text:match('^ูุดู @(.*)') or text:match('^ุงูุฏู @(.*)')
tdcli_function ({ID = "SearchPublicChat",username_ = username},function(extra, res, success) 
if res and res.message_ and res.message_ == "USERNAME_NOT_OCCUPIED" then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')
return false  end
if res.type_.ID == "ChannelChatInfo" then 
if res.type_.channel_.is_supergroup_ == false then
local ch = 'ููุงุฉ'
local chn = 'โ๏ธููุน ุงูุญุณุงุจ โคฝ โจ '..ch..' โฉ\nโ๏ธุงูุงูุฏู โคฝ โจ `'..res.id_..'` โฉ\nโ๏ธุงููุนุฑู โคฝ โจ [@'..username..'] โฉ\nโ๏ธุงูุงุณู โคฝ โจ ['..res.title_..'] โฉ'
Dev_Rio(msg.chat_id_, msg.id_, 1,chn, 1, 'md')
else
local gr = 'ูุฌููุนู'
local grr = 'โ๏ธููุน ุงูุญุณุงุจ โคฝ โจ '..gr..' โฉ\nโ๏ธุงูุงูุฏู โคฝ โจ '..res.id_..' โฉ\nโ๏ธุงููุนุฑู โคฝ โจ [@'..username..'] โฉ\nโ๏ธุงูุงุณู โคฝ โจ ['..res.title_..'] โฉ'
Dev_Rio(msg.chat_id_, msg.id_, 1,grr, 1, 'md')
end
return false  end
if res.id_ then  
tdcli_function ({ID = "GetUser",user_id_ = res.id_},function(arg,data) 
local user_msgs = DevRio:get(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..res.id_) or 0
local user_nkt = tonumber(DevRio:get(storm..'Rio:GamesNumber'..msg.chat_id_..res.id_) or 0)
if DevRio:sismember(storm..'Rio:BanAll:',res.id_) then
Tkeed = 'ูุญุธูุฑ ุนุงู'
elseif DevRio:sismember(storm..'Rio:MuteAll:',res.id_) then
Tkeed = 'ููุชูู ุนุงู'
elseif DevRio:sismember(storm..'Rio:Ban:'..msg.chat_id_,res.id_) then
Tkeed = 'ูุญุธูุฑ'
elseif DevRio:sismember(storm..'Rio:Muted:'..msg.chat_id_,res.id_) then
Tkeed = 'ููุชูู'
elseif DevRio:sismember(storm..'Rio:Tkeed:'..msg.chat_id_,res.id_) then
Tkeed = 'ูููุฏ'
else
Tkeed = false
end
if Tkeed ~= false then
Tked = '\nโ๏ธุงููููุฏ โคฝ '..Tkeed
else 
Tked = '' 
end
if DevRio:sismember(storm..'Rio:SudoBot:',res.id_) and SudoBot(msg) then
sudobot = '\nโ๏ธุนุฏุฏ ุงูุฌุฑูุจุงุช โคฝ '..(DevRio:get(storm..'Rio:Sudos'..res.id_) or 0)..'' 
else 
sudobot = '' 
end
if GetCustomTitle(res.id_,msg.chat_id_) ~= false then
CustomTitle = '\nโ๏ธููุจู โคฝ '..GetCustomTitle(res.id_,msg.chat_id_)
else 
CustomTitle = '' 
end
if data.first_name_ == false then
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุงูุญุณุงุจ ูุญุฐูู', 1, 'md')
return false  end
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุนุฑูู โคฝ [@'..data.username_..']\nโ๏ธุงูุฏูู โคฝ โจ `'..res.id_..'` โฉ\nโ๏ธุฑุชุจุชู โคฝ '..IdRank(res.id_, msg.chat_id_)..sudobot..'\nโ๏ธุฑุณุงุฆูู โคฝ โจ '..user_msgs..' โฉ\nโ๏ธุชูุงุนูู โคฝ '..formsgs(user_msgs)..CustomTitle..'\nโ๏ธููุงุทู โคฝ โจ '..user_nkt..' โฉ'..Tked, 1, 'md')
end,nil)
end 
end,nil)
return false 
end
if text and text:match('ูุดู (%d+)') and ChCheck(msg) or text and text:match('ุงูุฏู (%d+)') and ChCheck(msg) then 
local iduser = text:match('ูุดู (%d+)') or text:match('ุงูุฏู (%d+)')  
tdcli_function ({ID = "GetUser",user_id_ = iduser},function(arg,data) 
if data.message_ == "User not found" then
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูู ูุชู ุงูุชุนุฑู ุนูู ุงูุญุณุงุจ', 1, 'md')
return false  
end
local user_msgs = DevRio:get(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..iduser) or 0
local user_nkt = tonumber(DevRio:get(storm..'Rio:GamesNumber'..msg.chat_id_..iduser) or 0)
if DevRio:sismember(storm..'Rio:BanAll:',iduser) then
Tkeed = 'ูุญุธูุฑ ุนุงู'
elseif DevRio:sismember(storm..'Rio:MuteAll:',iduser) then
Tkeed = 'ููุชูู ุนุงู'
elseif DevRio:sismember(storm..'Rio:Ban:'..msg.chat_id_,iduser) then
Tkeed = 'ูุญุธูุฑ'
elseif DevRio:sismember(storm..'Rio:Muted:'..msg.chat_id_,iduser) then
Tkeed = 'ููุชูู'
elseif DevRio:sismember(storm..'Rio:Tkeed:'..msg.chat_id_,iduser) then
Tkeed = 'ูููุฏ'
else
Tkeed = false
end
if Tkeed ~= false then
Tked = '\nโ๏ธุงููููุฏ โคฝ '..Tkeed
else 
Tked = '' 
end
if DevRio:sismember(storm..'Rio:SudoBot:',iduser) and SudoBot(msg) then
sudobot = '\nโ๏ธุนุฏุฏ ุงูุฌุฑูุจุงุช โคฝ '..(DevRio:get(storm..'Rio:Sudos'..iduser) or 0)..'' 
else 
sudobot = '' 
end
if GetCustomTitle(iduser,msg.chat_id_) ~= false then
CustomTitle = '\nโ๏ธููุจู โคฝ '..GetCustomTitle(iduser,msg.chat_id_)
else 
CustomTitle = '' 
end
if data.first_name_ == false then
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุงูุญุณุงุจ ูุญุฐูู', 1, 'md')
return false  end
if data.username_ == false then
Text = 'โ๏ธุงุณูู โคฝ ['..data.first_name_..'](tg://user?id='..iduser..')\nโ๏ธุงูุฏูู โคฝ โจ `'..iduser..'` โฉ\nโ๏ธุฑุชุจุชู โคฝ '..IdRank(data.id_, msg.chat_id_)..sudobot..'\nโ๏ธุฑุณุงุฆูู โคฝ โจ '..user_msgs..' โฉ\nโ๏ธุชูุงุนูู โคฝ '..formsgs(user_msgs)..CustomTitle..'\nโ๏ธููุงุทู โคฝ โจ '..user_nkt..' โฉ'..Tked
SendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธูุนุฑูู โคฝ [@'..data.username_..']\nโ๏ธุงูุฏูู โคฝ โจ `'..iduser..'` โฉ\nโ๏ธุฑุชุจุชู โคฝ '..IdRank(data.id_, msg.chat_id_)..sudobot..'\nโ๏ธุฑุณุงุฆูู โคฝ โจ '..user_msgs..' โฉ\nโ๏ธุชูุงุนูู โคฝ '..formsgs(user_msgs)..CustomTitle..'\nโ๏ธููุงุทู โคฝ โจ '..user_nkt..' โฉ'..Tked, 1, 'md')
end
end,nil)
return false 
end 
--     Source Storm     --
if text == 'ูุดู ุงููููุฏ' and tonumber(msg.reply_to_message_id_) > 0 and Admin(msg) and ChCheck(msg) then 
function kshf_by_reply(extra, result, success)
if DevRio:sismember(storm..'Rio:Muted:'..msg.chat_id_,result.sender_user_id_) then muted = 'ููุชูู' else muted = 'ุบูุฑ ููุชูู' end
if DevRio:sismember(storm..'Rio:Ban:'..msg.chat_id_,result.sender_user_id_) then banned = 'ูุญุธูุฑ' else banned = 'ุบูุฑ ูุญุธูุฑ' end
if DevRio:sismember(storm..'Rio:BanAll:',result.sender_user_id_) then banall = 'ูุญุธูุฑ ุนุงู' else banall = 'ุบูุฑ ูุญุธูุฑ ุนุงู' end
if DevRio:sismember(storm..'Rio:MuteAll:',result.sender_user_id_) then muteall = 'ููุชูู ุนุงู' else muteall = 'ุบูุฑ ููุชูู ุนุงู' end
if DevRio:sismember(storm..'Rio:Tkeed:',result.sender_user_id_) then tkeed = 'ูููุฏ' else tkeed = 'ุบูุฑ ูููุฏ' end
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุญุธุฑ ุงูุนุงู โคฝ '..banall..'\nโ๏ธุงููุชู ุงูุนุงู โคฝ '..muteall..'\nโ๏ธุงูุญุธุฑ โคฝ '..banned..'\nโ๏ธุงููุชู โคฝ '..muted..'\nโ๏ธุงูุชููุฏ โคฝ '..tkeed, 1, 'md')  
end
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),kshf_by_reply) 
end
if text and text:match('^ูุดู ุงููููุฏ @(.*)') and Admin(msg) and ChCheck(msg) then 
local username = text:match('^ูุดู ุงููููุฏ @(.*)') 
function kshf_by_username(extra, result, success)
if result.id_ then
if DevRio:sismember(storm..'Rio:Muted:'..msg.chat_id_,result.id_) then muted = 'ููุชูู' else muted = 'ุบูุฑ ููุชูู' end
if DevRio:sismember(storm..'Rio:Ban:'..msg.chat_id_,result.id_) then banned = 'ูุญุธูุฑ' else banned = 'ุบูุฑ ูุญุธูุฑ' end
if DevRio:sismember(storm..'Rio:BanAll:',result.id_) then banall = 'ูุญุธูุฑ ุนุงู' else banall = 'ุบูุฑ ูุญุธูุฑ ุนุงู' end
if DevRio:sismember(storm..'Rio:MuteAll:',result.id_) then muteall = 'ููุชูู ุนุงู' else muteall = 'ุบูุฑ ููุชูู ุนุงู' end
if DevRio:sismember(storm..'Rio:Tkeed:',result.id_) then tkeed = 'ูููุฏ' else tkeed = 'ุบูุฑ ูููุฏ' end
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุญุธุฑ ุงูุนุงู โคฝ '..banall..'\nโ๏ธุงููุชู ุงูุนุงู โคฝ '..muteall..'\nโ๏ธุงูุญุธุฑ โคฝ '..banned..'\nโ๏ธุงููุชู โคฝ '..muted..'\nโ๏ธุงูุชููุฏ โคฝ '..tkeed, 1, 'md')  
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')  
end
end
resolve_username(username,kshf_by_username) 
end
if text == 'ุฑูุน ุงููููุฏ' and tonumber(msg.reply_to_message_id_) > 0 and Admin(msg) and ChCheck(msg) then 
function unbanreply(extra, result, success) 
if tonumber(result.sender_user_id_) == tonumber(storm) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุง ุงูุจูุช ูููุณ ูุฏู ูููุฏ', 1, 'md')  
return false  
end 
ReplyStatus(msg,result.sender_user_id_,"Reply","โ๏ธุชู ุฑูุน ูููุฏู") 
if SecondSudo(msg) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevRio:srem(storm..'Rio:Tkeed:'..msg.chat_id_,result.sender_user_id_) DevRio:srem(storm..'Rio:Ban:'..msg.chat_id_,result.sender_user_id_) DevRio:srem(storm..'Rio:Muted:'..msg.chat_id_,result.sender_user_id_) DevRio:srem(storm..'Rio:BanAll:',result.sender_user_id_) DevRio:srem(storm..'Rio:MuteAll:',result.sender_user_id_)
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevRio:srem(storm..'Rio:Tkeed:'..msg.chat_id_,result.sender_user_id_) DevRio:srem(storm..'Rio:Ban:'..msg.chat_id_,result.sender_user_id_) DevRio:srem(storm..'Rio:Muted:'..msg.chat_id_,result.sender_user_id_) 
end
end
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),unbanreply) 
end
if text and text:match('^ุฑูุน ุงููููุฏ (%d+)') and Admin(msg) and ChCheck(msg) then 
local user = text:match('ุฑูุน ุงููููุฏ (%d+)') 
if tonumber(user) == tonumber(storm) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุง ุงูุจูุช ูููุณ ูุฏู ูููุฏ', 1, 'md')  
return false  
end 
tdcli_function ({ID = "GetUser",user_id_ = user},function(arg,data) 
if data and data.code_ and data.code_ == 6 then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ุงุณุชุทุน ุงุณุชุฎุฑุงุฌ ุงููุนูููุงุช', 1, 'md') 
return false  
end
ReplyStatus(msg,user,"Reply","โ๏ธุชู ุฑูุน ูููุฏู") 
if SecondSudo(msg) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..user.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevRio:srem(storm..'Rio:Tkeed:'..msg.chat_id_,user) DevRio:srem(storm..'Rio:Ban:'..msg.chat_id_,user) DevRio:srem(storm..'Rio:Muted:'..msg.chat_id_,user) DevRio:srem(storm..'Rio:BanAll:',user) DevRio:srem(storm..'Rio:MuteAll:',user)
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..user.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevRio:srem(storm..'Rio:Tkeed:'..msg.chat_id_,user) DevRio:srem(storm..'Rio:Ban:'..msg.chat_id_,user) DevRio:srem(storm..'Rio:Muted:'..msg.chat_id_,user) 
end  
end,nil)  
end
if text and text:match('^ุฑูุน ุงููููุฏ @(.*)') and Admin(msg) and ChCheck(msg) then  
local username = text:match('ุฑูุน ุงููููุฏ @(.*)')  
function unbanusername(extra,result,success)  
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ุงููุนุฑู ุบูุฑ ุตุญูุญ*', 1, 'md')  
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุฐุง ูุนุฑู ููุงุฉ ูููุณ ูุนุฑู ุญุณุงุจ', 1, 'md') 
return false  
end
if tonumber(result.id_) == tonumber(storm) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุง ุงูุจูุช ูููุณ ูุฏู ูููุฏ', 1, 'md')  
return false  
end 
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(arg,data) 
if data and data.code_ and data.code_ == 6 then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ุงุณุชุทุน ุงุณุชุฎุฑุงุฌ ุงููุนูููุงุช', 1, 'md') 
return false  
end
ReplyStatus(msg,result.id_,"Reply","โ๏ธุชู ุฑูุน ูููุฏู") 
if SecondSudo(msg) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.id_.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevRio:srem(storm..'Rio:Tkeed:'..msg.chat_id_,result.id_) DevRio:srem(storm..'Rio:Ban:'..msg.chat_id_,result.id_) DevRio:srem(storm..'Rio:Muted:'..msg.chat_id_,result.id_) DevRio:srem(storm..'Rio:BanAll:',result.id_) DevRio:srem(storm..'Rio:MuteAll:',result.id_)
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.id_.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevRio:srem(storm..'Rio:Tkeed:'..msg.chat_id_,result.id_) DevRio:srem(storm..'Rio:Ban:'..msg.chat_id_,result.id_) DevRio:srem(storm..'Rio:Muted:'..msg.chat_id_,result.id_) 
end
end,nil)   
end  
resolve_username(username,unbanusername) 
end 
--     Source Storm     --
if Manager(msg) then
if text and text:match("^ุชุบููุฑ ุงูุงูุฏู$") and ChCheck(msg) or text and text:match("^ุชุบูุฑ ุงูุงูุฏู$") and ChCheck(msg) then 
local List = {
[[
ใ ๐๐๐ด๐ ๐จ #username ๐ฅฒ .
ใ ๐ผ๐๐ถ ๐จ #msgs ๐ฅฒ .
ใ ๐๐๐ฐ ๐จ #stast ๐ฅฒ .
ใ ๐ธ๐ณ ๐จ #id ๐ฅฒ .
ใ Ch @So_ST0RM .
]],
[[
โญ- ๐๐๐๐ #stast ๐ฏ. ๐
โฎ- ๐๐๐๐๐ #username ๐ฏ. ๐
โญ- ๐๐๐๐๐ #msgs ๐ฏ. ๐
โญ- ๐๐ ๐ #id ๐ฏ. ๐
โญ- Ch @So_ST0RM .
]],
[[
โ ๐ฐ ๐พ๐๐๐๐๐๐ ๐ป๐ ๐ฎ๐๐๐๐ โ
โข ๐ค | ๐ผ๐ฌ๐บ : #username โโโโ
โข ๐ค | ๐บ๐ป๐จ : #stast ๐ง๐ปโโ๏ธ โฅ
โข ๐ค | ๐ฐ๐ซ : #id โโโโ
โข ๐ค | ๐ด๐บ๐ฎ : #msgs ๐
โข ๐ค | Ch @So_ST0RM .
]],
[[
โ ๐๐๐๐ ๐คฑ #username ๐ฆด .
โ ๐๐๐ ๐คฑ #msgs ๐ฆด .
โ ๐๐๐ ๐คฑ #stast ๐ฆด .
โ ๐๐ ๐คฑ #id ๐ฆด .
โ Ch @So_ST0RM .
]],
[[
๐ผ๐ฎ๐ถ ๐ผ๐๐๐๐ต๐๐๐ : #username 
๐ผ๐ฎ๐ถ ๐บ๐๐๐๐ : #stast 
๐ผ๐ฎ๐ถ ๐๐ : #id 
๐ผ๐ฎ๐ถ ๐ฎ๐๐๐๐บ : #game 
๐ผ๐ฎ๐ถ ๐ด๐๐๐ : #msgs
๐ผ๐ฎ๐ถ Ch @So_ST0RM .
]],
[[
โ: ๐๐๐๐ #stast ๐ฏโธ๐.
โ: ๐๐๐๐๐ #username ๐ฏโธ๐.
โ: ๐๐๐๐๐ #msgs ๐ฏโธ๐.
โ: ๐๐ ๐ #id ๐ฏโธ๐.
โ: Ch @So_ST0RM .
]],
[[
โโข๐ฎ๐ฌ๐๐ซ : #username ๐ฃฌ  
โโข๐ฆ๐ฌ๐   : #msgs ๐ฃฌ 
โโข๐ฌ๐ญ๐ : #stast ๐ฃฌ 
โโข๐ข๐  : #id ๐ฃฌ
โโข Ch @So_ST0RM .
]],
[[
- ๐ฌ ๐๐ฌ๐๐ซ : #username ๐ .
- ๐ฌ ๐๐ฌ๐  : #msgs ๐ .
- ๐ฌ ๐๐ญ๐ : #stast ๐ .
- ๐ฌ ๐๐ : #id ๐ .
- ๐ฌ Ch @So_ST0RM .
]],
[[
.๐ฃ ๐ช๐จ๐๐ง๐ฃ๐๐ข๐ , #username  
.๐ฃ ๐จ๐ฉ๐๐จ๐ฉ , #stast  
.๐ฃ ๐ก๐ฟ , #id  
.๐ฃ ๐๐๐ข๐จ , #game 
.๐ฃ ๐ข๐จ๐๐จ , #msgs
.๐ฃ Ch @So_ST0RM .
]],
[[
โ๏ธ๐๐๐๐ โฌ #username 
โ๏ธ๐๐ โฌ #id
โ๏ธ๐๐๐๐๐ โฌ #stast
โ๏ธ๐๐๐๐ โฌ #cont 
โ๏ธ๐๐๐๐ โฌ #msgs
โ๏ธ๐๐๐๐ โฌ #game
โ๏ธCh @So_ST0RM .
]],
[[
แฏ ๐จ๐ฆ๐๐ฅ๐ก๐ฎ๐บ๐ . #username ๐บ๐ธ ๊ฐ
แฏ ๐ฆ๐ง๐ฎ๐ฆ๐ง . #stast ๐บ๐ธ ๊ฐ
แฏ ๐๐ . #id ๐บ๐ธ ๊ฐ
แฏ ๐๐ฎ๐บ๐๐ฆ . #game ๐บ๐ธ ๊ฐ
แฏ ๐บ๐ฆ๐๐ฆ . #msgs ๐บ๐ธ ๊ฐ
แฏ Ch @So_ST0RM
]],
[[
- แดัแดสษดแดแดแด โฅโข #username .
- แดัษขั โฅโข #msgs .
- ัแดแดแดั โฅโข #stast .
- สแดแดส ษชแด โฅโข #id  .
- แดแดษชแด แดsษข โฅโข #edit .
- แดแดแดแดษชสs โฅโข #auto . 
- ษขแดแดแด โฅโข #game .
- Ch @So_ST0RM .
]]}
local Text_Rand = List[math.random(#List)]
DevRio:set(storm.."Rio:GpIds:Text"..msg.chat_id_,Text_Rand)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุชุบูุฑ ูููุดุฉ ุงูุงูุฏู")  
end
--     Source Storm     --
if SecondSudo(msg) then
if text and text:match("^ุชุนููู ุงูุงูุฏู ุงูุนุงู$") or text and text:match("^ุชุนูู ุงูุงูุฏู ุงูุนุงู$") or text and text:match("^ุชุนููู ูููุดุฉ ุงูุงูุฏู$") then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุฑุฌุงุฆุง ุงุชุจุน ุงูุชุนูููุงุช ููุชุนููู \nโ๏ธูุทุจุน ูููุดุฉ ุงูุงูุฏู ุงุฑุณู ูููุดู ุชุญุชูู ุนูู ุงููุตูุต ุงูุชู ุจุงููุบู ุงูุงูุฌููุฒูู ุงุฏูุงู โคฝ โค\nโ โ โ โ โ โ โ โ โ\n `#username` โฌ ูุทุจุน ุงููุนุฑู\n `#id` โฌ ูุทุจุน ุงูุงูุฏู \n `#photos` โฌ ูุทุจุน ุนุฏุฏ ุงูุตูุฑ \n `#stast` โฌ ูุทุจุน ุงูุฑุชุจ \n `#msgs` โฌ ูุทุจุน ุนุฏุฏ ุงูุฑุณุงุฆู \n `#msgday` โฌ ูุทุจุน ุงูุฑุณุงุฆู ุงูููููู \n `#CustomTitle` โฌ ูุทุจุน ุงูููุจ \n `#bio` โฌ ูุทุจุน ุงูุจุงูู \n `#auto` โฌ ูุทุจุน ุงูุชูุงุนู \n `#game` โฌ ูุทุจุน ุนุฏุฏ ุงูููุงุท \n `#cont` โฌ ูุทุจุน ุนุฏุฏ ุงูุฌูุงุช \n `#edit` โฌ ูุทุจุน ุนุฏุฏ ุงูุณุญูุงุช \n `#Description` โฌ ูุทุจุน ุชุนููู ุงูุตูุฑ\nโ โ โ โ โ โ โ โ โ', 1, 'md')
DevRio:set("storm:New:id:"..storm..msg.sender_user_id_,'stormTeam')
return "stormTeam"
end
if text and DevRio:get("storm:New:id:"..storm..msg.sender_user_id_) then 
if text == 'ุงูุบุงุก' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุญูุธ ูููุดุฉ ุงูุงูุฏู', 1, 'md')
DevRio:del("storm:New:id:"..storm..msg.sender_user_id_)
return false
end
DevRio:del("storm:New:id:"..storm..msg.sender_user_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญูุธ ูููุดุฉ ุงูุงูุฏู ุงูุนุงูู', 1, 'md')
DevRio:set(storm.."Rio:AllIds:Text",text)
return false
end
if text and text:match("^ุญุฐู ุงูุงูุฏู ุงูุนุงู$") or text and text:match("^ูุณุญ ุงูุงูุฏู ุงูุนุงู$") or text and text:match("^ุญุฐู ูููุดุฉ ุงูุงูุฏู$") and ChCheck(msg) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ูููุดุฉ ุงูุงูุฏู ุงูุนุงูู")  
DevRio:del(storm.."Rio:AllIds:Text")
end
end
--     Source Storm     --
if text and text:match("^ุชุนููู ุงูุงูุฏู$") and ChCheck(msg) or text and text:match("^ุชุนูู ุงูุงูุฏู$") and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุฑุฌุงุฆุง ุงุชุจุน ุงูุชุนูููุงุช ููุชุนููู \nโ๏ธูุทุจุน ูููุดุฉ ุงูุงูุฏู ุงุฑุณู ูููุดู ุชุญุชูู ุนูู ุงููุตูุต ุงูุชู ุจุงููุบู ุงูุงูุฌููุฒูู ุงุฏูุงู โคฝ โค\nโ โ โ โ โ โ โ โ โ\n `#username` โฌ ูุทุจุน ุงููุนุฑู\n `#id` โฌ ูุทุจุน ุงูุงูุฏู \n `#photos` โฌ ูุทุจุน ุนุฏุฏ ุงูุตูุฑ \n `#stast` โฌ ูุทุจุน ุงูุฑุชุจ \n `#msgs` โฌ ูุทุจุน ุนุฏุฏ ุงูุฑุณุงุฆู \n `#msgday` โฌ ูุทุจุน ุงูุฑุณุงุฆู ุงูููููู \n `#CustomTitle` โฌ ูุทุจุน ุงูููุจ \n `#bio` โฌ ูุทุจุน ุงูุจุงูู \n `#auto` โฌ ูุทุจุน ุงูุชูุงุนู \n `#game` โฌ ูุทุจุน ุนุฏุฏ ุงูููุงุท \n `#cont` โฌ ูุทุจุน ุนุฏุฏ ุงูุฌูุงุช \n `#edit` โฌ ูุทุจุน ุนุฏุฏ ุงูุณุญูุงุช \n `#Description` โฌ ูุทุจุน ุชุนููู ุงูุตูุฑ\nโ โ โ โ โ โ โ โ โ', 1, 'md')
DevRio:set("storm:New:id:"..storm..msg.chat_id_..msg.sender_user_id_,'stormTeam')
return "stormTeam"
end
if text and Manager(msg) and DevRio:get("storm:New:id:"..storm..msg.chat_id_..msg.sender_user_id_) then 
if text == 'ุงูุบุงุก' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุญูุธ ูููุดุฉ ุงูุงูุฏู', 1, 'md')
DevRio:del("storm:New:id:"..storm..msg.chat_id_..msg.sender_user_id_)
return false
end
DevRio:del("storm:New:id:"..storm..msg.chat_id_..msg.sender_user_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญูุธ ุงููููุดู ุงูุฌุฏูุฏู', 1, 'md')
DevRio:set(storm.."Rio:GpIds:Text"..msg.chat_id_,text)
return false
end
if text and text:match("^ุญุฐู ุงูุงูุฏู$") and ChCheck(msg) or text and text:match("^ูุณุญ ุงูุงูุฏู$") and ChCheck(msg) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ูููุดุฉ ุงูุงูุฏู")  
DevRio:del(storm.."Rio:GpIds:Text"..msg.chat_id_)
end
end
--     Source Storm     --
if msg.reply_to_message_id_ ~= 0 then
return ""
else
if text and (text:match("^ุงูุฏู$") or text:match("^id$") or text:match("^Id$")) and ChCheck(msg) then
function stormTeam(extra,rio,success)
if rio.username_ then username = '@'..rio.username_ else username = 'ูุง ููุฌุฏ' end
if GetCustomTitle(msg.sender_user_id_,msg.chat_id_) ~= false then CustomTitle = GetCustomTitle(msg.sender_user_id_,msg.chat_id_) else CustomTitle = 'ูุง ููุฌุฏ' end
local function getpro(extra, rio, success) 
local msgsday = DevRio:get(storm..'Rio:UsersMsgs'..storm..os.date('%d')..':'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local edit_msg = DevRio:get(storm..'Rio:EditMsg'..msg.chat_id_..msg.sender_user_id_) or 0
local user_msgs = DevRio:get(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
local user_nkt = tonumber(DevRio:get(storm..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_) or 0)
local cont = (tonumber(DevRio:get(storm..'Rio:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_)) or 0)
local msguser = tonumber(DevRio:get(storm..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_))
local Texting = {"ูู ุตูุฑู ุธูู ุจุงููุจู ุ๐คค๐","ููุชูุน ุจุตูุฑุชู !ุ ๐น๐ค","ููุงู ููุงุณูู ุจุฌุฑูุจูู ุ๐คค๐","ููุงููู ุ๐คค๐","ูุดุฎู ุจุฑุจ ุ๐๐ค","ูุฒูุช ุจููุง ุฏุบูุฑูุง ุนุงุฏ ุ๐๐","ุตูุฑุชู ูุงูุฑุชุงุญููุง ุ๐๐ถ","ุญูุบูู ูุงููู ุ๐ฅบ๐","ูู ุตูุฑู ุบูุจูู ุจุฑุงุณูุง ูฆู  ุญุธ ุ๐น๐ค"}
local Description = Texting[math.random(#Texting)]
if rio.photos_[0] then
if not DevRio:get(storm..'Rio:Lock:Id'..msg.chat_id_) then 
if not DevRio:get(storm..'Rio:Lock:Id:Photo'..msg.chat_id_) then 
if DevRio:get(storm.."Rio:AllIds:Text") then
newpicid = DevRio:get(storm.."Rio:AllIds:Text")
newpicid = newpicid:gsub('#username',(username or 'ูุง ููุฌุฏ'))
newpicid = newpicid:gsub('#CustomTitle',(CustomTitle or 'ูุง ููุฌุฏ'))
newpicid = newpicid:gsub('#bio',(GetBio(msg.sender_user_id_) or 'ูุง ููุฌุฏ'))
newpicid = newpicid:gsub('#photos',(rio.total_count_ or 'ูุง ููุฌุฏ')) 
newpicid = newpicid:gsub('#game',(user_nkt or 'ูุง ููุฌุฏ'))
newpicid = newpicid:gsub('#edit',(edit_msg or 'ูุง ููุฌุฏ'))
newpicid = newpicid:gsub('#cont',(cont or 'ูุง ููุฌุฏ'))
newpicid = newpicid:gsub('#msgs',(user_msgs or 'ูุง ููุฌุฏ'))
newpicid = newpicid:gsub('#msgday',(msgsday or 'ูุง ููุฌุฏ'))
newpicid = newpicid:gsub('#id',(msg.sender_user_id_ or 'ูุง ููุฌุฏ'))
newpicid = newpicid:gsub('#auto',(formsgs(msguser) or 'ูุง ููุฌุฏ'))
newpicid = newpicid:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'ูุง ููุฌุฏ'))
newpicid = newpicid:gsub('#Description',(Description or 'ูุง ููุฌุฏ'))
else
newpicid = "โ๏ธ"..Description.."\nโ๏ธูุนุฑูู โคฝ โจ "..username.." โฉ\nโ๏ธุงูุฏูู โคฝ โจ "..msg.sender_user_id_.." โฉ\nโ๏ธุฑุชุจุชู โคฝ "..IdRank(msg.sender_user_id_, msg.chat_id_).."\nโ๏ธุฑุณุงุฆูู โคฝ โจ "..user_msgs.." โฉ\nโ๏ธุณุญูุงุชู โคฝ โจ "..edit_msg.." โฉ\nโ๏ธุชูุงุนูู โคฝ "..formsgs(msguser).."\nโ๏ธููุงุทู โคฝ โจ "..user_nkt.." โฉ\nโ โ โ โ โ โ โ โ โ\n"
end 
if not DevRio:get(storm.."Rio:GpIds:Text"..msg.chat_id_) then 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, rio.photos_[0].sizes_[1].photo_.persistent_id_,newpicid,msg.id_,msg.id_.."")
else 
local new_id = DevRio:get(storm.."Rio:GpIds:Text"..msg.chat_id_)
local new_id = new_id:gsub('#username',(username or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#CustomTitle',(CustomTitle or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#bio',(GetBio(msg.sender_user_id_) or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#photos',(rio.total_count_ or '')) 
local new_id = new_id:gsub('#game',(user_nkt or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#edit',(edit_msg or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#cont',(cont or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#msgs',(user_msgs or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#msgday',(msgsday or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#id',(msg.sender_user_id_ or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#auto',(formsgs(msguser) or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#Description',(Description or 'ูุง ููุฌุฏ'))
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, rio.photos_[0].sizes_[1].photo_.persistent_id_,new_id,msg.id_,msg.id_.."")
end
else
if DevRio:get(storm.."Rio:AllIds:Text") then
newallid = DevRio:get(storm.."Rio:AllIds:Text")
newallid = newallid:gsub('#username',(username or 'ูุง ููุฌุฏ'))
newallid = newallid:gsub('#CustomTitle',(CustomTitle or 'ูุง ููุฌุฏ'))
newallid = newallid:gsub('#bio',(GetBio(msg.sender_user_id_) or 'ูุง ููุฌุฏ'))
newallid = newallid:gsub('#photos',(rio.total_count_ or 'ูุง ููุฌุฏ')) 
newallid = newallid:gsub('#game',(user_nkt or 'ูุง ููุฌุฏ'))
newallid = newallid:gsub('#edit',(edit_msg or 'ูุง ููุฌุฏ'))
newallid = newallid:gsub('#cont',(cont or 'ูุง ููุฌุฏ'))
newallid = newallid:gsub('#msgs',(user_msgs or 'ูุง ููุฌุฏ'))
newallid = newallid:gsub('#msgday',(msgsday or 'ูุง ููุฌุฏ'))
newallid = newallid:gsub('#id',(msg.sender_user_id_ or 'ูุง ููุฌุฏ'))
newallid = newallid:gsub('#auto',(formsgs(msguser) or 'ูุง ููุฌุฏ'))
newallid = newallid:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'ูุง ููุฌุฏ'))
newallid = newallid:gsub('#Description',(Description or 'ูุง ููุฌุฏ'))
else
newallid = "โ๏ธูุนุฑูู โคฝ โจ "..username.." โฉ\nโ๏ธุงูุฏูู โคฝ โจ "..msg.sender_user_id_.." โฉ\nโ๏ธุฑุชุจุชู โคฝ "..IdRank(msg.sender_user_id_, msg.chat_id_).."\nโ๏ธุฑุณุงุฆูู โคฝ โจ "..user_msgs.." โฉ\nโ๏ธุณุญูุงุชู โคฝ โจ "..edit_msg.." โฉ\nโ๏ธุชูุงุนูู โคฝ "..formsgs(msguser).."\nโ๏ธููุงุทู โคฝ โจ "..user_nkt.." โฉ"
end 
if not DevRio:get(storm.."Rio:GpIds:Text"..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, newallid, 1, 'html')
else
local new_id = DevRio:get(storm.."Rio:GpIds:Text"..msg.chat_id_)
local new_id = new_id:gsub('#username',(username or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#CustomTitle',(CustomTitle or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#bio',(GetBio(msg.sender_user_id_) or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#photos',(rio.total_count_ or 'ูุง ููุฌุฏ')) 
local new_id = new_id:gsub('#game',(user_nkt or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#edit',(edit_msg or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#cont',(cont or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#msgs',(user_msgs or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#msgday',(msgsday or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#id',(msg.sender_user_id_ or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#auto',(formsgs(msguser) or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'ูุง ููุฌุฏ'))
local new_id = new_id:gsub('#Description',(Description or 'ูุง ููุฌุฏ'))
Dev_Rio(msg.chat_id_, msg.id_, 1, new_id, 1, 'html')  
end
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุนุฐุฑุง ุงูุงูุฏู ูุนุทู ', 1, 'md')
end
else
if DevRio:get(storm.."Rio:AllIds:Text") then
notpicid = DevRio:get(storm.."Rio:AllIds:Text")
notpicid = notpicid:gsub('#username',(username or 'ูุง ููุฌุฏ'))
notpicid = notpicid:gsub('#CustomTitle',(CustomTitle or 'ูุง ููุฌุฏ'))
notpicid = notpicid:gsub('#bio',(GetBio(msg.sender_user_id_) or 'ูุง ููุฌุฏ'))
notpicid = notpicid:gsub('#photos',(rio.total_count_ or 'ูุง ููุฌุฏ')) 
notpicid = notpicid:gsub('#game',(user_nkt or 'ูุง ููุฌุฏ'))
notpicid = notpicid:gsub('#edit',(edit_msg or 'ูุง ููุฌุฏ'))
notpicid = notpicid:gsub('#cont',(cont or 'ูุง ููุฌุฏ'))
notpicid = notpicid:gsub('#msgs',(user_msgs or 'ูุง ููุฌุฏ'))
notpicid = notpicid:gsub('#msgday',(msgsday or 'ูุง ููุฌุฏ'))
notpicid = notpicid:gsub('#id',(msg.sender_user_id_ or 'ูุง ููุฌุฏ'))
notpicid = notpicid:gsub('#auto',(formsgs(msguser) or 'ูุง ููุฌุฏ'))
notpicid = notpicid:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'ูุง ููุฌุฏ'))
notpicid = notpicid:gsub('#Description',(Description or 'ูุง ููุฌุฏ'))
else
notpicid = "โ๏ธูุง ุงุณุชุทูุน ุนุฑุถ ุตูุฑุชู ูุงูู ููุช ุจุญุธุฑ ุงูุจูุช ุงู ุงูู ูุงุชูุชูู ุตูุฑู ูู ุจุฑููุงููู\nโ โ โ โ โ โ โ โ โ\nโ๏ธูุนุฑูู โคฝ โจ "..username.." โฉ\nโ๏ธุงูุฏูู โคฝ โจ "..msg.sender_user_id_.." โฉ\nโ๏ธุฑุชุจุชู โคฝ "..IdRank(msg.sender_user_id_, msg.chat_id_).."\nโ๏ธุฑุณุงุฆูู โคฝ โจ "..user_msgs.." โฉ\nโ๏ธุณุญูุงุชู โคฝ โจ "..edit_msg.." โฉ\nโ๏ธุชูุงุนูู โคฝ "..formsgs(msguser).."\nโ๏ธููุงุทู โคฝ โจ "..user_nkt.." โฉ\nโ โ โ โ โ โ โ โ โ\n"
end 
if not DevRio:get(storm..'Rio:Lock:Id'..msg.chat_id_) then
if not DevRio:get(storm..'Rio:Lock:Id:Photo'..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, notpicid, 1, 'html')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุนุฑูู โคฝ โจ "..username.." โฉ\nโ๏ธุงูุฏูู โคฝ โจ "..msg.sender_user_id_.." โฉ\nโ๏ธุฑุชุจุชู โคฝ "..IdRank(msg.sender_user_id_, msg.chat_id_).."\nโ๏ธุฑุณุงุฆูู โคฝ โจ "..user_msgs.." โฉ\nโ๏ธุณุญูุงุชู โคฝ โจ "..edit_msg.." โฉ\nโ๏ธุฑุณุงุฆูู โคฝ โจ "..user_msgs.." โฉ\nโ๏ธุชูุงุนูู โคฝ "..formsgs(msguser).."\nโ๏ธููุงุทู โคฝ โจ "..user_nkt.." โฉ", 1, 'md')
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุนุฐุฑุง ุงูุงูุฏู ูุนุทู', 1, 'md')
end end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
getUser(msg.sender_user_id_, stormTeam)
end
end 
--     Source Storm     --
if ChatType == 'sp' or ChatType == 'gp'  then
if Admin(msg) then
if text and text:match("^ููู (.*)$") and ChCheck(msg) then
local LockText = {string.match(text, "^(ููู) (.*)$")}
if LockText[2] == "ุงูุชุนุฏูู" then
if not DevRio:get(storm..'Rio:Lock:EditMsgs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุชุนุฏูู")  
DevRio:set(storm..'Rio:Lock:EditMsgs'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุชุนุฏูู ุจุงููุนู ูููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุชุนุฏูู ุงูููุฏูุง" or LockText[2] == "ุชุนุฏูู ุงูููุฏูุง" then
if not DevRio:get(storm..'Rio:Lock:EditMsgs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุชุนุฏูู ุงูููุฏูุง")  
DevRio:set(storm..'Rio:Lock:EditMsgs'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชุนุฏูู ุงูููุฏูุง ุจุงููุนู ูููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงููุงุฑุณูู" then
if not DevRio:get(storm..'Rio:Lock:Farsi'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงููุงุฑุณูู")  
DevRio:set(storm..'Rio:Lock:Farsi'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุงุฑุณูู ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงููุดุงุฑ" then
if DevRio:get(storm..'Rio:Lock:Fshar'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงููุดุงุฑ")  
DevRio:del(storm..'Rio:Lock:Fshar'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุดุงุฑ ุจุงููุนู ูููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุทุงุฆููู" then
if DevRio:get(storm..'Rio:Lock:Taf'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุทุงุฆููู")  
DevRio:del(storm..'Rio:Lock:Taf'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุทุงุฆููู ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูููุฑ" then
if DevRio:get(storm..'Rio:Lock:Kfr'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูููุฑ")  
DevRio:del(storm..'Rio:Lock:Kfr'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูููุฑ ุจุงููุนู ูููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงููุงุฑุณูู ุจุงูุทุฑุฏ" then
if not DevRio:get(storm..'Rio:Lock:FarsiBan'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงููุงุฑุณูู ุจุงูุทุฑุฏ")  
DevRio:set(storm..'Rio:Lock:FarsiBan'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุงุฑุณูู ุจุงูุทุฑุฏ ุจุงููุนู ููููู ', 1, 'md')
end
end
if LockText[2] == "ุงูุจูุชุงุช" or LockText[2] == "ุงูุจูุชุงุช ุจุงูุญุฐู" then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุจูุชุงุช ุจุงูุญุฐู")  
DevRio:set(storm.."Rio:Lock:Bots"..msg.chat_id_,"del")  
end
if LockText[2] == "ุงูุจูุชุงุช ุจุงูุทุฑุฏ" then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุจูุชุงุช ุจุงูุทุฑุฏ")  
DevRio:set(storm.."Rio:Lock:Bots"..msg.chat_id_,"kick")  
end
if LockText[2] == "ุงูุจูุชุงุช ุจุงูุชูููุฏ" or LockText[2] == "ุงูุจูุชุงุช ุจุงูุชููุฏ" then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุจูุชุงุช ุจุงูุชููุฏ")  
DevRio:set(storm.."Rio:Lock:Bots"..msg.chat_id_,"ked")  
end
if LockText[2] == "ุงูุชูุฑุงุฑ" or LockText[2] == "ุงูุชูุฑุงุฑ ุจุงูุญุฐู" then 
DevRio:hset(storm.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User","del")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุชูุฑุงุฑ ุจุงูุญุฐู")  
end
if LockText[2] == "ุงูุชูุฑุงุฑ ุจุงูุทุฑุฏ" then 
DevRio:hset(storm.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User","kick")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุชูุฑุงุฑ ุจุงูุทุฑุฏ")  
end
if LockText[2] == "ุงูุชูุฑุงุฑ ุจุงูุชููุฏ" or LockText[2] == "ุงูุชูุฑุงุฑ ุจุงูุชูููุฏ" then 
DevRio:hset(storm.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุชูุฑุงุฑ ุจุงูุชููุฏ")  
end
if LockText[2] == "ุงูุชูุฑุงุฑ ุจุงููุชู" then 
DevRio:hset(storm.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User","mute")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุชูุฑุงุฑ ุจุงููุชู")  
end
if BasicConstructor(msg) then
if LockText[2] == "ุงูุชุซุจูุช" then
if not DevRio:get(storm..'Rio:Lock:Pin'..msg.chat_id_) then
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = msg.chat_id_:gsub("-100","") }, function(arg,data)  DevRio:set(storm.."Rio:PinnedMsg"..msg.chat_id_,data.pinned_message_id_)  end,nil)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุชุซุจูุช")  
DevRio:set(storm..'Rio:Lock:Pin'..msg.chat_id_,true)
DevRio:sadd(storm.."Rio:Lock:Pinpin",msg.chat_id_) 
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุชุซุจูุช ุจุงููุนู ูููู ูู ุงููุฌููุนู', 1, 'md')
end end end
end
end
end
--     Source Storm     --
if Admin(msg) then
if text and (text:match("^ุถุน ุชูุฑุงุฑ (%d+)$") or text:match("^ูุถุน ุชูุฑุงุฑ (%d+)$")) then   
local TextSpam = text:match("ุถุน ุชูุฑุงุฑ (%d+)$") or text:match("ูุถุน ุชูุฑุงุฑ (%d+)$")
if tonumber(TextSpam) < 2 then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ุจุชุญุฏูุฏ ุนุฏุฏ ุงูุจุฑ ูู 2 ููุชูุฑุงุฑ', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ูุถุน ุนุฏุฏ ุงูุชูุฑุงุฑ โคฝ '..TextSpam, 1, 'md')
DevRio:hset(storm.."Rio:Spam:Group:User"..msg.chat_id_ ,"Num:Spam" ,TextSpam) 
end
end
if text and (text:match("^ุถุน ุฒูู ุงูุชูุฑุงุฑ (%d+)$") or text:match("^ูุถุน ุฒูู ุงูุชูุฑุงุฑ (%d+)$")) then  
local TextSpam = text:match("ุถุน ุฒูู ุงูุชูุฑุงุฑ (%d+)$") or text:match("ูุถุน ุฒูู ุงูุชูุฑุงุฑ (%d+)$")
DevRio:hset(storm.."Rio:Spam:Group:User"..msg.chat_id_ ,"Num:Spam:Time" ,TextSpam) 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ูุถุน ุฒูู ุงูุชูุฑุงุฑ โคฝ '..TextSpam, 1, 'md')
end
--     Source Storm     --
if Manager(msg) then
if text and text == 'ุชูุนูู ุงูุงูุฏู ุจุงูุตูุฑู' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Id:Photo'..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุงูุฏู ุจุงูุตูุฑู ุจุงูุชุงููุฏ ููุนู', 1, 'md')
else
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุงูุฏู ุจุงูุตูุฑู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Lock:Id:Photo'..msg.chat_id_)
end end
if text and text == 'ุชุนุทูู ุงูุงูุฏู ุจุงูุตูุฑู' and ChCheck(msg) then
if DevRio:get(storm..'Rio:Lock:Id:Photo'..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุงูุฏู ุจุงูุตูุฑู ุจุงูุชุงููุฏ ูุนุทู', 1, 'md')
else
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุงูุฏู ุจุงูุตูุฑู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Lock:Id:Photo'..msg.chat_id_,true)
end end 

if text and text == 'ุชูุนูู ุงูุงูุฏู' and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Lock:Id'..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุงูุฏู ุจุงูุชุงููุฏ ููุนู ', 1, 'md')
else
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุงูุฏู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Lock:Id'..msg.chat_id_)
end end 
if text and text == 'ุชุนุทูู ุงูุงูุฏู' and ChCheck(msg) then
if DevRio:get(storm..'Rio:Lock:Id'..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุงูุฏู ุจุงูุชุงููุฏ ูุนุทู ', 1, 'md')
else
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุงูุฏู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Lock:Id'..msg.chat_id_,true)
end end
end
--     Source Storm     --
if text == 'ุถุน ุฑุงุจุท' and ChCheck(msg) or text == 'ูุถุน ุฑุงุจุท' and ChCheck(msg) or text == 'ุถุน ุงูุฑุงุจุท' and ChCheck(msg) or text == 'ูุถุน ุงูุฑุงุจุท' and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงุฑุณู ุฑุงุจุท ุงููุฌููุนู ุงู ุฑุงุจุท ููุงุฉ ุงููุฌููุนู', 1, 'md')
DevRio:setex(storm.."Rio:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_,300,true) 
end
if text == 'ุงูุดุงุก ุฑุงุจุท' and ChCheck(msg) or text == 'ุงูุดุงุก ุงูุฑุงุจุท' and ChCheck(msg) then
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if not DevRio:get(storm.."Rio:Groups:Links"..msg.chat_id_)  then 
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
DevRio:set(storm.."Rio:Groups:Links"..msg.chat_id_,LinkGroup) 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุดุงุก ุฑุงุจุท ุฌุฏูุฏ ุงุฑุณู โคฝ ุงูุฑุงุจุท', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธููุณุช ูุฏู ุตูุงุญูุฉ ุฏุนูุฉ ุงููุณุชุฎุฏููู ุนุจุฑ ุงูุฑุงุจุท ูุฑุฌู ุงูุชุญูู ูู ุงูุตูุงุญูุงุช', 1, 'md')
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงุฑุณู ุฑุงุจุท ุงููุฌููุนู ุงู ุฑุงุจุท ููุงุฉ ุงููุฌููุนู', 1, 'md')
DevRio:setex(storm.."Rio:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_,300,true) 
end
end
end
--     Source Storm     --
if Admin(msg) then
if text and text:match("^ุชูุนูู ุงูุชุฑุญูุจ$") and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุชุฑุญูุจ ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm.."Rio:Lock:Welcome"..msg.chat_id_,true)
end
if text and text:match("^ุชุนุทูู ุงูุชุฑุญูุจ$") and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุชุฑุญูุจ ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm.."Rio:Lock:Welcome"..msg.chat_id_)
end
if DevRio:get(storm..'Rio:setwelcome'..msg.chat_id_..':'..msg.sender_user_id_) then 
if text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุญูุธ ูููุดุฉ ุงูุชุฑุญูุจ', 1, 'md')
DevRio:del(storm..'Rio:setwelcome'..msg.chat_id_..':'..msg.sender_user_id_)
return false  
end 
DevRio:del(storm..'Rio:setwelcome'..msg.chat_id_..':'..msg.sender_user_id_)
Welcomes = text:gsub('"',"") Welcomes = text:gsub("'","") Welcomes = text:gsub(",","") Welcomes = text:gsub("*","") Welcomes = text:gsub(";","") Welcomes = text:gsub("`","") Welcomes = text:gsub("{","") Welcomes = text:gsub("}","") 
DevRio:set(storm..'Rio:Groups:Welcomes'..msg.chat_id_,Welcomes)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญูุธ ูููุดุฉ ุงูุชุฑุญูุจ', 1, 'md')
return false   
end
if text and text:match("^ุถุน ุชุฑุญูุจ$") and ChCheck(msg) or text and text:match("^ูุถุน ุชุฑุญูุจ$") and ChCheck(msg) or text and text:match("^ุงุถู ุชุฑุญูุจ$") and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงุฑุณู ูู ุงูุชุฑุญูุจ ุงูุงู\nโ๏ธุชุณุชุทูุน ุงุถุงูุฉ ูุงููู โคฝ โค\nโ๏ธุฏุงูุฉ ุนุฑุถ ุงูุงุณู โคฝ firstname\nโ๏ธุฏุงูุฉ ุนุฑุถ ุงููุนุฑู โคฝ username', 1, 'md')
DevRio:set(storm..'Rio:setwelcome'..msg.chat_id_..':'..msg.sender_user_id_,true)
end
if text and text:match("^ุญุฐู ุงูุชุฑุญูุจ$") and ChCheck(msg) or text and text:match("^ุญุฐู ุชุฑุญูุจ$") and ChCheck(msg) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงูุชุฑุญูุจ")  
DevRio:del(storm..'Rio:Groups:Welcomes'..msg.chat_id_)
end
if text and text:match("^ุฌูุจ ุงูุชุฑุญูุจ$") and ChCheck(msg) or text and text:match("^ุฌูุจ ุชุฑุญูุจ$") and ChCheck(msg) or text and text:match("^ุงูุชุฑุญูุจ$") and ChCheck(msg) then
local Welcomes = DevRio:get(storm..'Rio:Groups:Welcomes'..msg.chat_id_)
if Welcomes then
Dev_Rio(msg.chat_id_, msg.id_, 1, Welcomes, 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ูุชู ูุถุน ุงูุชุฑุญูุจ \nโ๏ธุงุฑุณู โคฝ ุถุน ุชุฑุญูุจ ููุญูุธ ', 1, 'md')
end
end
--     Source Storm     --
if DevRio:get(storm..'Rio:SetDescription'..msg.chat_id_..':'..msg.sender_user_id_) then  
if text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุญูุธ ุงููุตู", 1, 'md')
DevRio:del(storm..'Rio:SetDescription'..msg.chat_id_..':'..msg.sender_user_id_)
return false  
end 
DevRio:del(storm..'Rio:SetDescription'..msg.chat_id_..':'..msg.sender_user_id_)
https.request('https://api.telegram.org/bot'..TokenBot..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุชุบููุฑ ูุตู ุงููุฌููุนู', 1, 'md')
return false  
end 
if text and text:match("^ุถุน ูุตู$") and ChCheck(msg) or text and text:match("^ูุถุน ูุตู$") and ChCheck(msg) then  
DevRio:set(storm..'Rio:SetDescription'..msg.chat_id_..':'..msg.sender_user_id_,true)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงุฑุณู ูู ุงููุตู ุงูุงู', 1, 'md')
end
--     Source Storm     --
if text and text == "ููุน" and msg.reply_to_message_id_ == 0 and ChCheck(msg) then       
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูู ุงููููู ุงูุงู", 1, 'md') 
DevRio:set(storm.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_,"add")  
return false  
end    
if DevRio:get(storm.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_) == "add" then
if text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุฑ ุงูููุน', 1, 'md')
DevRio:del(storm.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
return false  
end   
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ููุน ุงููููู โคฝ "..text, 1, 'html')
DevRio:del(storm.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
DevRio:hset(storm..'Rio:Filters:'..msg.chat_id_, text,'newword')
return false
end
if text and text == "ุงูุบุงุก ููุน" and msg.reply_to_message_id_ == 0 and ChCheck(msg) then       
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูู ุงููููู ุงูุงู", 1, 'md') 
DevRio:set(storm.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_,"del")  
return false  
end    
if DevRio:get(storm.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_) == "del" then   
if text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุฑ ุงูุบุงุก ุงูููุน', 1, 'md')
DevRio:del(storm.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
return false  
end   
if not DevRio:hget(storm..'Rio:Filters:'..msg.chat_id_, text) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงููููู โคฝ "..text.." ุบูุฑ ููููุนู", 1, 'html')
DevRio:del(storm.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
else
DevRio:hdel(storm..'Rio:Filters:'..msg.chat_id_, text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงููููู โคฝ "..text.." ุชู ุงูุบุงุก ููุนูุง", 1, 'html')
DevRio:del(storm.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
end
return false
end
--     Source Storm     --
if SudoBot(msg) then
if text and text == "ุงูุงุญุตุงุฆูุงุช" and ChCheck(msg) or text and text == "โคฝ  ุงูุงุญุตุงุฆูุงุช โ" and ChCheck(msg) then
local gps = DevRio:scard(storm.."Rio:Groups") local users = DevRio:scard(storm.."Rio:Users") 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงุญุตุงุฆูุงุช ุงูุจูุช โคฝ โค\nโ๏ธุนุฏุฏ ุงููุดุชุฑููู โคฝ โจ '..users..' โฉ\nโ๏ธุนุฏุฏ ุงููุฌููุนุงุช โคฝ โจ '..gps..' โฉ', 1, 'md')
end
if text and text == "ุงููุดุชุฑููู" and ChCheck(msg) or text and text == "โคฝ ุงููุดุชุฑููู โ" and ChCheck(msg) then
local users = DevRio:scard(storm.."Rio:Users")
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุนุฏุฏ ุงููุดุชุฑููู โคฝ โจ '..users..' โฉ', 1, 'md')
end
if text and text == "ุงููุฌููุนุงุช" and ChCheck(msg) or text and text == "โคฝ ุงููุฌููุนุงุช โ" and ChCheck(msg) then
local gps = DevRio:scard(storm.."Rio:Groups")
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุนุฏุฏ ุงููุฌููุนุงุช โคฝ โจ '..gps..' โฉ', 1, 'md')
end
end
--     Source Storm     --
if text and text == "ุงููุฌููุนุงุช" and ChCheck(msg) or text and text == "โคฝ ุงููุฌููุนุงุช โ" and ChCheck(msg) then
if not SudoBot(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑูู ููุท ', 1, 'md')
else
local list = DevRio:smembers(storm.."Rio:Groups")
local t = 'โ๏ธูุฌููุนุงุช ุงูุจูุช โคฝ โค \n'
for k,v in pairs(list) do
t = t..k.."~ : `"..v.."`\n" 
end
if #list == 0 then
t = 'โ๏ธูุง ููุฌุฏ ูุฌููุนุงุช ููุนูู'
end
Dev_Rio(msg.chat_id_, msg.id_, 1,t, 1, 'md')
end end
--     Source Storm     --
if text and text:match('^ุชูุธูู (%d+)$') or text and text:match('^ูุณุญ (%d+)$') and ChCheck(msg) then  
if not DevRio:get(storm..'Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then  
local Number = tonumber(text:match('^ุชูุธูู (%d+)$') or text:match('^ูุณุญ (%d+)$')) 
if Number > 5000 then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุงุชุณุชุทูุน ุชูุธูู ุงูุซุฑ ูู 5000 ุฑุณุงูู', 1, 'md')
return false  
end  
local Message = msg.id_
for i=1,tonumber(Number) do
DeleteMessage(msg.chat_id_,{[0]=Message})
Message = Message - 1048576 
end
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุชูุธูู *'..Number..'* ูู ุงูุฑุณุงุฆู', 1, 'md')
DevRio:setex(storm..'Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end 
end
if text == "ุชูุธูู ุงููุดุชุฑููู" and SecondSudo(msg) and ChCheck(msg) or text == "โคฝ ุชูุธูู ุงููุดุชุฑููู โ" and SecondSudo(msg) and ChCheck(msg) then 
local pv = DevRio:smembers(storm.."Rio:Users")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok" then
else
DevRio:srem(storm.."Rio:Users",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธ*ูุง ููุฌุฏ ูุดุชุฑููู ูููููู*', 1, 'md')
else
local ok = #pv - sendok
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุนุฏุฏ ุงููุดุชุฑููู ุงูุงู โคฝ { '..#pv..' }\nโ๏ธุชู ุญุฐู โคฝ { '..sendok..' } ูู ุงููุดุชุฑููู\nโ๏ธุงูุนุฏุฏ ุงูุญูููู ุงูุงู  โคฝ ( '..ok..' ) \n', 1, 'md')
end
end
end,nil)
end,nil)
end
return false
end
--     Source Storm     --
if text == "ุชูุธูู ุงูุฌุฑูุจุงุช" and SecondSudo(msg) and ChCheck(msg) or text == "ุชูุธูู ุงููุฌููุนุงุช" and SecondSudo(msg) and ChCheck(msg) or text == "โคฝ ุชูุธูู ุงููุฌููุนุงุช โ" and SecondSudo(msg) and ChCheck(msg) then 
local group = DevRio:smembers(storm.."Rio:Groups")
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
DevRio:srem(storm.."Rio:Groups",group[i]) 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = group[i], user_id_ = storm, status_ = { ID = "ChatMemberStatusLeft" }, }, dl_cb, nil)
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
DevRio:srem(storm.."Rio:Groups",group[i]) 
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
DevRio:srem(storm.."Rio:Groups",group[i]) 
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
DevRio:srem(storm.."Rio:Groups",group[i]) 
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธ*ูุงุชูุฌุฏ ูุฌููุนุงุช ููููู*', 1, 'md')   
else
local stormgp2 = (w + q)
local stormgp3 = #group - stormgp2
if q == 0 then
stormgp2 = ''
else
stormgp2 = '\nโ๏ธุชู ุญุฐู โคฝ { '..q..' } ูุฌููุนู ูู ุงูุจูุช'
end
if w == 0 then
stormgp1 = ''
else
stormgp1 = '\nโ๏ธุชู ุญุฐู โคฝ { '..w..' } ูุฌููุนู ุจุณุจุจ ุชูุฒูู ุงูุจูุช ุงูู ุนุถู'
end
Dev_Rio(msg.chat_id_, msg.id_, 1,'โ๏ธุนุฏุฏ ุงูุฌุฑูุจุงุช ุงูุงู โคฝ { '..#group..' }'..stormgp1..stormgp2..'\nโ๏ธุงูุนุฏุฏ ุงูุญูููู ุงูุงู  โคฝ ( '..stormgp3..' ) \n ', 1, 'md')
end end
end,nil)
end
return false
end 
end
--     Source Storm     --
if text and (text == "ุชูุนูู ุงูุชููุงุฆู" or text == "ุชูุนูู ุงููุณุญ ุงูุชููุงุฆู" or text == "ุชูุนูู ุงูุญุฐู ุงูุชููุงุฆู") and Constructor(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ููุฒุฉ ุงูุญุฐู ุงูุชููุงุฆู ููููุฏูุง'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Lock:CleanNum'..msg.chat_id_,true)  
end
if text and (text == "ุชุนุทูู ุงูุชููุงุฆู" or text == "ุชุนุทูู ุงููุณุญ ุงูุชููุงุฆู" or text == "ุชุนุทูู ุงูุญุฐู ุงูุชููุงุฆู") and Constructor(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุญุฐู ุงูุชููุงุฆู ููููุฏูุง'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Lock:CleanNum'..msg.chat_id_) 
end
if text and (text:match("^ุชุนูู ุนุฏุฏ ุงููุณุญ (%d+)$") or text:match("^ุชุนููู ุนุฏุฏ ุงููุณุญ (%d+)$") or text:match("^ุชุนูู ุนุฏุฏ ุงูุญุฐู (%d+)$") or text:match("^ุชุนููู ุนุฏุฏ ุงูุญุฐู (%d+)$") or text:match("^ุนุฏุฏ ุงููุณุญ (%d+)$")) and Constructor(msg) and ChCheck(msg) then
local Num = text:match("ุชุนูู ุนุฏุฏ ุงููุณุญ (%d+)$") or text:match("ุชุนููู ุนุฏุฏ ุงููุณุญ (%d+)$") or text:match("ุชุนูู ุนุฏุฏ ุงูุญุฐู (%d+)$") or text:match("ุชุนููู ุนุฏุฏ ุงูุญุฐู (%d+)$") or text:match("ุนุฏุฏ ุงููุณุญ (%d+)$")
if tonumber(Num) < 10 or tonumber(Num) > 1000 then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ุจุชุญุฏูุฏ ุนุฏุฏ ุงูุจุฑ ูู 10 ูุงุตุบุฑ ูู 1000 ููุญุฐู ุงูุชููุงุฆู', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ูุถุน โคฝ *'..Num..'* ูู ุงูููุฏูุง ููุญุฐู ุงูุชููุงุฆู', 1, 'md')
DevRio:set(storm..'Rio:CleanNum'..msg.chat_id_,Num) 
end end 
if msg and DevRio:get(storm..'Rio:Lock:CleanNum'..msg.chat_id_) then
if DevRio:get(storm..'Rio:CleanNum'..msg.chat_id_) then CleanNum = DevRio:get(storm..'Rio:CleanNum'..msg.chat_id_) else CleanNum = 200 end
if DevRio:scard(storm.."Rio:cleanernum"..msg.chat_id_) >= tonumber(CleanNum) then 
local List = DevRio:smembers(storm.."Rio:cleanernum"..msg.chat_id_)
local Del = 0
for k,v in pairs(List) do
Del = (Del + 1)
local Message = v
DeleteMessage(msg.chat_id_,{[0]=Message})
end
SendText(msg.chat_id_,"โ๏ธุชู ุญุฐู "..Del.." ูู ุงูููุฏูุง ุชููุงุฆูุง",0,'md') 
DevRio:del(storm.."Rio:cleanernum"..msg.chat_id_)
end 
end
if CleanerNum(msg) then
if DevRio:get(storm..'Rio:Lock:CleanNum'..msg.chat_id_) then 
if text == "ุงูุชููุงุฆู" and ChCheck(msg) or text == "ุนุฏุฏ ุงูุชููุงุฆู" and ChCheck(msg) then 
local M = DevRio:scard(storm.."Rio:cleanernum"..msg.chat_id_)
if M ~= 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุนุฏุฏ ุงูููุฏูุง โคฝ "..M.."\nโ๏ธุงูุญุฐู ุงูุชููุงุฆู โคฝ "..(DevRio:get(storm..'Rio:CleanNum'..msg.chat_id_) or 200), 1, 'md') 
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุงุชูุฌุฏ ููุฏูุง ููุง", 1, 'md') 
end end
end
end
--     Source Storm     --
if text == "ุชูุนูู ุงูุณุญ" and Constructor(msg) and ChCheck(msg) then
local stormTEAM = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุณุญ ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTEAM, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Lock:Clean'..msg.chat_id_,true)  
end
if text == "ุชุนุทูู ุงูุณุญ" and Constructor(msg) and ChCheck(msg) then
local stormTEAM = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุณุญ ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTEAM, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Lock:Clean'..msg.chat_id_) 
end
if Cleaner(msg) then
if DevRio:get(storm..'Rio:Lock:Clean'..msg.chat_id_) then 
if text == "ุงูููุฏูุง" and ChCheck(msg) or text == "ุนุฏุฏ ุงูููุฏูุง" and ChCheck(msg) then 
local M = DevRio:scard(storm.."Rio:cleaner"..msg.chat_id_)
if M ~= 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุนุฏุฏ ุงูููุฏูุง โคฝ "..M, 1, 'md') 
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุงุชูุฌุฏ ููุฏูุง ููุง", 1, 'md') 
end end
if text == "ุงูุณุญ" and ChCheck(msg) or text == "ุงุญุฐู" and ChCheck(msg) or text == "ุชูุธูู ููุฏูุง" and ChCheck(msg) or text == "ุชูุธูู ุงูููุฏูุง" and ChCheck(msg) then
local List = DevRio:smembers(storm.."Rio:cleaner"..msg.chat_id_)
local Del = 0
for k,v in pairs(List) do
Del = (Del + 1)
local Message = v
DeleteMessage(msg.chat_id_,{[0]=Message})
end
if Del ~= 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญุฐู "..Del.." ูู ุงูููุฏูุง", 1, 'md') 
DevRio:del(storm.."Rio:cleaner"..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุงุชูุฌุฏ ููุฏูุง ููุง", 1, 'md') 
end end 
end
end
--     Source Storm     --
if Admin(msg) then
if text == "ุชูุธูู ุชุนุฏูู" and ChCheck(msg) or text == "ุชูุธูู ุงูุชุนุฏูู" and ChCheck(msg) then   
Rio_Del = {[0]= msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
Rio_Del[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Rio_Del},function(arg,data)
new = 0
Rio_Del2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and (not data.messages_[i].edit_date_ or data.messages_[i].edit_date_ ~= 0) then
Rio_Del2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,Rio_Del2)
end,nil)  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุชูุธูู 100 ูู ุงูุฑุณุงุฆู ุงููุนุฏูู', 1, 'md')
end
--     Source Storm     --
if ChatType == 'sp' or ChatType == 'gp'  then
if Admin(msg) then
if text and text:match("^ูุชุญ (.*)$") and ChCheck(msg) then
local UnLockText = {string.match(text, "^(ูุชุญ) (.*)$")}
if UnLockText[2] == "ุงูุชุนุฏูู" then
if DevRio:get(storm..'Rio:Lock:EditMsgs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุชุนุฏูู")  
DevRio:del(storm..'Rio:Lock:EditMsgs'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุชุนุฏูู ุจุงููุนู ููุชูุญ ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุชุนุฏูู ุงูููุฏูุง" or UnLockText[2] == "ุชุนุฏูู ุงูููุฏูุง" then
if DevRio:get(storm..'Rio:Lock:EditMsgs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุชุนุฏูู ุงูููุฏูุง")  
DevRio:del(storm..'Rio:Lock:EditMsgs'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชุนุฏูู ุงูููุฏูุง ุจุงููุนู ููุชูุญ ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงููุงุฑุณูู" then
if DevRio:get(storm..'Rio:Lock:Farsi'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงููุงุฑุณูู")  
DevRio:del(storm..'Rio:Lock:Farsi'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุงุฑุณูู ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงููุดุงุฑ" then
if not DevRio:get(storm..'Rio:Lock:Fshar'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงููุดุงุฑ")  
DevRio:set(storm..'Rio:Lock:Fshar'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุดุงุฑ ุจุงููุนู ููุชูุญ ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุทุงุฆููู" then
if not DevRio:get(storm..'Rio:Lock:Taf'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุทุงุฆููู")  
DevRio:set(storm..'Rio:Lock:Taf'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุทุงุฆููู ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูููุฑ" then
if not DevRio:get(storm..'Rio:Lock:Kfr'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูููุฑ")  
DevRio:set(storm..'Rio:Lock:Kfr'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูููุฑ ุจุงููุนู ููุชูุญ ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงููุงุฑุณูู ุจุงูุทุฑุฏ" then
if DevRio:get(storm..'Rio:Lock:FarsiBan'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงููุงุฑุณูู ุจุงูุทุฑุฏ")  
DevRio:del(storm..'Rio:Lock:FarsiBan'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุงุฑุณูู ุจุงูุทุฑุฏ ุจุงููุนู ููุชูุญู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุจูุชุงุช" or UnLockText[2] == "ุงูุจูุชุงุช ุจุงูุทุฑุฏ" or UnLockText[2] == "ุงูุจูุชุงุช ุจุงูุชูููุฏ" or UnLockText[2] == "ุงูุจูุชุงุช ุจุงูุชููุฏ" then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุจูุชุงุช")  
DevRio:del(storm.."Rio:Lock:Bots"..msg.chat_id_)  
end
if UnLockText[2] == "ุงูุชูุฑุงุฑ" then 
DevRio:hdel(storm.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุชูุฑุงุฑ")  
end
if BasicConstructor(msg) then
if UnLockText[2] == "ุงูุชุซุจูุช" then
if DevRio:get(storm..'Rio:Lock:Pin'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุชุซุจูุช")  
DevRio:del(storm..'Rio:Lock:Pin'..msg.chat_id_)
DevRio:srem(storm.."Rio:Lock:Pinpin",msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุชุซุจูุช ุจุงููุนู ููุชูุญ ูู ุงููุฌููุนู', 1, 'md')
end end end
end
end
--     Source Storm     --
if Admin(msg) then
if text and text:match("^ููู (.*)$") and ChCheck(msg) then
local LockText = {string.match(text, "^(ููู) (.*)$")}
if LockText[2] == "ุงูุฏุฑุฏุดู" then
if not DevRio:get(storm..'Rio:Lock:Text'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุฏุฑุฏุดู")  
DevRio:set(storm..'Rio:Lock:Text'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุฏุฑุฏุดู ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุงูููุงูู" then
if not DevRio:get(storm..'Rio:Lock:Inline'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุงูููุงูู")  
DevRio:set(storm..'Rio:Lock:Inline'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุงูููุงูู ุจุงููุนู ูููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุตูุฑ" then
if not DevRio:get(storm..'Rio:Lock:Photo'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุตูุฑ")  
DevRio:set(storm..'Rio:Lock:Photo'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุตูุฑ ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูููุงูุด" then
if not DevRio:get(storm..'Rio:Lock:Spam'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูููุงูุด")  
DevRio:set(storm..'Rio:Lock:Spam'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูููุงูุด ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุฏุฎูู" then
if not DevRio:get(storm..'Rio:Lock:Join'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุฏุฎูู")  
DevRio:set(storm..'Rio:Lock:Join'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุฏุฎูู ุจุงููุนู ูููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูููุฏูู" then
if not DevRio:get(storm..'Rio:Lock:Videos'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูููุฏูู")  
DevRio:set(storm..'Rio:Lock:Videos'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูููุฏูู ุจุงููุนู ูููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงููุชุญุฑูู" then
if not DevRio:get(storm..'Rio:Lock:Gifs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงููุชุญุฑูู")  
DevRio:set(storm..'Rio:Lock:Gifs'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุชุญุฑูู ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุงุบุงูู" then
if not DevRio:get(storm..'Rio:Lock:Music'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุงุบุงูู")  
DevRio:set(storm..'Rio:Lock:Music'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุงุบุงูู ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุตูุช" then
if not DevRio:get(storm..'Rio:Lock:Voice'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุตูุช")  
DevRio:set(storm..'Rio:Lock:Voice'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุตูุช ุจุงููุนู ูููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุฑูุงุจุท" then
if not DevRio:get(storm..'Rio:Lock:Links'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุฑูุงุจุท")  
DevRio:set(storm..'Rio:Lock:Links'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุฑูุงุจุท ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูููุงูุน" then
if not DevRio:get(storm..'Rio:Lock:Location'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูููุงูุน")  
DevRio:set(storm..'Rio:Lock:Location'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูููุงูุน ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงููุนุฑู" or LockText[2] == "ุงููุนุฑูุงุช" then
if not DevRio:get(storm..'Rio:Lock:Tags'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงููุนุฑูุงุช")  
DevRio:set(storm..'Rio:Lock:Tags'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุนุฑูุงุช ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงููููุงุช" then
if not DevRio:get(storm..'Rio:Lock:Document'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงููููุงุช")  
DevRio:set(storm..'Rio:Lock:Document'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููููุงุช ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงููุงุดุชุงู" or LockText[2] == "ุงูุชุงู" then
if not DevRio:get(storm..'Rio:Lock:Hashtak'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงููุงุดุชุงู")  
DevRio:set(storm..'Rio:Lock:Hashtak'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุงุดุชุงู ุจุงููุนู ูููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุฌูุงุช" then
if not DevRio:get(storm..'Rio:Lock:Contact'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุฌูุงุช")  
DevRio:set(storm..'Rio:Lock:Contact'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '๏ธโ๏ธุงูุฌูุงุช ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุดุจูุงุช" then
if not DevRio:get(storm..'Rio:Lock:WebLinks'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุดุจูุงุช")  
DevRio:set(storm..'Rio:Lock:WebLinks'..msg.chat_id_,true) 
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุดุจูุงุช ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุนุฑุจูู" then
if not DevRio:get(storm..'Rio:Lock:Arabic'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุนุฑุจูู")  
DevRio:set(storm..'Rio:Lock:Arabic'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุฑุจูู ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุงููููุฒูู" then
if not DevRio:get(storm..'Rio:Lock:English'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุงููููุฒูู")  
DevRio:set(storm..'Rio:Lock:English'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุงููููุฒูู ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูููุตูุงุช" then
if not DevRio:get(storm..'Rio:Lock:Stickers'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูููุตูุงุช")  
DevRio:set(storm..'Rio:Lock:Stickers'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูููุตูุงุช ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงููุงุฑูุฏุงูู" then
if not DevRio:get(storm..'Rio:Lock:Markdown'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงููุงุฑูุฏุงูู")  
DevRio:set(storm..'Rio:Lock:Markdown'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุงุฑูุฏุงูู ุจุงููุนู ูููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุงุดุนุงุฑุงุช" then
if not DevRio:get(storm..'Rio:Lock:TagServr'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุงุดุนุงุฑุงุช")  
DevRio:set(storm..'Rio:Lock:TagServr'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุงุดุนุงุฑุงุช ุจุงููุนู ููููู ูู ุงููุฌููุนู', 1, 'md')
end
end
if LockText[2] == "ุงูุชูุฌูู" then
if not DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุชูุฌูู")  
DevRio:set(storm..'Rio:Lock:Forwards'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุชูุฌูู ุจุงููุนู ูููู ูู ุงููุฌููุนู', 1, 'md')
end
end
end
end
--     Source Storm     --
if Admin(msg) then
if text and text:match("^ูุชุญ (.*)$") and ChCheck(msg) then
local UnLockText = {string.match(text, "^(ูุชุญ) (.*)$")}
if UnLockText[2] == "ุงูุฏุฑุฏุดู" then
if DevRio:get(storm..'Rio:Lock:Text'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุฏุฑุฏุดู")  
DevRio:del(storm..'Rio:Lock:Text'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุฏุฑุฏุดู ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุตูุฑ" then
if DevRio:get(storm..'Rio:Lock:Photo'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุตูุฑ")  
DevRio:del(storm..'Rio:Lock:Photo'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุตูุฑ ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูููุงูุด" then
if DevRio:get(storm..'Rio:Lock:Spam'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูููุงูุด")  
DevRio:del(storm..'Rio:Lock:Spam'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูููุงูุด ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุฏุฎูู" then
if DevRio:get(storm..'Rio:Lock:Join'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุฏุฎูู")  
DevRio:del(storm..'Rio:Lock:Join'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุฏุฎูู ุจุงููุนู ููุชูุญ ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูููุฏูู" then
if DevRio:get(storm..'Rio:Lock:Videos'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูููุฏูู")  
DevRio:del(storm..'Rio:Lock:Videos'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูููุฏูู ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงููููุงุช" then
if DevRio:get(storm..'Rio:Lock:Document'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงููููุงุช")  
DevRio:del(storm..'Rio:Lock:Document'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููููุงุช ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุงูููุงูู" then
if DevRio:get(storm..'Rio:Lock:Inline'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุงูููุงูู")  
DevRio:del(storm..'Rio:Lock:Inline'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุงูููุงูู ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงููุงุฑูุฏุงูู" then
if DevRio:get(storm..'Rio:Lock:Markdown'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงููุงุฑูุฏุงูู")  
DevRio:del(storm..'Rio:Lock:Markdown'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุงุฑูุฏุงูู ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงููุชุญุฑูู" then
if DevRio:get(storm..'Rio:Lock:Gifs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงููุชุญุฑูู")  
DevRio:del(storm..'Rio:Lock:Gifs'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุชุญุฑูู ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุงุบุงูู" then
if DevRio:get(storm..'Rio:Lock:Music'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุงุบุงูู")  
DevRio:del(storm..'Rio:Lock:Music'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุงุบุงูู ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุตูุช" then
if DevRio:get(storm..'Rio:Lock:Voice'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุตูุช")  
DevRio:del(storm..'Rio:Lock:Voice'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุตูุช ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุฑูุงุจุท" then
if DevRio:get(storm..'Rio:Lock:Links'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุฑูุงุจุท")  
DevRio:del(storm..'Rio:Lock:Links'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุฑูุงุจุท ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูููุงูุน" then
if DevRio:get(storm..'Rio:Lock:Location'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูููุงูุน")  
DevRio:del(storm..'Rio:Lock:Location'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูููุงูุน ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงููุนุฑู" or UnLockText[2] == "ุงููุนุฑูุงุช" then
if DevRio:get(storm..'Rio:Lock:Tags'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงููุนุฑูุงุช")  
DevRio:del(storm..'Rio:Lock:Tags'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุนุฑูุงุช ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงููุงุดุชุงู" or UnLockText[2] == "ุงูุชุงู" then
if DevRio:get(storm..'Rio:Lock:Hashtak'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงููุงุดุชุงู")  
DevRio:del(storm..'Rio:Lock:Hashtak'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุงุดุชุงู ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุฌูุงุช" then
if DevRio:get(storm..'Rio:Lock:Contact'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุฌูุงุช")  
DevRio:del(storm..'Rio:Lock:Contact'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุฌูุงุช ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุดุจูุงุช" then
if DevRio:get(storm..'Rio:Lock:WebLinks'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุดุจูุงุช")  
DevRio:del(storm..'Rio:Lock:WebLinks'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุดุจูุงุช ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุนุฑุจูู" then
if DevRio:get(storm..'Rio:Lock:Arabic'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุนุฑุจูู")  
DevRio:del(storm..'Rio:Lock:Arabic'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุนุฑุจูู ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุงููููุฒูู" then
if DevRio:get(storm..'Rio:Lock:English'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุงููููุฒูู")  
DevRio:del(storm..'Rio:Lock:English'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุงููููุฒูู ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุงุดุนุงุฑุงุช" then
if DevRio:get(storm..'Rio:Lock:TagServr'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุงุดุนุงุฑุงุช")  
DevRio:del(storm..'Rio:Lock:TagServr'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุงุดุนุงุฑุงุช ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูููุตูุงุช" then
if DevRio:get(storm..'Rio:Lock:Stickers'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูููุตูุงุช")  
DevRio:del(storm..'Rio:Lock:Stickers'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูููุตูุงุช ุจุงููุนู ููุชูุญู ูู ุงููุฌููุนู', 1, 'md')
end
end
if UnLockText[2] == "ุงูุชูุฌูู" then
if DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุชูุฌูู")  
DevRio:del(storm..'Rio:Lock:Forwards'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุชูุฌูู ุจุงููุนู ููุชูุญ ูู ุงููุฌููุนู', 1, 'md')
end
end
end
end
--     Source Storm     --
if text and text:match("^ููู ุงูุชูููุด$") or text and text:match("^ุชูุนูู ุงูุญูุงูู ุงููุตูู$") and ChCheck(msg) then
if not Constructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธููููุดุฆูู ููุท', 1, 'md')
else
DevRio:set(storm.."Rio:Lock:Bots"..msg.chat_id_,"del") DevRio:hset(storm.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed") 
LockList ={'Rio:Lock:Links','Rio:Lock:Contact','Rio:Lock:Forwards','Rio:Lock:Videos','Rio:Lock:Gifs','Rio:Lock:EditMsgs','Rio:Lock:Stickers','Rio:Lock:Farsi','Rio:Lock:Spam','Rio:Lock:WebLinks','Rio:Lock:Photo'}
for i,Lock in pairs(LockList) do
DevRio:set(storm..Lock..msg.chat_id_,true)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุงูุชูููุด")  
end
end
if text and text:match("^ูุชุญ ุงูุชูููุด$") and ChCheck(msg) then
if not Constructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธููููุดุฆูู ููุท', 1, 'md')
else
DevRio:hdel(storm.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User") 
UnLockList ={'Rio:Lock:Links','Rio:Lock:Contact','Rio:Lock:Forwards','Rio:Lock:Videos','Rio:Lock:Gifs','Rio:Lock:EditMsgs','Rio:Lock:Stickers','Rio:Lock:Farsi','Rio:Lock:Spam','Rio:Lock:WebLinks','Rio:Lock:Photo'}
for i,UnLock in pairs(UnLockList) do
DevRio:del(storm..UnLock..msg.chat_id_)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุงูุชูููุด")  
end
end
--     Source Storm     --
if text and text:match("^ููู ุงููู$") and ChCheck(msg) then
if not Constructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธููููุดุฆูู ููุท', 1, 'md')
else
DevRio:del(storm..'Rio:Lock:Fshar'..msg.chat_id_) DevRio:del(storm..'Rio:Lock:Taf'..msg.chat_id_) DevRio:del(storm..'Rio:Lock:Kfr'..msg.chat_id_) 
DevRio:set(storm.."Rio:Lock:Bots"..msg.chat_id_,"del") DevRio:hset(storm.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed") 
LockList ={'Rio:Lock:EditMsgs','Rio:Lock:Farsi','Rio:Lock:TagServr','Rio:Lock:Inline','Rio:Lock:Photo','Rio:Lock:Spam','Rio:Lock:Videos','Rio:Lock:Gifs','Rio:Lock:Music','Rio:Lock:Voice','Rio:Lock:Links','Rio:Lock:Location','Rio:Lock:Tags','Rio:Lock:Stickers','Rio:Lock:Markdown','Rio:Lock:Forwards','Rio:Lock:Document','Rio:Lock:Contact','Rio:Lock:Hashtak','Rio:Lock:WebLinks'}
for i,Lock in pairs(LockList) do
DevRio:set(storm..Lock..msg.chat_id_,true)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ููู ุฌููุน ุงูุงูุงูุฑ")  
end
end
if text and text:match("^ูุชุญ ุงููู$") and ChCheck(msg) then
if not Constructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธููููุดุฆูู ููุท', 1, 'md')
else
DevRio:set(storm..'Rio:Lock:Fshar'..msg.chat_id_,true) DevRio:set(storm..'Rio:Lock:Taf'..msg.chat_id_,true) DevRio:set(storm..'Rio:Lock:Kfr'..msg.chat_id_,true) DevRio:hdel(storm.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User") 
UnLockList ={'Rio:Lock:EditMsgs','Rio:Lock:Text','Rio:Lock:Arabic','Rio:Lock:English','Rio:Lock:Join','Rio:Lock:Bots','Rio:Lock:Farsi','Rio:Lock:FarsiBan','Rio:Lock:TagServr','Rio:Lock:Inline','Rio:Lock:Photo','Rio:Lock:Spam','Rio:Lock:Videos','Rio:Lock:Gifs','Rio:Lock:Music','Rio:Lock:Voice','Rio:Lock:Links','Rio:Lock:Location','Rio:Lock:Tags','Rio:Lock:Stickers','Rio:Lock:Markdown','Rio:Lock:Forwards','Rio:Lock:Document','Rio:Lock:Contact','Rio:Lock:Hashtak','Rio:Lock:WebLinks'}
for i,UnLock in pairs(UnLockList) do
DevRio:del(storm..UnLock..msg.chat_id_)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ูุชุญ ุฌููุน ุงูุงูุงูุฑ")  
end
end
--     Source Storm     --
if Admin(msg) then
if text and (text:match("^ุถุน ุณุจุงู (%d+)$") or text:match("^ูุถุน ุณุจุงู (%d+)$")) then
local SetSpam = text:match("ุถุน ุณุจุงู (%d+)$") or text:match("ูุถุน ุณุจุงู (%d+)$")
if tonumber(SetSpam) < 40 then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงุฎุชุฑ ุนุฏุฏ ุงูุจุฑ ูู 40 ุญุฑู ', 1, 'md')
else
DevRio:set(storm..'Rio:Spam:Text'..msg.chat_id_,SetSpam)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ูุถุน ุนุฏุฏ ุงูุณุจุงู โคฝ'..SetSpam, 1, 'md')
end
end
end
--     Source Storm     --
if Manager(msg) then
if text == "ูุญุต" and ChCheck(msg) or text == "ูุญุต ุงูุจูุช" and ChCheck(msg) then
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..storm)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.can_change_info == true then EDT = 'โ๏ธ' else EDT = 'โ๏ธ' end
if GetInfo.result.can_delete_messages == true then DEL = 'โ๏ธ' else DEL = 'โ๏ธ' end
if GetInfo.result.can_invite_users == true then INV = 'โ๏ธ' else INV = 'โ๏ธ' end
if GetInfo.result.can_pin_messages == true then PIN = 'โ๏ธ' else PIN = 'โ๏ธ' end
if GetInfo.result.can_restrict_members == true then BAN = 'โ๏ธ' else BAN = 'โ๏ธ' end
if GetInfo.result.can_promote_members == true then VIP = 'โ๏ธ' else VIP = 'โ๏ธ' end 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุตูุงุญูุงุช ุงูุจูุช ูู โคฝ โค\nโ โ โ โ โ โ โ โ โ\nโ๏ธุญุฐู ุงูุฑุณุงุฆู โคฝ '..DEL..'\nโ๏ธุฏุนูุฉ ุงููุณุชุฎุฏููู โคฝ '..INV..'\nโ๏ธุญุธุฑ ุงููุณุชุฎุฏููู โคฝ '..BAN..'\nโ๏ธุชุซุจูุช ุงูุฑุณุงุฆู โคฝ '..PIN..'\nโ๏ธุชุบููุฑ ุงููุนูููุงุช โคฝ '..EDT..'\nโ๏ธุงุถุงูุฉ ูุดุฑููู โคฝ '..VIP..'\nโ โ โ โ โ โ โ โ โ', 1, 'md')
end end
if text and text:match("^ุชุบูุฑ ุฑุฏ ุงููุทูุฑ (.*)$") and ChCheck(msg) then
local Text = text:match("^ุชุบูุฑ ุฑุฏ ุงููุทูุฑ (.*)$") 
DevRio:set(storm.."Rio:SudoBot:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุชุบูุฑ ุฑุฏ ุงููุทูุฑ ุงูู โคฝ "..Text, 1, 'md')
end
if text and text:match("^ุชุบูุฑ ุฑุฏ ููุดุฆ ุงูุงุณุงุณู (.*)$") and ChCheck(msg) then
local Text = text:match("^ุชุบูุฑ ุฑุฏ ููุดุฆ ุงูุงุณุงุณู (.*)$") 
DevRio:set(storm.."Rio:BasicConstructor:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุชุบูุฑ ุฑุฏ ุงูููุดุฆ ุงูุงุณุงุณู ุงูู โคฝ "..Text, 1, 'md')
end
if text and text:match("^ุชุบูุฑ ุฑุฏ ุงูููุดุฆ (.*)$") and ChCheck(msg) then
local Text = text:match("^ุชุบูุฑ ุฑุฏ ุงูููุดุฆ (.*)$") 
DevRio:set(storm.."Rio:Constructor:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุชุบูุฑ ุฑุฏ ุงูููุดุฆ ุงูู โคฝ "..Text, 1, 'md')
end
if text and text:match("^ุชุบูุฑ ุฑุฏ ุงููุฏูุฑ (.*)$") and ChCheck(msg) then
local Text = text:match("^ุชุบูุฑ ุฑุฏ ุงููุฏูุฑ (.*)$") 
DevRio:set(storm.."Rio:Managers:Rd"..msg.chat_id_,Text) 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุชุบูุฑ ุฑุฏ ุงููุฏูุฑ ุงูู โคฝ "..Text, 1, 'md')
end
if text and text:match("^ุชุบูุฑ ุฑุฏ ุงูุงุฏูู (.*)$") and ChCheck(msg) then
local Text = text:match("^ุชุบูุฑ ุฑุฏ ุงูุงุฏูู (.*)$") 
DevRio:set(storm.."Rio:Admins:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุชุบูุฑ ุฑุฏ ุงูุงุฏูู ุงูู โคฝ "..Text, 1, 'md')
end
if text and text:match("^ุชุบูุฑ ุฑุฏ ุงููููุฒ (.*)$") and ChCheck(msg) then
local Text = text:match("^ุชุบูุฑ ุฑุฏ ุงููููุฒ (.*)$") 
DevRio:set(storm.."Rio:VipMem:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุชุบูุฑ ุฑุฏ ุงููููุฒ ุงูู โคฝ "..Text, 1, 'md')
end
if text and text:match("^ุชุบูุฑ ุฑุฏ ุงูููุธู (.*)$") and ChCheck(msg) then
local Text = text:match("^ุชุบูุฑ ุฑุฏ ุงูููุธู (.*)$") 
DevRio:set(storm.."Rio:Cleaner:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุชุบูุฑ ุฑุฏ ุงูููุธู ุงูู โคฝ "..Text, 1, 'md')
end
if text and text:match("^ุชุบูุฑ ุฑุฏ ุงูุนุถู (.*)$") and ChCheck(msg) then
local Text = text:match("^ุชุบูุฑ ุฑุฏ ุงูุนุถู (.*)$") 
DevRio:set(storm.."Rio:mem:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุชุบูุฑ ุฑุฏ ุงูุนุถู ุงูู โคฝ "..Text, 1, 'md')
end
if text == "ุญุฐู ุฑุฏูุฏ ุงูุฑุชุจ" or text == "ูุณุญ ุฑุฏูุฏ ุงูุฑุชุจ" and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญุฐู ุฌููุน ุฑุฏูุฏ ุงูุฑุชุจ", 1, 'md')
DevRio:del(storm.."Rio:mem:Rd"..msg.chat_id_)
DevRio:del(storm.."Rio:Cleaner:Rd"..msg.chat_id_)
DevRio:del(storm.."Rio:VipMem:Rd"..msg.chat_id_)
DevRio:del(storm.."Rio:Admins:Rd"..msg.chat_id_)
DevRio:del(storm.."Rio:Managers:Rd"..msg.chat_id_)
DevRio:del(storm.."Rio:Constructor:Rd"..msg.chat_id_)
DevRio:del(storm.."Rio:BasicConstructor:Rd"..msg.chat_id_)
DevRio:del(storm.."Rio:SudoBot:Rd"..msg.chat_id_)
end
end
--     Source Storm     --
if text == "ูุดู ุงูุจูุชุงุช" and ChCheck(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = 'โ๏ธ*ูุงุฆูุฉ ุงูุจูุชุงุช* โคฝ โค \nโ โ โ โ โ โ โ โ โ\n'
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,data) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
ab = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
ab = ' โฏ'
end
text = text.."~ [@"..data.username_..']'..ab.."\n"
if #admins == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชูุฌุฏ ุจูุชุงุช ููุง*", 1, 'md')
return false end
if #admins == i then 
local a = 'โ โ โ โ โ โ โ โ โ\nโ๏ธ*ุนุฏุฏ ุงูุจูุชุงุช ููุง* โคฝ '..n..'\n'
local f = 'โ๏ธ*ุนุฏุฏ ุงูุจูุชุงุช ุงููุฑููุนู* โคฝ '..t..'\nโ๏ธ*ููุงุญุถู ุนูุงูุฉ ุงูู*โฏ *ุชุนูู ุงู ุงูุจูุช ุงุฏูู ูู ูุฐู ุงููุฌููุนู*'
Dev_Rio(msg.chat_id_, msg.id_, 1, text..a..f, 1, 'md')
end
end,nil)
end
end,nil)
end
if text == 'ุญุฐู ุงูุจูุชุงุช' and ChCheck(msg) or text == 'ุทุฑุฏ ุงูุจูุชุงุช' and ChCheck(msg) or text == 'ูุณุญ ุงูุจูุชุงุช' and ChCheck(msg) then
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,dp)  
local admins = dp.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if dp.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(storm) then
ChatKick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ูุงุชูุฌุฏ ุจูุชุงุช ููุง*", 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธ*ุนุฏุฏ ุงูุจูุชุงุช ููุง* โคฝ "..c.."\nโ๏ธ*ุนุฏุฏ ุงูุจูุชุงุช ุงููุฑููุนู* โคฝ "..x.."\nโ๏ธ*ุชู ุทุฑุฏ* โคฝ "..(c - x).." *ูู ุงูุจูุชุงุช*", 1, 'md')
end 
end,nil)  
end 
--     Source Storm     --
end
--     Source Storm     --
if Admin(msg) then
if text and text:match("^ุญุฐู (.*)$") or text and text:match("^ูุณุญ (.*)$") and ChCheck(msg) then
local txts = {string.match(text, "^(ุญุฐู) (.*)$")}
local txtss = {string.match(text, "^(ูุณุญ) (.*)$")}
if Sudo(msg) then
if txts[2] == 'ุงูุงุณุงุณููู' or txtss[2] == 'ุงูุงุณุงุณููู' or txts[2] == 'ุงููุทูุฑูู ุงูุงุณุงุณููู' or txtss[2] == 'ุงููุทูุฑูู ุงูุงุณุงุณููู' then
DevRio:del(storm..'Rio:RioSudo:')
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงููุทูุฑูู ุงูุงุณุงุณููู")  
end
end
if RioSudo(msg) then
if txts[2] == 'ุงูุซุงููููู' or txtss[2] == 'ุงูุซุงููููู' or txts[2] == 'ุงููุทูุฑูู ุงูุซุงููููู' or txtss[2] == 'ุงููุทูุฑูู ุงูุซุงููููู' then
DevRio:del(storm..'Rio:SecondSudo:')
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงููุทูุฑูู ุงูุซุงููููู")  
end
end
if SecondSudo(msg) then 
if txts[2] == 'ุงููุทูุฑูู' or txtss[2] == 'ุงููุทูุฑูู' then
DevRio:del(storm..'Rio:SudoBot:')
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงููุทูุฑูู")  
end
if txts[2] == 'ูุงุฆูู ุงูุนุงู' or txtss[2] == 'ูุงุฆูู ุงูุนุงู' then
DevRio:del(storm..'Rio:BanAll:')
DevRio:del(storm..'Rio:MuteAll:')
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ูุงุฆูุฉ ุงูุนุงู")  
end
end
if SudoBot(msg) then
if txts[2] == 'ุงููุงูููู' or txtss[2] == 'ุงููุงูููู' then
DevRio:del(storm..'Rio:RioConstructor:'..msg.chat_id_)
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,dp) 
local admins = dp.members_
for i=0 , #admins do
if dp.members_[i].status_.ID == "ChatMemberStatusCreator" then
DevRio:sadd(storm.."Rio:RioConstructor:"..msg.chat_id_,admins[i].user_id_)
end 
end  
end,nil)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงููุงูููู")  
end
end
if RioConstructor(msg) then
if txts[2] == 'ุงูููุดุฆูู ุงูุงุณุงุณููู' or txtss[2] == 'ุงูููุดุฆูู ุงูุงุณุงุณููู' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงูููุดุฆูู ุงูุงุณุงุณููู")  
DevRio:del(storm..'Rio:BasicConstructor:'..msg.chat_id_)
end
end
if BasicConstructor(msg) then
if txts[2] == 'ุงูููุดุฆูู' or txtss[2] == 'ุงูููุดุฆูู' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงูููุดุฆูู")  
DevRio:del(storm..'Rio:Constructor:'..msg.chat_id_)
end end
if Constructor(msg) then
if txts[2] == 'ุงููุฏุฑุงุก' or txtss[2] == 'ุงููุฏุฑุงุก' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงููุฏุฑุงุก")  
DevRio:del(storm..'Rio:Managers:'..msg.chat_id_)
end 
if txts[2] == 'ุงูููุธููู' or txtss[2] == 'ุงูููุธููู' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงูููุธููู")  
DevRio:del(storm..'Rio:Cleaner:'..msg.chat_id_)
end end
if Manager(msg) then
if txts[2] == 'ุงูุงุฏูููู' or txtss[2] == 'ุงูุงุฏูููู' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงูุงุฏูููู")  
DevRio:del(storm..'Rio:Admins:'..msg.chat_id_)
end
end
if txts[2] == 'ููุงููู' or txtss[2] == 'ููุงููู' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงูููุงููู")  
DevRio:del(storm..'Rio:rules'..msg.chat_id_)
end
if txts[2] == 'ุงููุทุงูู' or txtss[2] == 'ุงููุทุงูู' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงููุทุงูู")  
DevRio:del(storm..'User:Donky:'..msg.chat_id_)
end
if txts[2] == 'ุงูุฑุงุจุท' or txtss[2] == 'ุงูุฑุงุจุท' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุฑุงุจุท ุงููุฌููุนู")  
DevRio:del(storm.."Rio:Groups:Links"..msg.chat_id_)
end
if txts[2] == 'ุงููููุฒูู' or txtss[2] == 'ุงููููุฒูู' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงููููุฒูู")  
DevRio:del(storm..'Rio:VipMem:'..msg.chat_id_)
end
if txts[2] == 'ุงูููุชูููู' or txtss[2] == 'ุงูููุชูููู' then
DevRio:del(storm..'Rio:Muted:'..msg.chat_id_)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงูููุชูููู")  
end
if txts[2] == 'ุงููููุฏูู' or txtss[2] == 'ุงููููุฏูู' then     
local List = DevRio:smembers(storm..'Rio:Tkeed:'..msg.chat_id_)
for k,v in pairs(List) do   
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..v.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True") 
DevRio:srem(storm..'Rio:Tkeed:'..msg.chat_id_, v)
end 
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงููููุฏูู")  
end
if txts[2] == 'ูุงุฆูู ุงูููุน' or txtss[2] == 'ูุงุฆูู ุงูููุน' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ูุงุฆูุฉ ุงูููุน")  
DevRio:del(storm..'Rio:Filters:'..msg.chat_id_)
end
if txts[2] == 'ููุงุฆู ุงูููุน' or txtss[2] == 'ููุงุฆู ุงูููุน' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ููุงุฆู ุงูููุน")  
DevRio:del(storm..'Rio:Filters:'..msg.chat_id_)
DevRio:del(storm.."Rio:FilterAnimation"..msg.chat_id_)
DevRio:del(storm.."Rio:FilterPhoto"..msg.chat_id_)
DevRio:del(storm.."Rio:FilterSteckr"..msg.chat_id_)
end
if txts[2] == 'ูุงุฆูู ููุน ุงููุชุญุฑูุงุช' or txtss[2] == 'ูุงุฆูู ููุน ุงููุชุญุฑูุงุช' then     
DevRio:del(storm.."Rio:FilterAnimation"..msg.chat_id_)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ูุงุฆูุฉ ููุน ุงููุชุญุฑูุงุช")  
end
if txts[2] == 'ูุงุฆูู ููุน ุงูุตูุฑ' or txtss[2] == 'ูุงุฆูู ููุน ุงูุตูุฑ' then     
DevRio:del(storm.."Rio:FilterPhoto"..msg.chat_id_)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ูุงุฆูุฉ ููุน ุงูุตูุฑ")  
end
if txts[2] == 'ูุงุฆูู ููุน ุงูููุตูุงุช' or txtss[2] == 'ูุงุฆูู ููุน ุงูููุตูุงุช' then     
DevRio:del(storm.."Rio:FilterSteckr"..msg.chat_id_)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ูุงุฆูุฉ ููุน ุงูููุตูุงุช")  
end
end
end
--     Source Storm     --
if text and text:match("^ุญุฐู ุงูููุงุฆู$") and ChCheck(msg) or text and text:match("^ูุณุญ ุงูููุงุฆู$") and ChCheck(msg) then
if not BasicConstructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธููููุดุฆ ุงูุงุณุงุณู ููุท', 1, 'md')
else
DevRio:del(storm..'Rio:Ban:'..msg.chat_id_) DevRio:del(storm..'Rio:Admins:'..msg.chat_id_) DevRio:del(storm..'User:Donky:'..msg.chat_id_) DevRio:del(storm..'Rio:VipMem:'..msg.chat_id_) DevRio:del(storm..'Rio:Filters:'..msg.chat_id_) DevRio:del(storm..'Rio:Muted:'..msg.chat_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญุฐู โคฝ โจ ูุงุฆูุฉ ุงูููุน โข ุงููุญุธูุฑูู โข ุงูููุชูููู โข ุงูุงุฏูููู โข ุงููููุฒูู โข ุงููุทุงูู โฉ ุจูุฌุงุญ \n โ", 1, 'md')
end end
--     Source Storm     --
if text and text:match("^ุญุฐู ุฌููุน ุงูุฑุชุจ$") and ChCheck(msg) or text and text:match("^ูุณุญ ุฌููุน ุงูุฑุชุจ$") and ChCheck(msg) or text and text:match("^ุชูุฒูู ุฌููุน ุงูุฑุชุจ$") and ChCheck(msg) then
if not RioConstructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุงูููู ููุท', 1, 'md')
else
local basicconstructor = DevRio:smembers(storm..'Rio:BasicConstructor:'..msg.chat_id_)
local constructor = DevRio:smembers(storm..'Rio:Constructor:'..msg.chat_id_)
local Managers = DevRio:smembers(storm..'Rio:Managers:'..msg.chat_id_)
local admins = DevRio:smembers(storm..'Rio:Admins:'..msg.chat_id_)
local vipmem = DevRio:smembers(storm..'Rio:VipMem:'..msg.chat_id_)
local donky = DevRio:smembers(storm..'User:Donky:'..msg.chat_id_)
if #basicconstructor ~= 0 then basicconstructort = 'ุงูููุดุฆูู ุงูุงุณุงุณููู โข ' else basicconstructort = '' end
if #constructor ~= 0 then constructort = 'ุงูููุดุฆูู โข ' else constructort = '' end
if #Managers ~= 0 then Managerst = 'ุงููุฏุฑุงุก โข ' else Managerst = '' end
if #admins ~= 0 then adminst = 'ุงูุงุฏูููู โข ' else adminst = '' end
if #vipmem ~= 0 then vipmemt = 'ุงููููุฒูู โข ' else vipmemt = '' end
if #donky ~= 0 then donkyt = 'ุงููุทุงูู โข ' else donkyt = '' end
if #basicconstructor ~= 0 or #constructor ~= 0 or #Managers ~= 0 or #admins ~= 0 or #vipmem ~= 0 or #donky ~= 0 then 
DevRio:del(storm..'Rio:BasicConstructor:'..msg.chat_id_)
DevRio:del(storm..'Rio:Constructor:'..msg.chat_id_)
DevRio:del(storm..'Rio:Managers:'..msg.chat_id_)
DevRio:del(storm..'Rio:Admins:'..msg.chat_id_)
DevRio:del(storm..'Rio:VipMem:'..msg.chat_id_)
DevRio:del(storm..'User:Donky:'..msg.chat_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญุฐู ุฌููุน ุงูุฑุชุจ ุงูุชุงููู โคฝ โจ "..basicconstructort..constructort..Managerst..adminst..vipmemt..donkyt.." โฉ ุจูุฌุงุญ \n โ", 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุงุชูุฌุฏ ุฑุชุจ ููุง", 1, 'md')
end 
end 
end
--     Source Storm     --
if Admin(msg) then 
if text and text:match("^ุงูุงุนุฏุงุฏุงุช$") and ChCheck(msg) then
if not DevRio:get(storm..'Rio:Spam:Text'..msg.chat_id_) then
spam_c = 400
else
spam_c = DevRio:get(storm..'Rio:Spam:Text'..msg.chat_id_)
end
--     Source Storm     --
if DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_, "Spam:User") == "kick" then     
flood = "ุจุงูุทุฑุฏ"     
elseif DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Spam:User") == "keed" then     
flood = "ุจุงูุชููุฏ"     
elseif DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Spam:User") == "mute" then     
flood = "ุจุงููุชู"           
elseif DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Spam:User") == "del" then     
flood = "ุจุงูุญุฐู"
else     
flood = "ููุชูุญ"     
end
--     Source Storm     --
if DevRio:get(storm.."Rio:Lock:Bots"..msg.chat_id_) == "del" then
lock_bots = "ุจุงูุญุฐู"
elseif DevRio:get(storm.."Rio:Lock:Bots"..msg.chat_id_) == "ked" then
lock_bots = "ุจุงูุชููุฏ"   
elseif DevRio:get(storm.."Rio:Lock:Bots"..msg.chat_id_) == "kick" then
lock_bots = "ุจุงูุทุฑุฏ"    
else
lock_bots = "ููุชูุญู"    
end
--     Source Storm     --
if DevRio:get(storm..'Rio:Lock:Text'..msg.chat_id_) then mute_text = 'ููููู' else mute_text = 'ููุชูุญู'end
if DevRio:get(storm..'Rio:Lock:Photo'..msg.chat_id_) then mute_photo = 'ููููู' else mute_photo = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Videos'..msg.chat_id_) then mute_video = 'ููููู' else mute_video = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Gifs'..msg.chat_id_) then mute_gifs = 'ููููู' else mute_gifs = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Music'..msg.chat_id_) then mute_music = 'ููููู' else mute_music = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Inline'..msg.chat_id_) then mute_in = 'ููููู' else mute_in = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Voice'..msg.chat_id_) then mute_voice = 'ููููู' else mute_voice = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:EditMsgs'..msg.chat_id_) then mute_edit = 'ููููู' else mute_edit = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Links'..msg.chat_id_) then mute_links = 'ููููู' else mute_links = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Pin'..msg.chat_id_) then lock_pin = 'ููููู' else lock_pin = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Stickers'..msg.chat_id_) then lock_sticker = 'ููููู' else lock_sticker = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:TagServr'..msg.chat_id_) then lock_tgservice = 'ููููู' else lock_tgservice = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:WebLinks'..msg.chat_id_) then lock_wp = 'ููููู' else lock_wp = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Hashtak'..msg.chat_id_) then lock_htag = 'ููููู' else lock_htag = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Tags'..msg.chat_id_) then lock_tag = 'ููููู' else lock_tag = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Location'..msg.chat_id_) then lock_location = 'ููููู' else lock_location = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Contact'..msg.chat_id_) then lock_contact = 'ููููู' else lock_contact = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:English'..msg.chat_id_) then lock_english = 'ููููู' else lock_english = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Arabic'..msg.chat_id_) then lock_arabic = 'ููููู' else lock_arabic = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then lock_forward = 'ููููู' else lock_forward = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Document'..msg.chat_id_) then lock_file = 'ููููู' else lock_file = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Markdown'..msg.chat_id_) then markdown = 'ููููู' else markdown = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Spam'..msg.chat_id_) then lock_spam = 'ููููู' else lock_spam = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Join'..msg.chat_id_) then lock_Join = 'ูููู' else lock_Join = 'ููุชูุญ' end
if DevRio:get(storm.."Rio:Lock:Welcome"..msg.chat_id_) then send_welcome = 'ููููู' else send_welcome = 'ููุชูุญู' end
if DevRio:get(storm..'Rio:Lock:Fshar'..msg.chat_id_) then lock_fshar = 'ููุชูุญ' else lock_fshar = 'ูููู' end
if DevRio:get(storm..'Rio:Lock:Kfr'..msg.chat_id_) then lock_kaf = 'ููุชูุญ' else lock_kaf = 'ูููู' end
if DevRio:get(storm..'Rio:Lock:Taf'..msg.chat_id_) then lock_taf = 'ููุชูุญู' else lock_taf = 'ููููู' end
if DevRio:get(storm..'Rio:Lock:Farsi'..msg.chat_id_) then lock_farsi = 'ููููู' else lock_farsi = 'ููุชูุญู' end
local Flood_Num = DevRio:hget(storm.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5
--     Source Storm     --
local TXTE = "โ๏ธุงุนุฏุงุฏุงุช ุงููุฌููุนู โคฝ โค\nโ โ โ โ โ โ โ โ โ\n"
.."โ๏ธุงูุฑูุงุจุท โคฝ "..mute_links.."\n"
.."โ๏ธุงููุนุฑู โคฝ "..lock_tag.."\n"
.."โ๏ธุงูุจูุชุงุช โคฝ "..lock_bots.."\n"
.."โ๏ธุงููุชุญุฑูู โคฝ "..mute_gifs.."\n"
.."โ๏ธุงูููุตูุงุช โคฝ "..lock_sticker.."\n"
.."โ๏ธุงููููุงุช โคฝ "..lock_file.."\n"
.."โ๏ธุงูุตูุฑ โคฝ "..mute_photo.."\n"
.."โ๏ธุงูููุฏูู โคฝ "..mute_video.."\n"
.."โ๏ธุงูุงูููุงูู โคฝ "..mute_in.."\n"
.."โ๏ธุงูุฏุฑุฏุดู โคฝ "..mute_text.."\n"
.."โ๏ธุงูุชูุฌูู โคฝ "..lock_forward.."\n"
.."โ๏ธุงูุงุบุงูู โคฝ "..mute_music.."\n"
.."โ๏ธุงูุตูุช โคฝ "..mute_voice.."\n"
.."โ๏ธุงูุฌูุงุช โคฝ "..lock_contact.."\n"
.."โ๏ธุงููุงุฑูุฏุงูู โคฝ "..markdown.."\n"
.."โ๏ธุงููุงุดุชุงู โคฝ "..lock_htag.."\n"
.."โ๏ธุงูุชุนุฏูู โคฝ "..mute_edit.."\n"
.."โ๏ธุงูุชุซุจูุช โคฝ "..lock_pin.."\n"
.."โ๏ธุงูุงุดุนุงุฑุงุช โคฝ "..lock_tgservice.."\n"
.."โ๏ธุงูููุงูุด โคฝ "..lock_spam.."\n"
.."โ๏ธุงูุฏุฎูู โคฝ "..lock_Join.."\n"
.."โ๏ธุงูุดุจูุงุช โคฝ "..lock_wp.."\n"
.."โ๏ธุงูููุงูุน โคฝ "..lock_location.."\n"
.."โ๏ธุงููุดุงุฑ โคฝ "..lock_fshar.."\n"
.."โ๏ธุงูููุฑ โคฝ "..lock_kaf.."\n"
.."โ๏ธุงูุทุงุฆููู โคฝ "..lock_taf.."\n"
.."โ๏ธุงูุนุฑุจูู โคฝ "..lock_arabic.."\n"
.."โ๏ธุงูุงููููุฒูู โคฝ "..lock_english.."\n"
.."โ๏ธุงููุงุฑุณูู โคฝ "..lock_farsi.."\n"
.."โ๏ธุงูุชูุฑุงุฑ โคฝ "..flood.."\n"
.."โ๏ธุนุฏุฏ ุงูุชูุฑุงุฑ โคฝ "..Flood_Num.."\n"
.."โ๏ธุนุฏุฏ ุงูุณุจุงู โคฝ "..spam_c.."\n"
.."โ โ โ โ โ โ โ โ โ\nโ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)\n"
Dev_Rio(msg.chat_id_, msg.id_, 1, TXTE, 1, 'md')
end
end
--     Source Storm     --
if text and text:match("^ููู (.*)$") and ChCheck(msg) then
local txt = {string.match(text, "^(ููู) (.*)$")}
Dev_Rio(msg.chat_id_,0, 1, txt[2], 1, 'md')
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if text == "ุชูุนูู ุงูุทู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ููุฒุฉ ุงูุทู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Antk:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ุงูุทู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ููุฒุฉ ุงูุทู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Antk:Rio'..msg.chat_id_,true)  
end
if text and text:match("^ุงูุทู (.*)$") and not DevRio:get(storm..'Rio:Antk:Rio'..msg.chat_id_) and ChCheck(msg) then
local UrlAntk = https.request('https://apiabs.ml/Antk.php?abs='..URL.escape(text:match("^ุงูุทู (.*)$")))
Antk = JSON.decode(UrlAntk)
if UrlAntk.ok ~= false then
download_to_file("https://translate"..Antk.result.google..Antk.result.code.."UTF-8"..Antk.result.utf..Antk.result.translate.."&tl=ar-IN",Antk.result.translate..'.mp3') 
sendAudio(msg.chat_id_, msg.id_, 0, 1,nil, './'..Antk.result.translate..'.mp3')  
os.execute('rm -rf ./'..Antk.result.translate..'.mp3') 
end
end
--     Source Storm     --
if DevRio:get(storm..'Rio:setrules'..msg.chat_id_..':'..msg.sender_user_id_) then 
if text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุญูุธ ููุงููู ุงููุฌููุนู', 1, 'md')
DevRio:del(storm..'Rio:setrules'..msg.chat_id_..':'..msg.sender_user_id_)
return false  
end 
DevRio:del(storm..'Rio:setrules'..msg.chat_id_..':'..msg.sender_user_id_)
DevRio:set(storm..'Rio:rules'..msg.chat_id_,text)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญูุธ ููุงููู ุงููุฌููุนู', 1, 'md')
return false   
end
if text and text:match("^ุถุน ููุงููู$") and ChCheck(msg) or text and text:match("^ูุถุน ููุงููู$") and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงุฑุณู ูู ุงูููุงููู ุงูุงู', 1, 'md')
DevRio:set(storm..'Rio:setrules'..msg.chat_id_..':'..msg.sender_user_id_,true)
end
end
if text and text:match("^ุงูููุงููู$") and ChCheck(msg) then
local rules = DevRio:get(storm..'Rio:rules'..msg.chat_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, rules, 1, nil)
end
--     Source Storm     --
if text == 'ุฑููู' and ChCheck(msg) then
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.phone_number_  then
MyNumber = "โ๏ธุฑููู โคฝ +"..result.phone_number_
else
MyNumber = "โ๏ธุฑููู ููุถูุน ูุฌูุงุช ุงุชุตุงูู ููุท"
end
send(msg.chat_id_, msg.id_,MyNumber)
end,nil)
end
--     Source Storm     --
if text == "ุชูุนูู ุงูุฒุฎุฑูู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุฒุฎุฑูู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Zrf:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ุงูุฒุฎุฑูู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุฒุฎุฑูู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Zrf:Rio'..msg.chat_id_,true)  
end
if DevRio:get(storm..'Zrf:Rio'..msg.chat_id_..msg.sender_user_id_) then 
if text and text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุฑ ุงูุฒุฎุฑูู', 1, 'md')
DevRio:del(storm..'Zrf:Rio'..msg.chat_id_..msg.sender_user_id_)
return false  
end 
UrlZrf = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(text)) 
Zrf = JSON.decode(UrlZrf) 
t = "โ๏ธูุงุฆูุฉ ุงูุฒุฎุฑูู โคฝ โค\nโ โ โ โ โ โ โ โ โ\n"
i = 0
for k,v in pairs(Zrf.ok) do
i = i + 1
t = t..i.."~ `"..v.."` \n"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'md')
DevRio:del(storm..'Zrf:Rio'..msg.chat_id_..msg.sender_user_id_)
return false   
end
if not DevRio:get(storm..'Rio:Zrf:Rio'..msg.chat_id_) then
if text == 'ุฒุฎุฑูู' and ChCheck(msg) or text == 'ุงูุฒุฎุฑูู' and ChCheck(msg) then  
DevRio:setex(storm.."Zrf:Rio"..msg.chat_id_..msg.sender_user_id_,300,true)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงุฑุณู ูู ุงููููู ูุฒุฎุฑูุชูุง \nููููู ุงูุฒุฎุฑูุฉ ุจุงููุบู { en } ~ { ar } ', 1, 'md')
end
end
if not DevRio:get(storm..'Rio:Zrf:Rio'..msg.chat_id_) then
if text and text:match("^ุฒุฎุฑูู (.*)$") and ChCheck(msg) or text and text:match("^ุฒุฎุฑู (.*)$") and ChCheck(msg) then 
local TextZrf = text:match("^ุฒุฎุฑูู (.*)$") or text:match("^ุฒุฎุฑู (.*)$") 
UrlZrf = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(TextZrf)) 
Zrf = JSON.decode(UrlZrf) 
t = "โ๏ธูุงุฆูุฉ ุงูุฒุฎุฑูู โคฝ โค\nโ โ โ โ โ โ โ โ โ\n"
i = 0
for k,v in pairs(Zrf.ok) do
i = i + 1
t = t..i.."~ `"..v.."` \n"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'md')
end
end
--     Source Storm     --
if text == "ุชูุนูู ุงูุงุจุฑุงุฌ" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุงุจุฑุงุฌ ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Brg:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ุงูุงุจุฑุงุฌ" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุงุจุฑุงุฌ ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Brg:Rio'..msg.chat_id_,true)  
end
if not DevRio:get(storm..'Rio:Brg:Rio'..msg.chat_id_) then
if text and text:match("^ุจุฑุฌ (.*)$") and ChCheck(msg) or text and text:match("^ุจุฑุฌู (.*)$") and ChCheck(msg) then 
local TextBrg = text:match("^ุจุฑุฌ (.*)$") or text:match("^ุจุฑุฌู (.*)$") 
UrlBrg = https.request('https://apiabs.ml/brg.php?brg='..URL.escape(TextBrg)) 
Brg = JSON.decode(UrlBrg) 
t = Brg.ok.abs  
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
end
--     Source Storm     --
if text and (text == "ุชูุนูู ุงูุงูุฑ ุงููุณุจ" or text == "ุชูุนูู ูุณุจู ุงูุญุจ" or text == "ุชูุนูู ูุณุจู ุงููุฑู" or text == "ุชูุนูู ูุณุจู ุงูุฑุฌููู" or text == "ุชูุนูู ูุณุจู ุงูุงููุซู" or text == "ุชูุนูู ูุณุจู ุงูุบุจุงุก") and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุงูุฑ ุงููุณุจ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Nsba:Rio'..msg.chat_id_) 
end
if text and (text == "ุชุนุทูู ุงูุงูุฑ ุงููุณุจ" or text == "ุชุนุทูู ูุณุจู ุงูุญุจ" or text == "ุชุนุทูู ูุณุจู ุงููุฑู" or text == "ุชุนุทูู ูุณุจู ุงูุฑุฌููู" or text == "ุชุนุทูู ูุณุจู ุงูุงููุซู" or text == "ุชุนุทูู ูุณุจู ุงูุบุจุงุก") and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุงูุฑ ุงููุณุจ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Nsba:Rio'..msg.chat_id_,true)  
end
if not DevRio:get(storm..'Rio:Nsba:Rio'..msg.chat_id_) then
if text == "ูุณุจู ุงูุญุจ" and ChCheck(msg) or text == "ูุณุจุฉ ุงูุญุจ" and ChCheck(msg) then
DevRio:set(storm..'LoveNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ุจุงุฑุณู ุงุณููู ูุญุณุงุจ ูุณุจุฉ ุงูุญุจ ุจููููุง ููุซุงู โคฝ ุฌุงู ู ุฑูุฒ', 1, 'md')
end
end
if text and text ~= "ูุณุจู ุงูุญุจ" and text ~= "ูุณุจุฉ ุงูุญุจ" and DevRio:get(storm..'LoveNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุฑ ูุณุจุฉ ุงูุญุจ ', 1, 'md')
DevRio:del(storm..'LoveNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุณุจุฉ ุงูุญุจ ุจูู '..text..' ูู : '..Rio..'%', 1, 'md')
DevRio:del(storm..'LoveNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevRio:get(storm..'Rio:Nsba:Rio'..msg.chat_id_) then
if text == "ูุณุจู ุงูุฎูุงูู" and ChCheck(msg) or text == "ูุณุจุฉ ุงูุฎูุงูู" and ChCheck(msg) or text == "โคฝ ูุณุจู ุงูุฎูุงูู โ" and ChCheck(msg) then
DevRio:set(storm..'RyNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ุจุงุฑุณู ุงุณููู ูุญุณุงุจ ูุณุจุฉ ุงูุฎูุงูู ุจููููุง ููุซุงู โคฝ ุฌุงู ู ุฑูุฒ', 1, 'md')
end
end
if text and text ~= "ูุณุจู ุงูุฎูุงูู" and text ~= "ูุณุจุฉ ุงูุฎูุงูู" and text ~= "โคฝ ูุณุจู ุงูุฎูุงูู โ" and DevRio:get(storm..'RyNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุฑ ูุณุจุฉ ุงูุฎูุงูู ', 1, 'md')
DevRio:del(storm..'RyNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุณุจุฉ ุงูุฎูุงูู ุจูู '..text..' ูู : '..Rio..'%', 1, 'md')
DevRio:del(storm..'RyNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevRio:get(storm..'Rio:Nsba:Rio'..msg.chat_id_) then
if text and (text == "ูุณุจู ุงูุฌูุงู" or text == "ูุณุจุฉ ุงูุฌูุงู" or text == "โคฝ ูุณุจู ุงูุฌูุงู โ") and ChCheck(msg) then
DevRio:set(storm..'JNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ุจุงุฑุณู ุงุณู ุงูุดุฎุต ูููุงุณ ูุณุจุฉ ุฌูุงูู ููุซุงู โคฝ ุฌุงู ุงู ุฑูุฒ', 1, 'md')
end
end
if text and text ~= "ูุณุจู ุงูุฌูุงู" and text ~= "ูุณุจุฉ ุงูุฌูุงู" and text ~= "โคฝ ูุณุจู ุงูุฌูุงู โ" and DevRio:get(storm..'JNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุฑ ูุณุจุฉ ุงูุฌูุงู ', 1, 'md')
DevRio:del(storm..'JNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุณุจุฉ ุฌูุงู '..text..' ูู : '..Rio..'%', 1, 'md')
DevRio:del(storm..'JNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevRio:get(storm..'Rio:Nsba:Rio'..msg.chat_id_) then
if text == "ูุณุจู ุงููุฑู" and ChCheck(msg) or text == "ูุณุจุฉ ุงููุฑู" and ChCheck(msg) or text == "โคฝ ูุณุจู ุงููุฑู โ" and ChCheck(msg) then
DevRio:set(storm..'HataNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ุจุงุฑุณู ุงุณููู ูุญุณุงุจ ูุณุจุฉ ุงููุฑู ุจููููุง ููุซุงู โคฝ ุฌุงู ู ุฑูุฒ', 1, 'md')
end
end
if text and text ~= "ูุณุจู ุงููุฑู" and text ~= "ูุณุจุฉ ุงููุฑู" and text ~= "โคฝ ูุณุจู ุงููุฑู โ" and DevRio:get(storm..'HataNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุฑ ูุณุจุฉ ุงููุฑู ', 1, 'md')
DevRio:del(storm..'HataNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุณุจุฉ ุงููุฑู ุจูู '..text..' ูู : '..Rio..'%', 1, 'md')
DevRio:del(storm..'HataNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevRio:get(storm..'Rio:Nsba:Rio'..msg.chat_id_) then
if text and (text == "ูุณุจู ุงูุฑุฌููู" or text == "ูุณุจุฉ ุงูุฑุฌููู" or text == "ูุณุจู ุฑุฌููู" or text == "ูุณุจุฉ ุฑุฌููู" or text == "โคฝ ูุณุจู ุงูุฑุฌููู โ") and ChCheck(msg) then
DevRio:set(storm..'RjolaNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ุจุงุฑุณู ุงุณู ุงูุดุฎุต ูููุงุณ ูุณุจุฉ ุฑุฌููุชู ููุซุงู โคฝ ุฌุงู', 1, 'md')
end
end
if text and text ~= "ูุณุจู ุงูุฑุฌููู" and text ~= "ูุณุจุฉ ุงูุฑุฌููู" and text ~= "ูุณุจู ุฑุฌููู" and text ~= "ูุณุจุฉ ุฑุฌููู" and text ~= "โคฝ ูุณุจู ุงูุฑุฌููู โ" and DevRio:get(storm..'RjolaNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุฑ ูุณุจุฉ ุงูุฑุฌููู ', 1, 'md')
DevRio:del(storm..'RjolaNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุณุจุฉ ุฑุฌููุฉ '..text..' ูู : '..Rio..'%', 1, 'md')
DevRio:del(storm..'RjolaNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevRio:get(storm..'Rio:Nsba:Rio'..msg.chat_id_) then
if text and (text == "ูุณุจู ุงูุงููุซู" or text == "ูุณุจุฉ ุงูุงููุซู" or text == "ูุณุจู ุงููุซู" or text == "ูุณุจุฉ ุงููุซู" or text == "โคฝ ูุณุจู ุงูุงููุซู โ") and ChCheck(msg) then
DevRio:set(storm..'AnothaNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ุจุงุฑุณู ุงุณู ุงูุดุฎุต ูููุงุณ ูุณุจุฉ ุงููุซุชู ููุซุงู โคฝ ุฑูุฒ', 1, 'md')
end
end
if text and text ~= "ูุณุจู ุงูุงููุซู" and text ~= "ูุณุจุฉ ุงูุงููุซู" and text ~= "ูุณุจู ุงููุซู" and text ~= "ูุณุจุฉ ุงููุซู" and text ~= "โคฝ ูุณุจู ุงูุงููุซู โ" and DevRio:get(storm..'AnothaNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุฑ ูุณุจุฉ ุงูุงููุซู ', 1, 'md')
DevRio:del(storm..'AnothaNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุณุจุฉ ุงููุซุฉ '..text..' ูู : '..Rio..'%', 1, 'md')
DevRio:del(storm..'AnothaNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevRio:get(storm..'Rio:Nsba:Rio'..msg.chat_id_) then
if text and (text == "ูุณุจู ุงูุบุจุงุก" or text == "ูุณุจุฉ ุงูุบุจุงุก" or text == "โคฝ ูุณุจู ุงูุบุจุงุก โ") and ChCheck(msg) then
DevRio:set(storm..'StupidNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ุจุงุฑุณู ุงุณู ุงูุดุฎุต ูููุงุณ ูุณุจุฉ ุบุจุงุฆู ููุซุงู โคฝ ุฌุงู ุงู ุฑูุฒ', 1, 'md')
end
end
if text and text ~= "ูุณุจู ุงูุบุจุงุก" and text ~= "ูุณุจุฉ ุงูุบุจุงุก" and text ~= "โคฝ ูุณุจู ุงูุบุจุงุก โ" and DevRio:get(storm..'StupidNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'ุงูุบุงุก' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุบุงุก ุงูุฑ ูุณุจุฉ ุงูุบุจุงุก ', 1, 'md')
DevRio:del(storm..'StupidNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุณุจุฉ ุบุจุงุก '..text..' ูู : '..Rio..'%', 1, 'md')
DevRio:del(storm..'StupidNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
--     Source Storm     --
if text == "ุชูุนูู ุญุณุงุจ ุงูุนูุฑ" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุญุณุงุจ ุงูุนูุฑ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Age:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ุญุณุงุจ ุงูุนูุฑ" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุญุณุงุจ ุงูุนูุฑ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Age:Rio'..msg.chat_id_,true)  
end
if not DevRio:get(storm..'Rio:Age:Rio'..msg.chat_id_) then
if text and text:match("^ุงุญุณุจ (.*)$") and ChCheck(msg) or text and text:match("^ุนูุฑู (.*)$") and ChCheck(msg) then 
local TextAge = text:match("^ุงุญุณุจ (.*)$") or text:match("^ุนูุฑู (.*)$") 
UrlAge = https.request('https://apiabs.ml/age.php?age='..URL.escape(TextAge)) 
Age = JSON.decode(UrlAge) 
t = Age.ok.abs
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
end
--     Source Storm     --
if text == "ุชูุนูู ูุนุงูู ุงูุงุณูุงุก" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ูุนุงูู ุงูุงุณูุงุก'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Mean:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ูุนุงูู ุงูุงุณูุงุก" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ูุนุงูู ุงูุงุณูุงุก'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Mean:Rio'..msg.chat_id_,true)  
end
if not DevRio:get(storm..'Rio:Mean:Rio'..msg.chat_id_) then
if text and text:match("^ูุนูู ุงูุงุณู (.*)$") and ChCheck(msg) or text and text:match("^ูุนูู ุงุณู (.*)$") and ChCheck(msg) then 
local TextMean = text:match("^ูุนูู ุงูุงุณู (.*)$") or text:match("^ูุนูู ุงุณู (.*)$") 
UrlMean = https.request('https://apiabs.ml/Mean.php?Abs='..URL.escape(TextMean)) 
Mean = JSON.decode(UrlMean) 
t = Mean.ok.abs
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
end
--     Source Storm     --
if text == "ุชูุนูู ูุชุญุฑูู" and Manager(msg) and ChCheck(msg) or text == "ุชูุนูู ุงููุชุญุฑูู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงููุชุญุฑูู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:gif:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ูุชุญุฑูู" and Manager(msg) and ChCheck(msg) or text == "ุชุนุทูู ุงููุชุญุฑูู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงููุชุญุฑูู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:gif:Rio'..msg.chat_id_,true)  
end
if text and (text == "ูุชุญุฑูู" or text == "โคฝ ูุชุญุฑูู โ") and not DevRio:get(storm..'Rio:gif:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(2,1075); 
local Text ='*โ๏ธุชู ุงุฎุชูุงุฑ ุงููุชุญุฑูู ูู*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'โ storm team .',url="t.me/So_ST0RM"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendanimation?chat_id=' .. msg.chat_id_ .. '&animation=https://t.me/GifDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Storm     --
if text == "ุชูุนูู ูููุฒ" and Manager(msg) and ChCheck(msg) or text == "ุชูุนูู ุงููููุฒ" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงููููุฒ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:memz:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ูููุฒ" and Manager(msg) and ChCheck(msg) or text == "ุชุนุทูู ุงููููุฒ" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงููููุฒ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:memz:Rio'..msg.chat_id_,true)  
end
if text and (text == "ูููุฒ" or text == "โคฝ ูููุฒ โ") and not DevRio:get(storm..'Rio:memz:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(2,1201); 
local Text ='*โ๏ธุชู ุงุฎุชูุงุฑ ููุทุน ุงููููุฒ ูู*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'โ storm team .',url="t.me/So_ST0RM"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice=https://t.me/MemzDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Storm     --
if text == "ุชูุนูู ุบูููู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุบูููู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Audios:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ุบูููู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุบูููู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Audios:Rio'..msg.chat_id_,true)  
end
if text and (text == "ุบูููู" or text == "โคฝ ุบูููู โ") and not DevRio:get(storm..'Rio:Audios:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(4,2725); 
local Text ='*โ๏ธุชู ุงุฎุชูุงุฑ ุงูููุทุน ุงูุตูุชู ูู*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'โ storm team .',url="t.me/So_ST0RM"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice=https://t.me/AudiosDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Storm     --
if text == "ุชูุนูู ุงูุงุบุงูู" and Manager(msg) and ChCheck(msg) or text == "ุชูุนูู ุงุบููู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุงุบุงูู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:mp3:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ุงูุงุบุงูู" and Manager(msg) and ChCheck(msg) or text == "ุชุนุทูู ุงุบููู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุงุบุงูู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:mp3:Rio'..msg.chat_id_,true)  
end
if text and (text == "ุงุบููู" or text == "โคฝ ุงุบููู โ" or text == "ุงุบุงูู") and not DevRio:get(storm..'Rio:mp3:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(2,1167); 
local Text ='*โ๏ธุชู ุงุฎุชูุงุฑ ุงูุงุบููู ูู*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'โ storm team .',url="t.me/So_ST0RM"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice=https://t.me/stormMp3/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Storm     --
if text == "ุชูุนูู ุฑูููุณ" and Manager(msg) and ChCheck(msg) or text == "ุชูุนูู ุงูุฑูููุณ" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุฑูููุณ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Remix:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ุฑูููุณ" and Manager(msg) and ChCheck(msg) or text == "ุชุนุทูู ุงูุฑูููุณ" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุฑูููุณ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Remix:Rio'..msg.chat_id_,true)  
end
if text and (text == "ุฑูููุณ" or text == "โคฝ ุฑูููุณ โ") and not DevRio:get(storm..'Rio:Remix:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(2,612); 
local Text ='*โ๏ธุชู ุงุฎุชูุงุฑ ุงูุฑูููุณ ูู*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'โ storm team .',url="t.me/So_ST0RM"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice=https://t.me/RemixDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Storm     --
if text == "ุชูุนูู ุตูุฑู" and Manager(msg) and ChCheck(msg) or text == "ุชูุนูู ุงูุตูุฑู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุตูุฑู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Photo:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ุตูุฑู" and Manager(msg) and ChCheck(msg) or text == "ุชุนุทูู ุงูุตูุฑู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุตูุฑู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Photo:Rio'..msg.chat_id_,true)  
end
if text and (text == "ุตูุฑู" or text == "โคฝ ุตูุฑู โ") and not DevRio:get(storm..'Rio:Photo:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(4,1122); 
local Text ='*โ๏ธุชู ุงุฎุชูุงุฑ ุงูุตูุฑู ูู*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'โ storm team .',url="t.me/So_ST0RM"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendphoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/PhotosDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Storm     --
if text == "ุชูุนูู ุงููู" and Manager(msg) and ChCheck(msg) or text == "ุชูุนูู ุงูุงููู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุงููู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Anime:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ุงููู" and Manager(msg) and ChCheck(msg) or text == "ุชุนุทูู ุงูุงููู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุงููู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Anime:Rio'..msg.chat_id_,true)  
end
if text and (text == "ุงููู" or text == "โคฝ ุงููู โ") and not DevRio:get(storm..'Rio:Anime:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(3,1002); 
local Text ='*โ๏ธุชู ุงุฎุชูุงุฑ ุตูุฑุฉ ุงูุงููู ูู*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'โ storm team .',url="t.me/So_ST0RM"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendphoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/AnimeDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Storm     --
if text == "ุชูุนูู ููู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุงููุงู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Movies:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ููู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุงููุงู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Movies:Rio'..msg.chat_id_,true)  
end
if text and (text == "ููู" or text == "โคฝ ููู โ") and not DevRio:get(storm..'Rio:Movies:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(45,125); 
local Text ='*โ๏ธุชู ุงุฎุชูุงุฑ ุงูููู ูู*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'โ storm team .',url="t.me/So_ST0RM"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendphoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/MoviesDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Storm     --
if text == "ุชูุนูู ูุณูุณู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงููุณูุณูุงุช'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Series:Rio'..msg.chat_id_) 
end
if text == "ุชุนุทูู ูุณูุณู" and Manager(msg) and ChCheck(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงููุณูุณูุงุช'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Series:Rio'..msg.chat_id_,true)  
end
if text and (text == "ูุณูุณู" or text == "โคฝ ูุณูุณู โ") and not DevRio:get(storm..'Rio:Series:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(2,54); 
local Text ='*โ๏ธุชู ุงุฎุชูุงุฑ ุงููุณูุณู ูู*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = 'โ storm team .',url="t.me/So_ST0RM"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendphoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/SeriesDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Storm     --
if Admin(msg) then
if DevRio:get(storm..'Rio:LockSettings'..msg.chat_id_) then 
if text == "ุงูุฑูุงุจุท" then if DevRio:get(storm..'Rio:Lock:Links'..msg.chat_id_) then mute_links = 'ููููู' else mute_links = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูุฑูุงุจุท โคฝ "..mute_links.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงููุนุฑู" or text == "ุงููุนุฑูุงุช" then if DevRio:get(storm..'Rio:Lock:Tags'..msg.chat_id_) then lock_tag = 'ูููููู' else lock_tag = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงููุนุฑู โคฝ "..lock_tag.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงููุชุญุฑูู" or text == "ุงูููุตูุงุช ุงููุชุญุฑูู" then if DevRio:get(storm..'Rio:Lock:Gifs'..msg.chat_id_) then mute_gifs = 'ูููููู' else mute_gifs = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงููุชุญุฑูู โคฝ "..mute_gifs.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูููุตูุงุช" then if DevRio:get(storm..'Rio:Lock:Stickers'..msg.chat_id_) then lock_sticker = 'ูููููู' else lock_sticker = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูููุตูุงุช โคฝ "..lock_sticker.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุตูุฑ" then if DevRio:get(storm..'Rio:Lock:Photo'..msg.chat_id_) then mute_photo = 'ูููููู' else mute_photo = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูุตูุฑ โคฝ "..mute_photo.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูููุฏูู" or text == "ุงูููุฏูููุงุช" then if DevRio:get(storm..'Rio:Lock:Videos'..msg.chat_id_) then mute_video = 'ูููููู' else mute_video = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูููุฏูู โคฝ "..mute_video.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุงูููุงูู" then if DevRio:get(storm..'Rio:Lock:Inline'..msg.chat_id_) then mute_in = 'ูููู' else mute_in = 'ููุชูุญ' end local stormTeam = "\n" .."โ๏ธุงูุงูููุงูู โคฝ "..mute_in.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุฏุฑุฏุดู" then if DevRio:get(storm..'Rio:Lock:Text'..msg.chat_id_) then mute_text = 'ููููู' else mute_text = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูุฏุฑุฏุดู โคฝ "..mute_text.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุชูุฌูู" or text == "ุงุนุงุฏู ุงูุชูุฌูู" then if DevRio:get(storm..'Rio:Lock:Forwards'..msg.chat_id_) then lock_forward = 'ูููู' else lock_forward = 'ููุชูุญ' end local stormTeam = "\n" .."โ๏ธุงูุชูุฌูู โคฝ "..lock_forward.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุงุบุงูู" then if DevRio:get(storm..'Rio:Lock:Music'..msg.chat_id_) then mute_music = 'ูููููู' else mute_music = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูุงุบุงูู โคฝ "..mute_music.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุตูุช" or text == "ุงูุตูุชูุงุช" then if DevRio:get(storm..'Rio:Lock:Voice'..msg.chat_id_) then mute_voice = 'ููููู' else mute_voice = 'ููุชูุญ' end local stormTeam = "\n" .."โ๏ธุงูุตูุช โคฝ "..mute_voice.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุฌูุงุช" or text == "ุฌูุงุช ุงูุงุชุตุงู" then if DevRio:get(storm..'Rio:Lock:Contact'..msg.chat_id_) then lock_contact = 'ูููููู' else lock_contact = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูุฌูุงุช โคฝ "..lock_contact.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงููุงุฑูุฏุงูู" then if DevRio:get(storm..'Rio:Lock:Markdown'..msg.chat_id_) then markdown = 'ูููู' else markdown = 'ููุชูุญ' end local stormTeam = "\n" .."โ๏ธุงููุงุฑูุฏุงูู โคฝ "..markdown.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงููุงุดุชุงู" then if DevRio:get(storm..'Rio:Lock:Hashtak'..msg.chat_id_) then lock_htag = 'ูููู' else lock_htag = 'ููุชูุญ' end local stormTeam = "\n" .."โ๏ธุงููุงุดุชุงู โคฝ "..lock_htag.."\n"Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุชุนุฏูู" then if DevRio:get(storm..'Rio:Lock:EditMsgs'..msg.chat_id_) then mute_edit = 'ูููู' else mute_edit = 'ููุชูุญ' end local stormTeam = "\n" .."โ๏ธุงูุชุนุฏูู โคฝ "..mute_edit.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุชุซุจูุช" then if DevRio:get(storm..'Rio:Lock:Pin'..msg.chat_id_) then lock_pin = 'ูููู' else lock_pin = 'ููุชูุญ' end local stormTeam = "\n" .."โ๏ธุงูุชุซุจูุช โคฝ "..lock_pin.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุงุดุนุงุฑุงุช" then if DevRio:get(storm..'Rio:Lock:TagServr'..msg.chat_id_) then lock_tgservice = 'ูููููู' else lock_tgservice = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูุงุดุนุงุฑุงุช โคฝ "..lock_tgservice.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูููุงูุด" then if DevRio:get(storm..'Rio:Lock:Spam'..msg.chat_id_) then lock_spam = 'ูููููู' else lock_spam = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูููุงูุด โคฝ "..lock_spam.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุฏุฎูู" then if DevRio:get(storm..'Rio:Lock:Join'..msg.chat_id_) then lock_Join = 'ููููู' else lock_Join = 'ููุชูุญ' end local stormTeam = "\n" .."โ๏ธุงูุฏุฎูู โคฝ "..lock_Join.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุดุจูุงุช" then if DevRio:get(storm..'Rio:Lock:WebLinks'..msg.chat_id_) then lock_wp = 'ูููููู' else lock_wp = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูุดุจูุงุช โคฝ "..lock_wp.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูููุงูุน" then if DevRio:get(storm..'Rio:Lock:Location'..msg.chat_id_) then lock_location = 'ูููููู' else lock_location = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูููุงูุน โคฝ "..lock_location.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุนุฑุจูู" then if DevRio:get(storm..'Rio:Lock:Arabic'..msg.chat_id_) then lock_arabic = 'ูููููู' else lock_arabic = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูุนุฑุจูู โคฝ "..lock_arabic.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุงููููุฒูู" then if DevRio:get(storm..'Rio:Lock:English'..msg.chat_id_) then lock_english = 'ูููููู' else lock_english = 'ููุชูุญู' end local stormTeam = "\n" .."โ๏ธุงูุงููููุฒูู โคฝ "..lock_english.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูููุฑ" then if DevRio:get(storm..'Rio:Lock:Kfr'..msg.chat_id_) then lock_kaf = 'ููุชูุญ' else lock_kaf = 'ูููู' end local stormTeam = "\n" .."โ๏ธุงูููุฑ โคฝ "..lock_kaf.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงููุดุงุฑ" then if DevRio:get(storm..'Rio:Lock:Fshar'..msg.chat_id_) then lock_fshar = 'ููุชูุญ' else lock_fshar = 'ูููู' end local stormTeam = "\n" .."โ๏ธุงููุดุงุฑ โคฝ "..lock_fshar.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
if text == "ุงูุทุงุฆููู" then if DevRio:get(storm..'Rio:Lock:Taf'..msg.chat_id_) then lock_taf = 'ููุชูุญู' else lock_taf = 'ููููู' end local stormTeam = "\n" .."โ๏ธุงูุทุงุฆููู โคฝ "..lock_taf.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, stormTeam, 1, 'md') end
end
--     Source Storm     --
if text == 'ุชูุนูู ูุดู ุงูุงุนุฏุงุฏุงุช' and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ูุดู ุงูุงุนุฏุงุฏุงุช'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:LockSettings'..msg.chat_id_,true)  
end
if text == 'ุชุนุทูู ูุดู ุงูุงุนุฏุงุฏุงุช' and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ูุดู ุงูุงุนุฏุงุฏุงุช'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:LockSettings'..msg.chat_id_) 
end
--     Source Storm     --
if text == 'ุชูุนูู ุงูุงูุฑ ุงูุชุญุดูุด' and Manager(msg) and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุงูุฑ ุงูุชุญุดูุด'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Lock:Stupid'..msg.chat_id_)
end
if text == 'ุชุนุทูู ุงูุงูุฑ ุงูุชุญุดูุด' and Manager(msg) and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุงูุฑ ุงูุชุญุดูุด'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Lock:Stupid'..msg.chat_id_,true)
end
--     Source Storm     --
if text and (text == 'ุชุนุทูู ุงูุชุญูู' or text == 'ููู ุงูุชุญูู' or text == 'ุชุนุทูู ุชูุจูู ุงูุฏุฎูู') and Manager(msg) and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุชุญูู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Lock:Robot'..msg.chat_id_)
end
if text and (text == 'ุชูุนูู ุงูุชุญูู' or text == 'ูุชุญ ุงูุชุญูู' or text == 'ุชูุนูู ุชูุจูู ุงูุฏุฎูู') and Manager(msg) and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุชุญูู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Lock:Robot'..msg.chat_id_,true)
end
--     Source Storm     --
if text == 'ุชูุนูู ุฑุฏูุฏ ุงููุฏูุฑ' and Manager(msg) and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุฑุฏูุฏ ุงููุฏูุฑ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Lock:GpRed'..msg.chat_id_)
end
if text == 'ุชุนุทูู ุฑุฏูุฏ ุงููุฏูุฑ' and Manager(msg) and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุฑุฏูุฏ ุงููุฏูุฑ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Lock:GpRed'..msg.chat_id_,true)
end
--     Source Storm     --
if text == 'ุชูุนูู ุฑุฏูุฏ ุงููุทูุฑ' and Manager(msg) and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุฑุฏูุฏ ุงููุทูุฑ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Lock:AllRed'..msg.chat_id_)
end
if text == 'ุชุนุทูู ุฑุฏูุฏ ุงููุทูุฑ' and Manager(msg) and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุฑุฏูุฏ ุงููุทูุฑ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Lock:AllRed'..msg.chat_id_,true)
end
--     Source Storm     --
if SecondSudo(msg) then
if text == 'ุชูุนูู ุงููุบุงุฏุฑู' or text == 'โคฝ ุชูุนูู ุงููุบุงุฏุฑู โ' and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงููุบุงุฏุฑู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm.."Rio:Left:Bot"..storm)
end
if text == 'ุชุนุทูู ุงููุบุงุฏุฑู' or text == 'โคฝ ุชุนุทูู ุงููุบุงุฏุฑู โ' and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงููุบุงุฏุฑู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm.."Rio:Left:Bot"..storm,true) 
end 
if text == 'ุชูุนูู ุงูุงุฐุงุนู' or text == 'โคฝ ุชูุนูู ุงูุงุฐุงุนู โ' and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุงุฐุงุนู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm.."Rio:Send:Bot"..storm)
end
if text == 'ุชุนุทูู ุงูุงุฐุงุนู' or text == 'โคฝ ุชุนุทูู ุงูุงุฐุงุนู โ' and ChCheck(msg) then 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุงุฐุงุนู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm.."Rio:Send:Bot"..storm,true) 
end
end
--     Source Storm     --
if text and text:match("^ุถุน ุงุณู (.*)$") and Manager(msg) and ChCheck(msg) then
local txt = {string.match(text, "^(ุถุน ุงุณู) (.*)$")}
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = txt[2] },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"โ๏ธุงูุจูุช ููุณ ุงุฏูู ูุฑุฌู ุชุฑููุชู !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"โ๏ธููุณุช ูุฏู ุตูุงุญูุฉ ุชุบูุฑ ูุนูููุงุช ุงููุฌููุนู ูุฑุฌู ุงูุชุญูู ูู ุงูุตูุงุญูุงุช")  
else
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุบูุฑ ุงุณู ุงููุฌููุนู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end
end,nil) 
end
--     Source Storm     --
if msg.content_.photo_ then
if DevRio:get(storm..'Rio:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_) then
if msg.content_.photo_.sizes_[3] then
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,"โ๏ธุนุฐุฑุง ุงูุจูุช ููุณ ุงุฏูู ูุฑุฌู ุชุฑููุชู ูุงููุญุงููู ูุงุญูุง") 
DevRio:del(storm..'Rio:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_)
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,"โ๏ธููุณุช ูุฏู ุตูุงุญูุฉ ุชุบูุฑ ูุนูููุงุช ุงููุฌููุนู ูุฑุฌู ุงูุชุญูู ูู ุงูุตูุงุญูุงุช") 
DevRio:del(storm..'Rio:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_)
else
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุบูุฑ ุตูุฑุฉ ุงููุฌููุนู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end
end,nil) 
DevRio:del(storm..'Rio:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_)
end 
end
if text and text:match("^ุถุน ุตูุฑู$") and ChCheck(msg) or text and text:match("^ูุถุน ุตูุฑู$") and ChCheck(msg) then
Dev_Rio(msg.chat_id_,msg.id_, 1, 'โ๏ธุงุฑุณู ุตูุฑุฉ ุงููุฌููุนู ุงูุงู', 1, 'md')
DevRio:set(storm..'Rio:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_,true)
end
--     Source Storm     --
if text and text:match("^ุญุฐู ุงูุตูุฑู$") and ChCheck(msg) or text and text:match("^ูุณุญ ุงูุตูุฑู$") and ChCheck(msg) then
https.request("https://api.telegram.org/bot"..TokenBot.."/deleteChatPhoto?chat_id="..msg.chat_id_) 
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุตูุฑุฉ ุงููุฌููุนู")  
return false  
end
--     Source Storm     --
if Manager(msg) then
if text and text:match("^ุงูุบุงุก ุชุซุจูุช$") and ChCheck(msg) or text and text:match("^ุงูุบุงุก ุงูุชุซุจูุช$") and ChCheck(msg) then
if DevRio:sismember(storm.."Rio:Lock:Pinpin",msg.chat_id_) and not BasicConstructor(msg) then
Dev_Rio(msg.chat_id_,msg.id_, 1, "โ๏ธุงูุชุซุจูุช ูุงูุบุงุก ูุงุนุงุฏุฉ ุงูุชุซุจูุช ุชู ูููู ูู ูุจู ุงูููุดุฆูู ุงูุงุณุงุณููู", 1, 'md')
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
if data.ID == "Ok" then
DevRio:del(storm..'Rio:PinnedMsg'..msg.chat_id_)
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุงูุบุงุก ุชุซุจูุช ุงูุฑุณุงูู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
return false  
end
if data.code_ == 6 then
send(msg.chat_id_,msg.id_,"โ๏ธุงูุง ูุณุช ุงุฏูู ููุง ูุฑุฌู ุชุฑููุชู ุงุฏูู ุซู ุงุนุฏ ุงููุญุงููู")  
return false  
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"โ๏ธููุณุช ูุฏู ุตูุงุญูุฉ ุงูุชุซุจูุช ูุฑุฌู ุงูุชุญูู ูู ุงูุตูุงุญูุงุช")  
return false  
end
end,nil)
end
--     Source Storm     --
if text and text:match("^ุงูุบุงุก ุชุซุจูุช ุงููู$") and ChCheck(msg) then  
if DevRio:sismember(storm.."Rio:Lock:Pinpin",msg.chat_id_) and not BasicConstructor(msg) then
Dev_Rio(msg.chat_id_,msg.id_, 1, "โ๏ธุงูุชุซุจูุช ูุงูุบุงุก ูุงุนุงุฏุฉ ุงูุชุซุจูุช ุชู ูููู ูู ูุจู ุงูููุดุฆูู ุงูุงุณุงุณููู", 1, 'md')
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
if data.ID == "Ok" then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุงูุบุงุก ุชุซุจูุช ุงููู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
https.request('https://api.telegram.org/bot'..TokenBot..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
DevRio:del(storm.."Rio:PinnedMsg"..msg.chat_id_)
return false  
end
if data.code_ == 6 then
send(msg.chat_id_,msg.id_,"โ๏ธุงูุง ูุณุช ุงุฏูู ููุง ูุฑุฌู ุชุฑููุชู ุงุฏูู ุซู ุงุนุฏ ุงููุญุงููู")  
return false  
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"โ๏ธููุณุช ูุฏู ุตูุงุญูุฉ ุงูุชุซุจูุช ูุฑุฌู ุงูุชุญูู ูู ุงูุตูุงุญูุงุช")  
return false  
end
end,nil)
end
--     Source Storm     --
if text and text:match("^ุงุนุงุฏู ุชุซุจูุช$") and ChCheck(msg) or text and text:match("^ุงุนุงุฏู ุงูุชุซุจูุช$") and ChCheck(msg) or text and text:match("^ุงุนุงุฏุฉ ุงูุชุซุจูุช$") and ChCheck(msg) then
if DevRio:sismember(storm.."Rio:Lock:Pinpin",msg.chat_id_) and not BasicConstructor(msg) then
Dev_Rio(msg.chat_id_,msg.id_, 1, "โ๏ธุงูุชุซุจูุช ูุงูุบุงุก ูุงุนุงุฏุฉ ุงูุชุซุจูุช ุชู ูููู ูู ูุจู ุงูููุดุฆูู ุงูุงุณุงุณููู", 1, 'md')
return false  
end
local PinId = DevRio:get(storm..'Rio:PinnedMsg'..msg.chat_id_)
if PinId then
Pin(msg.chat_id_,PinId,0)
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุงุนุงุฏุฉ ุชุซุจูุช ุงูุฑุณุงูู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end end
end
--     Source Storm     --
if text == 'ุทุฑุฏ ุงููุญุฐูููู' and ChCheck(msg) or text == 'ูุณุญ ุงููุญุฐูููู' and ChCheck(msg) or text == 'ุทุฑุฏ ุงูุญุณุงุจุงุช ุงููุญุฐููู' and ChCheck(msg) or text == 'ุญุฐู ุงููุญุฐูููู' and ChCheck(msg) then  
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
ChatKick(msg.chat_id_, data.id_)
end
end,nil)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุทุฑุฏ ุงููุญุฐูููู")  
end,nil)
end
--     Source Storm     --
if text and text:match("^ูุณุญ ุงููุญุธูุฑูู$") or text and text:match("^ุญุฐู ุงููุญุธูุฑูู$") and ChCheck(msg) or text and text:match("^ูุณุญ ุงููุทุฑูุฏูู$") or text and text:match("^ุญุฐู ุงููุทุฑูุฏูู$") and ChCheck(msg) then
local function RemoveBlockList(extra, result)
if tonumber(result.total_count_) == 0 then 
Dev_Rio(msg.chat_id_, msg.id_, 0,'โ๏ธ*ูุง ููุฌุฏ ูุญุธูุฑูู*', 1, 'md')
DevRio:del(storm..'Rio:Ban:'..msg.chat_id_)
else
local x = 0
for x,y in pairs(result.members_) do
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = y.user_id_, status_ = { ID = "ChatMemberStatusLeft" }, }, dl_cb, nil)
DevRio:del(storm..'Rio:Ban:'..msg.chat_id_)
x = x + 1
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงููุญุธูุฑูู")  
end
end
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersKicked"},offset_ = 0,limit_ = 200}, RemoveBlockList, {chat_id_ = msg.chat_id_, msg_id_ = msg.id_})    
end
end
--     Source Storm     --
if text and text:match("^ูุนูููุงุช ุงููุฌููุนู$") and ChCheck(msg) or text and text:match("^ุนุฏุฏ ุงูุงุนุถุงุก$") and ChCheck(msg) or text and text:match("^ุนุฏุฏ ุงูุฌุฑูุจ$") and ChCheck(msg) or text and text:match("^ุนุฏุฏ ุงูุงุฏูููู$") and ChCheck(msg) or text and text:match("^ุนุฏุฏ ุงููุญุธูุฑูู$") and ChCheck(msg) then
local Muted = DevRio:scard(storm.."Rio:Muted:"..msg.chat_id_) or "0"
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุฌููุนู โคฝ โจ '..dp.title_..' โฉ\nโ๏ธุงูุงูุฏู โคฝ โจ '..msg.chat_id_..' โฉ\nโ๏ธุนุฏุฏ ุงูุงุนุถุงุก โคฝ โจ *'..data.member_count_..'* โฉ\nโ๏ธุนุฏุฏ ุงูุงุฏูููู โคฝ โจ *'..data.administrator_count_..'* โฉ\nโ๏ธุนุฏุฏ ุงููุทุฑูุฏูู โคฝ โจ *'..data.kicked_count_..'* โฉ\nโ๏ธุนุฏุฏ ุงูููุชูููู โคฝ โจ *'..Muted..'* โฉ\nโ๏ธุนุฏุฏ ุฑุณุงุฆู ุงููุฌููุนู โคฝ โจ *'..(msg.id_/2097152/0.5)..'* โฉ\nโ โ โ โ โ โ โ โ โ\n', 1, 'md') 
end,nil)
end,nil)
end
--     Source Storm     --
if text and text:match('^ูุดู (-%d+)') and ChCheck(msg) then
local ChatId = text:match('ูุดู (-%d+)') 
if not SudoBot(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑูู ููุท', 1, 'md')
else
local ConstructorList = DevRio:scard(storm.."Rio:Constructor:"..ChatId) or 0
local BanedList = DevRio:scard(storm.."Rio:Ban:"..ChatId) or 0
local ManagerList = DevRio:scard(storm.."Rio:Managers:"..ChatId) or 0
local MutedList = DevRio:scard(storm.."Rio:Muted:"..ChatId) or 0
local TkeedList = DevRio:scard(storm.."Rio:Rio:Tkeed:"..ChatId) or 0
local AdminsList = DevRio:scard(storm.."Rio:Admins:"..ChatId) or 0
local VipList = DevRio:scard(storm.."Rio:VipMem:"..ChatId) or 0
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..ChatId))
if LinkGp.ok == true then LinkGroup = LinkGp.result else LinkGroup = 't.me/So_ST0RM' end
tdcli_function({ID ="GetChat",chat_id_=ChatId},function(arg,dp)
tdcli_function ({ID = "GetChannelMembers",channel_id_ = ChatId:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
if dp.id_ then
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
Manager_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = Manager_id},function(arg,Rio) 
if Rio.first_name_ ~= false then
ConstructorRio = "["..Rio.first_name_.."](T.me/"..(Rio.username_ or "So_ST0RM")..")"
else 
ConstructorRio = "ุญุณุงุจ ูุญุฐูู"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงููุฌููุนู โคฝ ["..dp.title_.."]("..LinkGroup..")\nโ๏ธุงูุงูุฏู โคฝ ( `"..ChatId.."` )\nโ๏ธุงูููุดุฆ โคฝ "..ConstructorRio.."\nโ๏ธุนุฏุฏ ุงููุฏุฑุงุก โคฝ ( *"..ManagerList.."* )\nโ๏ธุนุฏุฏ ุงูููุดุฆูู โคฝ ( *"..ConstructorList.."* )\nโ๏ธุนุฏุฏ ุงูุงุฏูููู โคฝ ( *"..AdminsList.."* )\nโ๏ธุนุฏุฏ ุงููููุฒูู โคฝ ( *"..VipList.."* )\nโ๏ธุนุฏุฏ ุงููุญุธูุฑูู โคฝ ( *"..BanedList.."* )\nโ๏ธุนุฏุฏ ุงููููุฏูู โคฝ ( *"..TkeedList.."* )\nโ๏ธุนุฏุฏ ุงูููุชูููู โคฝ ( *"..MutedList.."* )", 1,"md")
end,nil)
end
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูู ุชุชู ุงุถุงูุชู ุจูุง ูุงููู ุจูุดููุง", 1, "md")
end
end,nil)
end,nil)
end 
end
--     Source Storm     --
if text and text:match("^ุบุงุฏุฑ (-%d+)$") and ChCheck(msg) then
local Text = { string.match(text, "^(ุบุงุฏุฑ) (-%d+)$")}
if not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท', 1, 'md')
else 
tdcli_function({ID ="GetChat",chat_id_=Text[2]},function(arg,dp) 
if dp.id_ then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงููุฌููุนู โคฝ ["..dp.title_.."]\nโ๏ธุชูุช ุงููุบุงุฏุฑู ูููุง ุจูุฌุงุญ", 1, "md")
Dev_Rio(Text[2], 0, 1, "โ๏ธุจุงูุฑ ุงููุทูุฑ ุชู ูุบุงุฏุฑุฉ ูุฐู ุงููุฌููุนู ", 1, "md")  
ChatLeave(dp.id_, storm)
DevRio:srem(storm.."Rio:Groups", dp.id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูู ุชุชู ุงุถุงูุชู ุจูุง ูุงููู ุจูุบุงุฏุฑุชูุง", 1, "md")
end 
end,nil)
end 
end
--     Source Storm     --
if text and text:match("^ุชุนูู ุนุฏุฏ ุงูุงุนุถุงุก (%d+)$") and SecondSudo(msg) or text and text:match("^ุชุนููู ุนุฏุฏ ุงูุงุนุถุงุก (%d+)$") and SecondSudo(msg) then
local Num = text:match("ุชุนูู ุนุฏุฏ ุงูุงุนุถุงุก (%d+)$") or text:match("ุชุนููู ุนุฏุฏ ุงูุงุนุถุงุก (%d+)$")
DevRio:set(storm..'Rio:Num:Add:Bot',Num) 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ูุถุน ุนุฏุฏ ุงูุงุนุถุงุก โคฝ *'..Num..'* ุนุถู', 1, 'md')
end
--     Source Storm     --
if text == 'ุชูุนูู ุงูุจูุช ุงูุฎุฏูู' and ChCheck(msg) or text == 'โคฝ ุชูุนูู ุงูุจูุช ุงูุฎุฏูู โ' and ChCheck(msg) then 
if not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท', 1, 'md')
else 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุจูุช ุงูุฎุฏูู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Lock:FreeBot'..storm) 
end 
end
if text == 'ุชุนุทูู ุงูุจูุช ุงูุฎุฏูู' and ChCheck(msg) or text == 'โคฝ ุชุนุทูู ุงูุจูุช ุงูุฎุฏูู โ' and ChCheck(msg) then 
if not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท', 1, 'md')
else 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุจูุช ุงูุฎุฏูู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Lock:FreeBot'..storm,true) 
end 
end
if ChatType == 'sp' or ChatType == 'gp'  then
if text == 'ุชุนุทูู ุตูุฑุชู' and Manager(msg) and ChCheck(msg) then   
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุตูุฑุชู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Photo:Profile'..msg.chat_id_) 
end
if text == 'ุชูุนูู ุตูุฑุชู' and Manager(msg) and ChCheck(msg) then  
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุตูุฑุชู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Photo:Profile'..msg.chat_id_,true)  
end
if text == 'ุชูุนูู ุงูุงูุนุงุจ' and Manager(msg) and ChCheck(msg) or text == 'ุชูุนูู ุงููุนุจู' and Manager(msg) and ChCheck(msg) then   
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุงูุนุงุจ ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Lock:Games'..msg.chat_id_) 
end
if text == 'ุชุนุทูู ุงูุงูุนุงุจ' and Manager(msg) and ChCheck(msg) or text == 'ุชุนุทูู ุงููุนุจู' and Manager(msg) and ChCheck(msg) then  
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุงูุนุงุจ ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Lock:Games'..msg.chat_id_,true)  
end
if text == 'ุชูุนูู ุงูุงูุนุงุจ ุงููุชุทูุฑู' and Manager(msg) and ChCheck(msg) or text == 'ุชูุนูู ุงูุงูุนุงุจ ุงูุงุญุชุฑุงููู' and Manager(msg) and ChCheck(msg) then   
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงูุงูุนุงุจ ุงููุชุทูุฑู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm..'Rio:Lock:Gamesinline'..msg.chat_id_) 
end
if text == 'ุชุนุทูู ุงูุงูุนุงุจ ุงููุชุทูุฑู' and Manager(msg) and ChCheck(msg) or text == 'ุชุนุทูู ุงูุงูุนุงุจ ุงูุงุญุชุฑุงููู' and Manager(msg) and ChCheck(msg) then  
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงูุงูุนุงุจ ุงููุชุทูุฑู ุจูุฌุงุญ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm..'Rio:Lock:Gamesinline'..msg.chat_id_,true)  
end
if text == "ุชูุนูู ุงูุฑุงุจุท" and ChCheck(msg) or text == "ุชูุนูู ุฌูุจ ุงูุฑุงุจุท" and ChCheck(msg) then 
if Admin(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุฌูุจ ุฑุงุจุท ุงููุฌููุนู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm.."Rio:Lock:GpLinks"..msg.chat_id_)
return false  
end
end
if text == "ุชุนุทูู ุงูุฑุงุจุท" and ChCheck(msg) or text == "ุชุนุทูู ุฌูุจ ุงูุฑุงุจุท" and ChCheck(msg) then 
if Admin(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุฌูุจ ุฑุงุจุท ุงููุฌููุนู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm.."Rio:Lock:GpLinks"..msg.chat_id_,"ok")
return false  
end
end
if text == "ุชูุนูู ุญุฐู ุงูุฑุฏูุฏ" and ChCheck(msg) or text == "ุชูุนูู ูุณุญ ุงูุฑุฏูุฏ" and ChCheck(msg) then 
if RioConstructor(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุญุฐู ุฑุฏูุฏ ุงููุฏูุฑ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm.."Rio:Lock:Rd"..msg.chat_id_)
return false  
end
end
if text == "ุชุนุทูู ุงูุฑุงุจุท ุงููุงูู" and ChCheck(msg) or text == "ุชุนุทูู ุฌูุจ ุงูุฑุงุจุท ุงููุงูู" and ChCheck(msg) then 
if Admin(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุฌูุจ ุฑุงุจุท ุงููุงูู ุงููุฌููุนู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm.."Rio:Lock:GpLinksinline"..msg.chat_id_,"ok")
return false  
end
end
if text == "ุชูุนูู ุงูุฑุงุจุท ุงููุงูู" and ChCheck(msg) or text == "ุชูุนูู ุฌูุจ ุงูุฑุงุจุท ุงููุงูู" and ChCheck(msg) then 
if Admin(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุฌูุจ ุฑุงุจุท ุงููุงูู ุงููุฌููุนู'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm.."Rio:Lock:GpLinksinline"..msg.chat_id_)
return false  
end
end
if text == "ุชุนุทูู ุญุฐู ุงูุฑุฏูุฏ" and ChCheck(msg) or text == "ุชุนุทูู ูุณุญ ุงูุฑุฏูุฏ" and ChCheck(msg) then 
if RioConstructor(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุญุฐู ุฑุฏูุฏ ุงููุฏูุฑ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm.."Rio:Lock:Rd"..msg.chat_id_,true)
return false  
end
end
if text == "ุชูุนูู ุงุถู ุฑุฏ" and ChCheck(msg) or text == "ุชูุนูู ุงุถุงูู ุฑุฏ" and ChCheck(msg) then 
if RioConstructor(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชูุนูู ุงุถู ุฑุฏ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(storm.."Rio:Lock:Rd"..msg.chat_id_)
return false  
end
end
if text == "ุชุนุทูู ุงุถู ุฑุฏ" and ChCheck(msg) or text == "ุชุนุทูู ุงุถุงูู ุฑุฏ" and ChCheck(msg) then 
if RioConstructor(msg) then
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุชุนุทูู ุงุถู ุฑุฏ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(storm.."Rio:Lock:Rd"..msg.chat_id_,true)
return false  
end
end
--     Source Storm     --
if text and text:match('^ุชูุนูู$') and SudoBot(msg) and ChCheck(msg) then
if ChatType ~= 'sp' then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุฌููุนู ุนุงุฏูู ูููุณุช ุฎุงุฑูู ูุง ุชุณุชุทูุน ุชูุนููู ูุฑุฌู ุงู ุชุถุน ุณุฌู ุฑุณุงุฆู ุงููุฌููุนู ุถุงูุฑ ูููุณ ูุฎูู ููู ุจุนุฏูุง ููููู ุฑูุนู ุงุฏูู ุซู ุชูุนููู', 1, 'md')
return false
end
if msg.can_be_deleted_ == false then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงูุจูุช ููุณ ุงุฏูู ูุฑุฌู ุชุฑููุชู !', 1, 'md')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
if tonumber(data.member_count_) < tonumber(DevRio:get(storm..'Rio:Num:Add:Bot') or 0) and not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุนุฏุฏ ุงุนุถุงุก ุงููุฌููุนู ุงูู ูู โคฝ *'..(DevRio:get(storm..'Rio:Num:Add:Bot') or 0)..'* ุนุถู', 1, 'md')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,rio) 
local admins = rio.members_
for i=0 , #admins do
if rio.members_[i].bot_info_ == false and rio.members_[i].status_.ID == "ChatMemberStatusEditor" then
DevRio:sadd(storm..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
DevRio:srem(storm..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)
end
end,nil)
else
DevRio:sadd(storm..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)
end
if rio.members_[i].status_.ID == "ChatMemberStatusCreator" then
DevRio:sadd(storm.."Rio:BasicConstructor:"..msg.chat_id_,admins[i].user_id_)
DevRio:sadd(storm.."Rio:RioConstructor:"..msg.chat_id_,admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
DevRio:srem(storm.."Rio:BasicConstructor:"..msg.chat_id_,admins[i].user_id_)
DevRio:srem(storm.."Rio:RioConstructor:"..msg.chat_id_,admins[i].user_id_)
end
end,nil)  
end 
end
end,nil)
if DevRio:sismember(storm..'Rio:Groups',msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุฌููุนู ุจุงูุชุงููุฏ ููุนูู', 1, 'md')
else
ReplyStatus(msg,result.id_,"ReplyBy","โ๏ธุชู ุชูุนูู ุงููุฌููุนู "..dp.title_)  
DevRio:sadd(storm.."Rio:Groups",msg.chat_id_)
if not DevRio:get(storm..'Rio:SudosGp'..msg.sender_user_id_..msg.chat_id_) and not SecondSudo(msg) then 
DevRio:incrby(storm..'Rio:Sudos'..msg.sender_user_id_,1)
DevRio:set(storm..'Rio:SudosGp'..msg.sender_user_id_..msg.chat_id_,"rio")
end
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NumMem = data.member_count_
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
else
LinkGroup = 'ูุง ููุฌุฏ'
end
DevRio:set(storm.."Rio:Groups:Links"..msg.chat_id_,LinkGroup) 
if not Sudo(msg) then
SendText(DevId,"โ๏ธุชู ุชูุนูู ูุฌููุนู ุฌุฏูุฏู โคฝ โค \nโ โ โ โ โ โ โ โ โ\nโ๏ธุจูุงุณุทุฉ โคฝ "..Name.."\nโ๏ธุงุณู ุงููุฌููุนู โคฝ ["..NameChat.."]\nโ๏ธุนุฏุฏ ุงุนุถุงุก ุงููุฌููุนู โคฝ โจ *"..NumMem.."* โฉ\nโ๏ธุงูุฏู ุงููุฌููุนู โคฝ โค \nโจ `"..msg.chat_id_.."` โฉ\nโ๏ธุฑุงุจุท ุงููุฌููุนู โคฝ โค\nโจ ["..LinkGroup.."] โฉ\nโ โ โ โ โ โ โ โ โ\nโ๏ธุงูููุช โคฝ "..os.date("%I:%M%p").."\nโ๏ธุงูุชุงุฑูุฎ โคฝ "..os.date("%Y/%m/%d").."",0,'md')
end
end
end,nil)
end,nil)
end,nil)
end
if text == 'ุชุนุทูู' and SudoBot(msg) and ChCheck(msg) then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
if not DevRio:sismember(storm..'Rio:Groups',msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงููุฌููุนู ุจุงูุชุงููุฏ ูุนุทูู', 1, 'md')
else
ReplyStatus(msg,result.id_,"ReplyBy","โ๏ธุชู ุชุนุทูู ุงููุฌููุนู "..dp.title_)  
DevRio:srem(storm.."Rio:Groups",msg.chat_id_)
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
else
LinkGroup = 'ูุง ููุฌุฏ'
end
DevRio:set(storm.."Rio:Groups:Links"..msg.chat_id_,LinkGroup) 
if not Sudo(msg) then
SendText(DevId,"โ๏ธุชู ุชุนุทูู ูุฌููุนู ุฌุฏูุฏู โคฝ โค \nโ โ โ โ โ โ โ โ โ\nโ๏ธุจูุงุณุทุฉ โคฝ "..Name.."\nโ๏ธุงุณู ุงููุฌููุนู โคฝ ["..NameChat.."]\nโ๏ธุงูุฏู ุงููุฌููุนู โคฝ โค \nโจ `"..msg.chat_id_.."` โฉ\nโ๏ธุฑุงุจุท ุงููุฌููุนู โคฝ โค\nโจ ["..LinkGroup.."] โฉ\nโ โ โ โ โ โ โ โ โ\nโ๏ธุงูููุช โคฝ "..os.date("%I:%M%p").."\nโ๏ธุงูุชุงุฑูุฎ โคฝ "..os.date("%Y/%m/%d").."",0,'md')
end
end
end,nil)
end,nil)
end
end
--     Source Storm     --
if text and text:match("^ุงููุทูุฑ$") then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
LinkGroup = "โ๏ธุฑุงุจุท ุงููุฌููุนู โคฝ โค\nโจ ["..LinkGroup.."] โฉ"
else
LinkGroup = 'โ๏ธููุณุช ูุฏู ุตูุงุญูุฉ ุงูุฏุนูู ููุฐู ุงููุฌููุนู !'
end
if not Sudo(msg) then
SendText(DevId,"โ๏ธููุงู ูู ุจุญุงุฌู ุงูู ูุณุงุนุฏู โคฝ โค \nโ โ โ โ โ โ โ โ โ\nโ๏ธุงูุดุฎุต โคฝ "..Name.."\nโ๏ธุงุณู ุงููุฌููุนู โคฝ ["..NameChat.."]\nโ๏ธุงูุฏู ุงููุฌููุนู โคฝ โค \nโจ `"..msg.chat_id_.."` โฉ\n"..LinkGroup.."\nโ โ โ โ โ โ โ โ โ\nโ๏ธุงูููุช โคฝ "..os.date("%I:%M%p").."\nโ๏ธุงูุชุงุฑูุฎ โคฝ "..os.date("%Y/%m/%d").."",0,'md')
end
end,nil)
end,nil)
end
if text and text:match("^ุณุชูุฑู$") then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
LinkGroup = "โ๏ธุฑุงุจุท ุงููุฌููุนู โคฝ โค\nโจ ["..LinkGroup.."] โฉ"
else
LinkGroup = 'โ๏ธููุณุช ูุฏู ุตูุงุญูุฉ ุงูุฏุนูู ููุฐู ุงููุฌููุนู !'
end
if not Sudo(msg) then
SendText(DevId,"โ๏ธููุงู ูู ุจุญุงุฌู ุงูู ูุณุงุนุฏู โคฝ โค \nโ โ โ โ โ โ โ โ โ\nโ๏ธุงูุดุฎุต โคฝ "..Name.."\nโ๏ธุงุณู ุงููุฌููุนู โคฝ ["..NameChat.."]\nโ๏ธุงูุฏู ุงููุฌููุนู โคฝ โค \nโจ `"..msg.chat_id_.."` โฉ\n"..LinkGroup.."\nโ โ โ โ โ โ โ โ โ\nโ๏ธุงูููุช โคฝ "..os.date("%I:%M%p").."\nโ๏ธุงูุชุงุฑูุฎ โคฝ "..os.date("%Y/%m/%d").."",0,'md')
end
end,nil)
end,nil)
end
--     Source Storm     --
if text == 'ุฑูุงุจุท ุงูุฌุฑูุจุงุช' or text == 'ุฑูุงุจุท ุงููุฌููุนุงุช' or text == 'โคฝ ุฑูุงุจุท ุงููุฌููุนุงุช โ' then
if not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท ', 1, 'md')
else
local List = DevRio:smembers(storm.."Rio:Groups")
if #List == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุง ุชูุฌุฏ ูุฌููุนุงุช ููุนูู', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุฌุงุฑู ุงุฑุณุงู ูุณุฎู ุชุญุชูู ุนูู โคฝ '..#List..' ูุฌููุนู', 1, 'md')
local Text = "โ๏ธSource Storm\nโ๏ธFile Bot Groups\nโ โ โ โ โ โ โ โ โ\n"
for k,v in pairs(List) do
local GroupsManagers = DevRio:scard(storm.."Rio:Managers:"..v) or 0
local GroupsAdmins = DevRio:scard(storm.."Rio:Admins:"..v) or 0
local Groupslink = DevRio:get(storm.."Rio:Groups:Links" ..v)
Text = Text..k.." โฌ โค \nโ๏ธGroup ID โฌ "..v.."\nโ๏ธGroup Link โฌ "..(Groupslink or "Not Found").."\nโ๏ธGroup Managers โฌ "..GroupsManagers.."\nโ๏ธGroup Admins โฌ "..GroupsAdmins.."\nโ โ โ โ โ โ โ โ โ\n"
end
local File = io.open('GroupsBot.txt', 'w')
File:write(Text)
File:close()
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './GroupsBot.txt',dl_cb, nil)
io.popen('rm -rf ./GroupsBot.txt')
end
end
end
--     Source Storm     --
if text == "ุงุฐุงุนู ุฎุงุต" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "โคฝ ุงุฐุงุนู ุฎุงุต โ" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevRio:get(storm.."Rio:Send:Bot"..storm) and not SecondSudo(msg) then 
send(msg.chat_id_, msg.id_,"โ๏ธุงูุงุฐุงุนู ูุนุทูู ูู ูุจู ุงููุทูุฑ ุงูุงุณุงุณู")
return false
end
DevRio:setex(storm.."Rio:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุงุฑุณู ูู ุณูุงุก โคฝ โค \nโจ ููู โข ููุตู โข ูุชุญุฑูู โข ุตูุฑู\n โข ููุฏูู โข ุจุตูู โข ุตูุช โข ุฑุณุงูู โฉ\nโ๏ธููุฎุฑูุฌ ุงุฑุณู โคฝ ( ุงูุบุงุก ) \n โ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
return false
end 
if DevRio:get(storm.."Rio:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == 'ุงูุบุงุก' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุงูุฑ ุงูุงุฐุงุนู ุจูุฌุงุญ", 1, 'md')
DevRio:del(storm.."Rio:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false
end 
List = DevRio:smembers(storm..'Rio:Users') 
if msg.content_.text_ then
for k,v in pairs(List) do 
RioText = "ุงูุฑุณุงูู"
send(v, 0,"["..msg.content_.text_.."]") 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(List) do 
RioText = "ุงูุตูุฑู"
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(List) do 
RioText = "ุงููุชุญุฑูู"
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.video_ then
for k,v in pairs(List) do 
RioText = "ุงูููุฏูู"
sendVideo(v, 0, 0, 1, nil, msg.content_.video_.video_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.voice_ then
for k,v in pairs(List) do 
RioText = "ุงูุจุตูู"
sendVoice(v, 0, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.audio_ then
for k,v in pairs(List) do 
RioText = "ุงูุตูุช"
sendAudio(v, 0, 0, 1, nil, msg.content_.audio_.audio_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.document_ then
for k,v in pairs(List) do 
RioText = "ุงูููู"
sendDocument(v, 0, 0, 1,nil, msg.content_.document_.document_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(List) do 
RioText = "ุงูููุตู"
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงุฐุงุนุฉ "..RioText.." ุจูุฌุงุญ \nโ๏ธโุงูู โคฝ โจ "..#List.." โฉ ูุดุชุฑู \n โ", 1, 'md')
DevRio:del(storm.."Rio:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_) 
end
--     Source Storm     --
if text == "ุงุฐุงุนู" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "โคฝ ุงุฐุงุนู ุนุงู โ" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevRio:get(storm.."Rio:Send:Bot"..storm) and not SecondSudo(msg) then 
send(msg.chat_id_, msg.id_,"โ๏ธุงูุงุฐุงุนู ูุนุทูู ูู ูุจู ุงููุทูุฑ ุงูุงุณุงุณู")
return false
end
DevRio:setex(storm.."Rio:Send:Gp"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุงุฑุณู ูู ุณูุงุก โคฝ โค \nโจ ููู โข ููุตู โข ูุชุญุฑูู โข ุตูุฑู\n โข ููุฏูู โข ุจุตูู โข ุตูุช โข ุฑุณุงูู โฉ\nโ๏ธููุฎุฑูุฌ ุงุฑุณู โคฝ ( ุงูุบุงุก ) \n โ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
return false
end 
if DevRio:get(storm.."Rio:Send:Gp"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == 'ุงูุบุงุก' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุงูุฑ ุงูุงุฐุงุนู ุจูุฌุงุญ", 1, 'md')
DevRio:del(storm.."Rio:Send:Gp"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false
end 
List = DevRio:smembers(storm..'Rio:Groups') 
if msg.content_.text_ then
for k,v in pairs(List) do 
RioText = "ุงูุฑุณุงูู"
send(v, 0,"["..msg.content_.text_.."]") 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(List) do 
RioText = "ุงูุตูุฑู"
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(List) do 
RioText = "ุงููุชุญุฑูู"
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.video_ then
for k,v in pairs(List) do 
RioText = "ุงูููุฏูู"
sendVideo(v, 0, 0, 1, nil, msg.content_.video_.video_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.voice_ then
for k,v in pairs(List) do 
RioText = "ุงูุจุตูู"
sendVoice(v, 0, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.audio_ then
for k,v in pairs(List) do 
RioText = "ุงูุตูุช"
sendAudio(v, 0, 0, 1, nil, msg.content_.audio_.audio_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.document_ then
for k,v in pairs(List) do 
RioText = "ุงูููู"
sendDocument(v, 0, 0, 1,nil, msg.content_.document_.document_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(List) do 
RioText = "ุงูููุตู"
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงุฐุงุนุฉ "..RioText.." ุจูุฌุงุญ \nโ๏ธโูู โคฝ โจ "..#List.." โฉ ูุฌููุนู \n โ", 1, 'md')
DevRio:del(storm.."Rio:Send:Gp"..msg.chat_id_..":" .. msg.sender_user_id_) 
end
--     Source Storm     --
if text == "ุงุฐุงุนู ุจุงูุชูุฌูู" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "โคฝ ุงุฐุงุนู ุนุงู ุจุงูุชูุฌูู โ" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevRio:get(storm.."Rio:Send:Bot"..storm) and not SecondSudo(msg) then 
send(msg.chat_id_, msg.id_,"โ๏ธุงูุงุฐุงุนู ูุนุทูู ูู ูุจู ุงููุทูุฑ ุงูุงุณุงุณู")
return false
end
DevRio:setex(storm.."Rio:Send:FwdGp"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุงุฑุณู ุงูุฑุณุงูู ุงูุงู ูุชูุฌููุง \nโ๏ธููุฎุฑูุฌ ุงุฑุณู โคฝ ( ุงูุบุงุก ) \n โ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
return false
end 
if DevRio:get(storm.."Rio:Send:FwdGp"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == 'ุงูุบุงุก' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุงูุฑ ุงูุงุฐุงุนู ุจูุฌุงุญ", 1, 'md')
DevRio:del(storm.."Rio:Send:FwdGp"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false  
end 
local List = DevRio:smembers(storm..'Rio:Groups')   
for k,v in pairs(List) do  
tdcli_function({ID="ForwardMessages", chat_id_ = v, from_chat_id_ = msg.chat_id_, message_ids_ = {[0] = msg.id_}, disable_notification_ = 0, from_background_ = 1},function(a,t) end,nil) 
end   
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงุฐุงุนุฉ ุฑุณุงูุชู ุจุงูุชูุฌูู \nโ๏ธโูู โคฝ โจ "..#List.." โฉ ูุฌููุนู \n โ", 1, 'md')
DevRio:del(storm.."Rio:Send:FwdGp"..msg.chat_id_..":" .. msg.sender_user_id_) 
end
--     Source Storm     --
if text == "ุงุฐุงุนู ุฎุงุต ุจุงูุชูุฌูู" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "โคฝ ุงุฐุงุนู ุฎุงุต ุจุงูุชูุฌูู โ" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevRio:get(storm.."Rio:Send:Bot"..storm) and not SecondSudo(msg) then 
send(msg.chat_id_, msg.id_,"โ๏ธุงูุงุฐุงุนู ูุนุทูู ูู ูุจู ุงููุทูุฑ ุงูุงุณุงุณู")
return false
end
DevRio:setex(storm.."Rio:Send:FwdPv"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุงุฑุณู ุงูุฑุณุงูู ุงูุงู ูุชูุฌููุง \nโ๏ธููุฎุฑูุฌ ุงุฑุณู โคฝ ( ุงูุบุงุก ) \n โ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
return false
end 
if DevRio:get(storm.."Rio:Send:FwdPv"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == 'ุงูุบุงุก' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุงูุฑ ุงูุงุฐุงุนู ุจูุฌุงุญ", 1, 'md')
DevRio:del(storm.."Rio:Send:FwdPv"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false  
end 
local List = DevRio:smembers(storm..'Rio:Users')   
for k,v in pairs(List) do  
tdcli_function({ID="ForwardMessages", chat_id_ = v, from_chat_id_ = msg.chat_id_, message_ids_ = {[0] = msg.id_}, disable_notification_ = 0, from_background_ = 1},function(a,t) end,nil) 
end   
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงุฐุงุนุฉ ุฑุณุงูุชู ุจุงูุชูุฌูู \nโ๏ธโุงูู โคฝ โจ "..#List.." โฉ ูุดุชุฑู \n โ", 1, 'md')
DevRio:del(storm.."Rio:Send:FwdPv"..msg.chat_id_..":" .. msg.sender_user_id_) 
end
--     Source Storm     --
if text == "ุงุฐุงุนู ุจุงูุชุซุจูุช" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "โคฝ ุงุฐุงุนู ุจุงูุชุซุจูุช โ" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevRio:get(storm.."Rio:Send:Bot"..storm) and not SecondSudo(msg) then 
send(msg.chat_id_, msg.id_,"โ๏ธุงูุงุฐุงุนู ูุนุทูู ูู ูุจู ุงููุทูุฑ ุงูุงุณุงุณู")
return false
end
DevRio:setex(storm.."Rio:Send:Gp:Pin"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุงุฑุณู ูู ุณูุงุก โคฝ โค \nโจ ููู โข ููุตู โข ูุชุญุฑูู โข ุตูุฑู\n โข ููุฏูู โข ุจุตูู โข ุตูุช โข ุฑุณุงูู โฉ\nโ๏ธููุฎุฑูุฌ ุงุฑุณู โคฝ ( ุงูุบุงุก ) \n โ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
return false
end 
if DevRio:get(storm.."Rio:Send:Gp:Pin"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == "ุงูุบุงุก" then   
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุงูุฑ ุงูุงุฐุงุนู ุจูุฌุงุญ", 1, 'md')
DevRio:del(storm.."Rio:Send:Gp:Pin"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false
end 
local List = DevRio:smembers(storm.."Rio:Groups") 
if msg.content_.text_ then
for k,v in pairs(List) do 
RioText = "ุงูุฑุณุงูู"
send(v, 0,"["..msg.content_.text_.."]") 
DevRio:set(storm..'Rio:PinnedMsgs'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(List) do 
RioText = "ุงูุตูุฑู"
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
DevRio:set(storm..'Rio:PinnedMsgs'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(List) do 
RioText = "ุงููุชุญุฑูู"
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
DevRio:set(storm..'Rio:PinnedMsgs'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.video_ then
for k,v in pairs(List) do 
RioText = "ุงูููุฏูู"
sendVideo(v, 0, 0, 1, nil, msg.content_.video_.video_.persistent_id_,(msg.content_.caption_ or '')) 
DevRio:set(storm..'Rio:PinnedMsgs'..v,msg.content_.video_.video_.persistent_id_)
end 
elseif msg.content_.voice_ then
for k,v in pairs(List) do 
RioText = "ุงูุจุตูู"
sendVoice(v, 0, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_,(msg.content_.caption_ or '')) 
DevRio:set(storm..'Rio:PinnedMsgs'..v,msg.content_.voice_.voice_.persistent_id_)
end 
elseif msg.content_.audio_ then
for k,v in pairs(List) do 
RioText = "ุงูุตูุช"
sendAudio(v, 0, 0, 1, nil, msg.content_.audio_.audio_.persistent_id_,(msg.content_.caption_ or '')) 
DevRio:set(storm..'Rio:PinnedMsgs'..v,msg.content_.audio_.audio_.persistent_id_)
end 
elseif msg.content_.document_ then
for k,v in pairs(List) do 
RioText = "ุงูููู"
sendDocument(v, 0, 0, 1,nil, msg.content_.document_.document_.persistent_id_,(msg.content_.caption_ or ''))    
DevRio:set(storm..'Rio:PinnedMsgs'..v,msg.content_.document_.document_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(List) do 
RioText = "ุงูููุตู"
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
DevRio:set(storm..'Rio:PinnedMsgs'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงุฐุงุนุฉ "..RioText.." ุจุงูุชุซุจูุช \nโ๏ธโูู โคฝ โจ "..#List.." โฉ ูุฌููุนู \n โ", 1, 'md')
DevRio:del(storm.."Rio:Send:Gp:Pin"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false
end
--     Source Storm     --
if text == 'ุญุฐู ุฑุฏ ูู ูุชุนุฏุฏ' and Manager(msg) and ChCheck(msg) or text == 'ูุณุญ ุฑุฏ ูู ูุชุนุฏุฏ' and Manager(msg) and ChCheck(msg) then
local List = DevRio:smembers(storm..'Rio:Manager:GpRedod'..msg.chat_id_)
if #List == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุง ุชูุฌุฏ ุฑุฏูุฏ ูุชุนุฏุฏู ูุถุงูู" ,  1, "md")
return false
end
DevRio:set(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'DelGpRedRedod')
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุญุณูุง ุงุฑุณู ูููุฉ ุงูุฑุฏ ุงููุง" ,  1, "md")
return false
end
if text and text:match("^(.*)$") then
local DelGpRedRedod = DevRio:get(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
if DelGpRedRedod == 'DelGpRedRedod' then
if text == "ุงูุบุงุก" then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุงูุงูุฑ" ,  1, "md")
DevRio:del(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
return false
end
if not DevRio:sismember(storm..'Rio:Manager:GpRedod'..msg.chat_id_,text) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุงููุฌุฏ ุฑุฏ ูุชุนุฏุฏ ููุฐู ุงููููู โคฝ "..text ,  1, "md")
return false
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูู ุจุงุฑุณุงู ุงูุฑุฏ ุงููุชุนุฏุฏ ุงูุฐู ุชุฑูุฏ ุญุฐูู ูู ุงููููู โคฝ "..text ,  1, "md")
DevRio:set(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'DelGpRedRedods')
DevRio:set(storm..'Rio:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_,text)
return false
end end
if text == 'ุญุฐู ุฑุฏ ูุชุนุฏุฏ' and Manager(msg) and ChCheck(msg) or text == 'ูุณุญ ุฑุฏ ูุชุนุฏุฏ' and Manager(msg) and ChCheck(msg) then
local List = DevRio:smembers(storm..'Rio:Manager:GpRedod'..msg.chat_id_)
if #List == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุง ุชูุฌุฏ ุฑุฏูุฏ ูุชุนุฏุฏู ูุถุงูู" ,  1, "md")
return false
end
DevRio:set(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'DelGpRedod')
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุญุณูุง ุงุฑุณู ุงููููู ูุญุฐููุง" ,  1, "md")
return false
end
if text == 'ุงุถู ุฑุฏ ูุชุนุฏุฏ' and Manager(msg) and ChCheck(msg) then
DevRio:set(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'SetGpRedod')
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุญุณูุง ุงุฑุณู ุงููููู ุงูุงู" ,  1, "md")
return false
end
if text and text:match("^(.*)$") then
local SetGpRedod = DevRio:get(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
if SetGpRedod == 'SetGpRedod' then
if text == "ุงูุบุงุก" then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุงูุงูุฑ" ,  1, "md")
DevRio:del(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
return false
end
if DevRio:sismember(storm..'Rio:Manager:GpRedod'..msg.chat_id_,text) then
local Rio = "โ๏ธูุงุชุณุชุทูุน ุงุถุงูุฉ ุฑุฏ ุจุงูุชุงููุฏ ูุถุงู ูู ุงููุงุฆูู ูู ุจุญุฐูู ุงููุง !"
keyboard = {} 
keyboard.inline_keyboard = {{{text="ุญุฐู ุงูุฑุฏ โคฝ "..text,callback_data="/DelRed:"..msg.sender_user_id_..text}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Rio).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevRio:del(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
return false
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ุงูุงูุฑ ุงุฑุณู ุงูุฑุฏ ุงูุงูู\nโ๏ธููุฎุฑูุฌ ุงุฑุณู โคฝ ( ุงูุบุงุก )" ,  1, "md")
DevRio:set(storm..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'SaveGpRedod')
DevRio:set(storm..'Rio:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_,text)
DevRio:sadd(storm..'Rio:Manager:GpRedod'..msg.chat_id_,text)
return false
end end
--     Source Storm     --
if text == 'ุญุฐู ุฑุฏ' and Manager(msg) and ChCheck(msg) or text == 'ูุณุญ ุฑุฏ' and  Manager(msg) and ChCheck(msg) then
local List = DevRio:smembers(storm..'Rio:Manager:GpRed'..msg.chat_id_)
if #List == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุง ุชูุฌุฏ ุฑุฏูุฏ ูุถุงูู" ,  1, "md")
return false
end
DevRio:set(storm..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_,'DelGpRed')
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุญุณูุง ุงุฑุณู ุงููููู ูุญุฐููุง " ,  1, "md")
return false
end
if text == 'ุงุถู ุฑุฏ' and not DevRio:get(storm..'Rio:Lock:Rd'..msg.chat_id_) and Manager(msg) and ChCheck(msg) then
DevRio:set(storm..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_,'SetGpRed')
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุญุณูุง ุงุฑุณู ุงููููู ุงูุงู " ,  1, "md")
return false
end
if text and text:match("^(.*)$") then
local SetGpRed = DevRio:get(storm..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
if SetGpRed == 'SetGpRed' then
if text == "ุงูุบุงุก" then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุงูุงูุฑ" ,  1, "md")
DevRio:del(storm..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
return false
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูู ุงูุฑุฏ ุณูุงุก ูุงู โคฝ โค\nโจ ููู โข ููุตู โข ูุชุญุฑูู โข ุตูุฑู\n โข ููุฏูู โข ุจุตูู โข ุตูุช โข ุฑุณุงูู โฉ\nโ๏ธููููู ุงุถุงูุฉ ุงูู ุงููุต โคฝ โค\nโ โ โ โ โ โ โ โ โ\n `#username` โฌ ูุนุฑู ุงููุณุชุฎุฏู\n `#msgs` โฌ ุนุฏุฏ ุงูุฑุณุงุฆู\n `#name` โฌ ุงุณู ุงููุณุชุฎุฏู\n `#id` โฌ ุงูุฏู ุงููุณุชุฎุฏู\n `#stast` โฌ ุฑุชุจุฉ ุงููุณุชุฎุฏู\n `#edit` โฌ ุนุฏุฏ ุงูุณุญูุงุช\nโ โ โ โ โ โ โ โ โ\nโ๏ธููุฎุฑูุฌ ุงุฑุณู โคฝ ( ุงูุบุงุก )\n โ" ,  1, "md")
DevRio:set(storm..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_,'SaveGpRed')
DevRio:set(storm..'Rio:Add:GpText'..msg.sender_user_id_..msg.chat_id_,text)
DevRio:sadd(storm..'Rio:Manager:GpRed'..msg.chat_id_,text)
DevRio:set(storm..'DelManagerRep'..msg.chat_id_,text)
return false
end end
--     Source Storm     --
if text == 'ุญุฐู ุฑุฏ ุนุงู' and SecondSudo(msg) and ChCheck(msg) or text == 'โคฝ ุญุฐู ุฑุฏ ุนุงู โ' and SecondSudo(msg) and ChCheck(msg) or text == 'ูุณุญ ุฑุฏ ุนุงู' and SecondSudo(msg) and ChCheck(msg) or text == 'ุญุฐู ุฑุฏ ูููู' and SecondSudo(msg) and ChCheck(msg) or text == 'ูุณุญ ุฑุฏ ูููู' and SecondSudo(msg) and ChCheck(msg) or text == 'ูุณุญ ุฑุฏ ูุทูุฑ' and SecondSudo(msg) and ChCheck(msg) or text == 'ุญุฐู ุฑุฏ ูุทูุฑ' and SecondSudo(msg) and ChCheck(msg) then
local List = DevRio:smembers(storm.."Rio:Sudo:AllRed")
if #List == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุง ุชูุฌุฏ ุฑุฏูุฏ ูุถุงูู" ,  1, "md")
return false
end
DevRio:set(storm.."Rio:Add:AllRed"..msg.sender_user_id_,'DelAllRed')
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุญุณูุง ุงุฑุณู ุงููููู ูุญุฐููุง " ,  1, "md")
return false
end
if text == 'ุงุถู ุฑุฏ ุนุงู' and SecondSudo(msg) and ChCheck(msg) or text == 'โคฝ ุงุถู ุฑุฏ ุนุงู โ' and SecondSudo(msg) and ChCheck(msg) or text == 'ุงุถู ุฑุฏ ูููู' and SecondSudo(msg) and ChCheck(msg) or text == 'ุงุถู ุฑุฏ ูุทูุฑ' and SecondSudo(msg) and ChCheck(msg) then
DevRio:set(storm.."Rio:Add:AllRed"..msg.sender_user_id_,'SetAllRed')
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุญุณูุง ุงุฑุณู ุงููููู ุงูุงู " ,  1, "md")
return false
end
if text and text:match("^(.*)$") then
local SetAllRed = DevRio:get(storm.."Rio:Add:AllRed"..msg.sender_user_id_)
if SetAllRed == 'SetAllRed' then
if text == "ุงูุบุงุก" then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุงูุงูุฑ" ,  1, "md")
DevRio:del(storm..'Rio:Add:AllRed'..msg.sender_user_id_)
return false
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูู ุงูุฑุฏ ุณูุงุก ูุงู โคฝ โค\nโจ ููู โข ููุตู โข ูุชุญุฑูู โข ุตูุฑู\n โข ููุฏูู โข ุจุตูู โข ุตูุช โข ุฑุณุงูู โฉ\nโ๏ธููููู ุงุถุงูุฉ ุงูู ุงููุต โคฝ โค\nโ โ โ โ โ โ โ โ โ\n `#username` โฌ ูุนุฑู ุงููุณุชุฎุฏู\n `#msgs` โฌ ุนุฏุฏ ุงูุฑุณุงุฆู\n `#name` โฌ ุงุณู ุงููุณุชุฎุฏู\n `#id` โฌ ุงูุฏู ุงููุณุชุฎุฏู\n `#stast` โฌ ุฑุชุจุฉ ุงููุณุชุฎุฏู\n `#edit` โฌ ุนุฏุฏ ุงูุณุญูุงุช\nโ โ โ โ โ โ โ โ โ\nโ๏ธููุฎุฑูุฌ ุงุฑุณู โคฝ ( ุงูุบุงุก )\n โ" ,  1, "md")
DevRio:set(storm.."Rio:Add:AllRed"..msg.sender_user_id_,'SaveAllRed')
DevRio:set(storm.."Rio:Add:AllText"..msg.sender_user_id_, text)
DevRio:sadd(storm.."Rio:Sudo:AllRed",text)
DevRio:set(storm.."DelSudoRep",text)
return false 
end end
--     Source Storm     --
if text == 'ุงูุฑุฏูุฏ ุงููุชุนุฏุฏู' and Manager(msg) and ChCheck(msg) then
local redod = DevRio:smembers(storm..'Rio:Manager:GpRedod'..msg.chat_id_)
MsgRep = 'โ๏ธูุงุฆูุฉ ุงูุฑุฏูุฏ ุงููุชุนุฏุฏู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n'
for k,v in pairs(redod) do
MsgRep = MsgRep..k..'~ (`'..v..'`) โข {*ุงูุนุฏุฏ โคฝ '..#DevRio:smembers(storm..'Rio:Text:GpTexts'..v..msg.chat_id_)..'*}\n' 
end
if #redod == 0 then
MsgRep = 'โ๏ธูุง ุชูุฌุฏ ุฑุฏูุฏ ูุชุนุฏุฏู ูุถุงูู'
end
send(msg.chat_id_,msg.id_,MsgRep)
end
if text == 'ุญุฐู ุงูุฑุฏูุฏ ุงููุชุนุฏุฏู' and Manager(msg) and ChCheck(msg) or text == 'ูุณุญ ุงูุฑุฏูุฏ ุงููุชุนุฏุฏู' and Manager(msg) and ChCheck(msg) then
local redod = DevRio:smembers(storm..'Rio:Manager:GpRedod'..msg.chat_id_)
if #redod == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุง ุชูุฌุฏ ุฑุฏูุฏ ูุชุนุฏุฏู ูุถุงูู" ,  1, "md")
else
for k,v in pairs(redod) do
DevRio:del(storm..'Rio:Text:GpTexts'..v..msg.chat_id_)
DevRio:del(storm..'Rio:Manager:GpRedod'..msg.chat_id_)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุงูุฑุฏูุฏ ุงููุชุนุฏุฏู")  
return false
end
end
--     Source Storm     --
if text == 'ุงูุฑุฏูุฏ' and Manager(msg) and ChCheck(msg) or text == 'ุฑุฏูุฏ ุงููุฏูุฑ' and Manager(msg) and ChCheck(msg) then
local redod = DevRio:smembers(storm..'Rio:Manager:GpRed'..msg.chat_id_)
MsgRep = 'โ๏ธุฑุฏูุฏ ุงููุฏูุฑ โคฝ โค \nโ โ โ โ โ โ โ โ โ\n'
for k,v in pairs(redod) do
if DevRio:get(storm.."Rio:Gif:GpRed"..v..msg.chat_id_) then
dp = 'ูุชุญุฑูู ๐ญ'
elseif DevRio:get(storm.."Rio:Voice:GpRed"..v..msg.chat_id_) then
dp = 'ุจุตูู ๐'
elseif DevRio:get(storm.."Rio:Stecker:GpRed"..v..msg.chat_id_) then
dp = 'ููุตู ๐'
elseif DevRio:get(storm.."Rio:Text:GpRed"..v..msg.chat_id_) then
dp = 'ุฑุณุงูู โ'
elseif DevRio:get(storm.."Rio:Photo:GpRed"..v..msg.chat_id_) then
dp = 'ุตูุฑู ๐'
elseif DevRio:get(storm.."Rio:Video:GpRed"..v..msg.chat_id_) then
dp = 'ููุฏูู ๐ฝ'
elseif DevRio:get(storm.."Rio:File:GpRed"..v..msg.chat_id_) then
dp = 'ููู ๐'
elseif DevRio:get(storm.."Rio:Audio:GpRed"..v..msg.chat_id_) then
dp = 'ุงุบููู ๐ถ'
end
MsgRep = MsgRep..k..'~ (`'..v..'`) โคฝ {*'..dp..'*}\n' 
end
if #redod == 0 then
MsgRep = 'โ๏ธูุง ุชูุฌุฏ ุฑุฏูุฏ ูุถุงูู'
end
send(msg.chat_id_,msg.id_,MsgRep)
end
if Manager(msg) then
if text and (text =='ุญุฐู ุงูุฑุฏูุฏ' or text == 'ูุณุญ ุงูุฑุฏูุฏ' or text == 'ุญุฐู ุฑุฏูุฏ ุงููุฏูุฑ' or text == 'ูุณุญ ุฑุฏูุฏ ุงููุฏูุฑ') and not DevRio:get(storm..'Rio:Lock:Rd'..msg.chat_id_) and ChCheck(msg) then
local redod = DevRio:smembers(storm..'Rio:Manager:GpRed'..msg.chat_id_)
if #redod == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุง ุชูุฌุฏ ุฑุฏูุฏ ูุถุงูู" ,  1, "md")
else
for k,v in pairs(redod) do
DevRio:del(storm..'Rio:Gif:GpRed'..v..msg.chat_id_)
DevRio:del(storm..'Rio:Voice:GpRed'..v..msg.chat_id_)
DevRio:del(storm..'Rio:Audio:GpRed'..v..msg.chat_id_)
DevRio:del(storm..'Rio:Photo:GpRed'..v..msg.chat_id_)
DevRio:del(storm..'Rio:Stecker:GpRed'..v..msg.chat_id_)
DevRio:del(storm..'Rio:Video:GpRed'..v..msg.chat_id_)
DevRio:del(storm..'Rio:File:GpRed'..v..msg.chat_id_)
DevRio:del(storm..'Rio:Text:GpRed'..v..msg.chat_id_)
DevRio:del(storm..'Rio:Manager:GpRed'..msg.chat_id_)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุฑุฏูุฏ ุงููุฏูุฑ")  
return false
end
end
end
--     Source Storm     --
if  text == "ุฑุฏูุฏ ุงููุทูุฑ" and SecondSudo(msg) and ChCheck(msg) or text == "ุงูุฑุฏูุฏ ุงูุนุงู" and SecondSudo(msg) and ChCheck(msg) or text == "โคฝ ุฑุฏูุฏ ุงูุนุงู โ" and SecondSudo(msg) and ChCheck(msg) or text == "ุฑุฏูุฏ ุงูุนุงู" and SecondSudo(msg) and ChCheck(msg) then
local redod = DevRio:smembers(storm.."Rio:Sudo:AllRed")
MsgRep = 'โ๏ธุฑุฏูุฏ ุงููุทูุฑ โคฝ โค \nโ โ โ โ โ โ โ โ โ\n'
for k,v in pairs(redod) do
if DevRio:get(storm.."Rio:Gif:AllRed"..v) then
dp = 'ูุชุญุฑูู ๐ญ'
elseif DevRio:get(storm.."Rio:Voice:AllRed"..v) then
dp = 'ุจุตูู ๐'
elseif DevRio:get(storm.."Rio:Stecker:AllRed"..v) then
dp = 'ููุตู ๐'
elseif DevRio:get(storm.."Rio:Text:AllRed"..v) then
dp = 'ุฑุณุงูู โ'
elseif DevRio:get(storm.."Rio:Photo:AllRed"..v) then
dp = 'ุตูุฑู ๐'
elseif DevRio:get(storm.."Rio:Video:AllRed"..v) then
dp = 'ููุฏูู ๐ฝ'
elseif DevRio:get(storm.."Rio:File:AllRed"..v) then
dp = 'ููู ๐'
elseif DevRio:get(storm.."Rio:Audio:AllRed"..v) then
dp = 'ุงุบููู ๐ถ'
end
MsgRep = MsgRep..k..'~ (`'..v..'`) โคฝ {*'..dp..'*}\n' 
end
if #redod == 0 then
MsgRep = 'โ๏ธูุง ุชูุฌุฏ ุฑุฏูุฏ ูุถุงูู'
end
send(msg.chat_id_,msg.id_,MsgRep)
end
if text == "ุญุฐู ุฑุฏูุฏ ุงููุทูุฑ" and SecondSudo(msg) and ChCheck(msg) or text == "ุญุฐู ุฑุฏูุฏ ุงูุนุงู" and SecondSudo(msg) and ChCheck(msg) or text == "ูุณุญ ุฑุฏูุฏ ุงููุทูุฑ" and SecondSudo(msg) and ChCheck(msg) or text == "โคฝ ูุณุญ ุฑุฏูุฏ ุงูุนุงู โ" and SecondSudo(msg) and ChCheck(msg) then
local redod = DevRio:smembers(storm.."Rio:Sudo:AllRed")
if #redod == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธูุง ุชูุฌุฏ ุฑุฏูุฏ ูุถุงูู" ,  1, "md")
else
for k,v in pairs(redod) do
DevRio:del(storm.."Rio:Add:AllRed"..v)
DevRio:del(storm.."Rio:Gif:AllRed"..v)
DevRio:del(storm.."Rio:Voice:AllRed"..v)
DevRio:del(storm.."Rio:Audio:AllRed"..v)
DevRio:del(storm.."Rio:Photo:AllRed"..v)
DevRio:del(storm.."Rio:Stecker:AllRed"..v)
DevRio:del(storm.."Rio:Video:AllRed"..v)
DevRio:del(storm.."Rio:File:AllRed"..v)
DevRio:del(storm.."Rio:Text:AllRed"..v)
DevRio:del(storm.."Rio:Sudo:AllRed")
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","โ๏ธุชู ุญุฐู ุฑุฏูุฏ ุงููุทูุฑ")  
return false
end
end 
--     Source Storm     --
if text and text == "ุชุบููุฑ ุงุณู ุงูุจูุช" and ChCheck(msg) or text and text == "ูุถุน ุงุณู ุงูุจูุช" and ChCheck(msg) or text and text == "ุชุบูุฑ ุงุณู ุงูุจูุช" and ChCheck(msg) then
if not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท ', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูู ุงุณู ุงูุจูุช ุงูุงู" ,  1, "md") 
DevRio:set(storm..'Rio:NameBot'..msg.sender_user_id_, 'msg')
return false 
end
end
if text and text == 'ุญุฐู ุงุณู ุงูุจูุช' and ChCheck(msg) or text == 'ูุณุญ ุงุณู ุงูุจูุช' and ChCheck(msg) then
if not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท ', 1, 'md')
else
DevRio:del(storm..'Rio:NameBot')
local stormTeam = 'โ๏ธุงููุง ุนุฒูุฒู โคฝ '..RioRank(msg)..' \nโ๏ธุชู ุญุฐู ุงุณู ุงูุจูุช'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, stormTeam, 14, string.len(msg.sender_user_id_))
end end 
--     Source Storm     --
if text and text:match("^ุงุณุชุนุงุฏู ุงูุงูุงูุฑ$") and SecondSudo(msg) and ChCheck(msg) or text and text:match("^ุงุณุชุนุงุฏุฉ ููุงูุด ุงูุงูุงูุฑ$") and SecondSudo(msg) and ChCheck(msg) then
HelpList ={'Rio:Help','Rio:Help1','Rio:Help2','Rio:Help3','Rio:Help4','Rio:Help5','Rio:Help6'}
for i,Help in pairs(HelpList) do
DevRio:del(storm..Help) 
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงุณุชุนุงุฏุฉ ุงูููุงูุด ุงูุงุตููู" ,  1, "md") 
end
if text == "ุชุนููู ุงูุงูุงูุฑ" and SecondSudo(msg) and ChCheck(msg) or text == "ุชุนููู ุงูุฑ ุงูุงูุงูุฑ" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูููุดุฉ (ุงูุงูุงูุฑ) ุงูุงู " ,  1, "md")
DevRio:set(storm..'Rio:Help0'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local stormTeam =  DevRio:get(storm..'Rio:Help0'..msg.sender_user_id_)
if stormTeam == 'msg' then
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(storm..'Rio:Help0'..msg.sender_user_id_)
DevRio:set(storm..'Rio:Help', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ุงููููุดู ุงูุฌุฏูุฏู " ,  1, "md")
return false end
end
if text == "ุงูุงูุงูุฑ" and ChCheck(msg) or text == "ุงูุงูุฑ" and ChCheck(msg) or text == "ูุณุงุนุฏู" and ChCheck(msg) then
local Help = DevRio:get(storm..'Rio:Help')
local Text = [[
โโฏโ๏ธุงููุง ุจู ูู ูุงุฆูุฉ ุงูุงูุงูุฑ โคฝ โค 
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธู1 โคฝ ุงูุงูุฑ ุงูุญูุงูู
โโฏโ๏ธู2 โคฝ ุงูุงูุฑ ุงูุงุฏูููู
โโฏโ๏ธู3 โคฝ ุงูุงูุฑ ุงููุฏุฑุงุก
โโฏโ๏ธู4 โคฝ ุงูุงูุฑ ุงูููุดุฆูู
โโฏโ๏ธู5 โคฝ ุงูุงูุฑ ุงููุทูุฑูู
โโฏโ๏ธู6 โคฝ ุงูุงูุฑ ุงูุงุนุถุงุก
โ โ โ โ โโโโ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]] 
keyboard = {} 
keyboard.inline_keyboard = {{{text="ุงูุงูุฑ ุงูุงุฏูููู",callback_data="/HelpList2:"..msg.sender_user_id_},{text="ุงูุงูุฑ ุงูุญูุงูู",callback_data="/HelpList1:"..msg.sender_user_id_}},{{text="ุงูุงูุฑ ุงูููุดุฆูู",callback_data="/HelpList4:"..msg.sender_user_id_},{text="ุงูุงูุฑ ุงููุฏุฑุงุก",callback_data="/HelpList3:"..msg.sender_user_id_}},{{text="ุงูุงูุฑ ุงูุงุนุถุงุก",callback_data="/HelpList6:"..msg.sender_user_id_},{text="ุงูุงูุฑ ุงููุทูุฑูู",callback_data="/HelpList5:"..msg.sender_user_id_}},{{text="โข ุงุฎูุงุก ุงููููุดู โข",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Help or Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == "ุชุนููู ุงูุฑ ู1" and SecondSudo(msg) and ChCheck(msg) or text == "ุชุนููู ุงูุฑ ููก" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูููุดุฉ (ู1) ุงูุงู " ,  1, "md")
DevRio:set(storm..'Rio:Help01'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local stormTeam =  DevRio:get(storm..'Rio:Help01'..msg.sender_user_id_)
if stormTeam == 'msg' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(storm..'Rio:Help01'..msg.sender_user_id_)
DevRio:set(storm..'Rio:Help1', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ุงููููุดู ุงูุฌุฏูุฏู " ,  1, "md")
return false end
end
if text == "ู1" or text == "ููก" or text == "ุงูุงูุฑ1" or text == "ุงูุงูุฑูก" then
if not Admin(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุฐุง ุงูุงูุฑ ูุฎุต ุงูุฑุชุจ ุงูุงุนูู ููุท\nโ๏ธุงุฑุณู โคฝ (ู6) ูุนุฑุถ ุงูุงูุฑ ุงูุงุนุถุงุก', 1, 'md')
else
local Help = DevRio:get(storm..'Rio:Help1')
local Text = [[
โโฏโ๏ธุงูุงูุฑ ุญูุงูุฉ ุงููุฌููุนู โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุฑูุงุจุท
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงููุนุฑูุงุช
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุจูุชุงุช
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงููุชุญุฑูู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูููุตูุงุช
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงููููุงุช
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุตูุฑ
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูููุฏูู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุงูููุงูู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุฏุฑุฏุดู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุชูุฌูู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุงุบุงูู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุตูุช
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุฌูุงุช
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงููุงุฑูุฏุงูู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุชูุฑุงุฑ
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงููุงุดุชุงู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุชุนุฏูู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุชุซุจูุช
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุงุดุนุงุฑุงุช
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูููุงูุด
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุฏุฎูู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุดุจูุงุช
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูููุงูุน
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงููุดุงุฑ
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูููุฑ
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุทุงุฆููู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงููู
โโโ๏ธููู โข ูุชุญ โคฝ ุงูุนุฑูู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุงููููุฒูู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงููุงุฑุณูู
โโฏโ๏ธููู โข ูุชุญ โคฝ ุงูุชูููุด
โ โ โ โ โโโโ โ โ โ
โโ๏ธุงูุงูุฑ ุญูุงูู ุงุฎุฑู โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธููู โข ูุชุญ + ุงูุงูุฑ โคฝ โค
โโฏโ๏ธุงูุชูุฑุงุฑ ุจุงูุทุฑุฏ
โโฏโ๏ธุงูุชูุฑุงุฑ ุจุงููุชู
โโฏโ๏ธุงูุชูุฑุงุฑ ุจุงูุชููุฏ
โโฏโ๏ธุงููุงุฑุณูู ุจุงูุทุฑุฏ
โโฏโ๏ธุงูุจูุชุงุช ุจุงูุทุฑุฏ
โโฏโ๏ธุงูุจูุชุงุช ุจุงูุชููุฏ
โ โ โ โ โโโโ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, (Help or Text), 1, 'md')
end end
if text == "ุชุนููู ุงูุฑ ู2" and SecondSudo(msg) and ChCheck(msg) or text == "ุชุนููู ุงูุฑ ููข" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูููุดุฉ (ู2) ุงูุงู " ,  1, "md")
DevRio:set(storm..'Rio:Help21'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local stormTeam =  DevRio:get(storm..'Rio:Help21'..msg.sender_user_id_)
if stormTeam == 'msg' then
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(storm..'Rio:Help21'..msg.sender_user_id_)
DevRio:set(storm..'Rio:Help2', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ุงููููุดู ุงูุฌุฏูุฏู " ,  1, "md")
return false end
end
if text == "ู2" and ChCheck(msg) or text == "ููข" and ChCheck(msg) or text == "ุงูุงูุฑ2" and ChCheck(msg) or text == "ุงูุงูุฑูข" and ChCheck(msg) then
if not Admin(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุฐุง ุงูุงูุฑ ูุฎุต ุงูุฑุชุจ ุงูุงุนูู ููุท\nโ๏ธุงุฑุณู โคฝ (ู6) ูุนุฑุถ ุงูุงูุฑ ุงูุงุนุถุงุก', 1, 'md')
else
local Help = DevRio:get(storm..'Rio:Help2')
local Text = [[
โ๏ธุงูุงูุฑ ุงูุงุฏูููู โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุงูุงุนุฏุงุฏุช
โโฏโ๏ธุชุงู ูููู 
โโฏโ๏ธุงูุดุงุก ุฑุงุจุท
โโฏโ๏ธุถุน ูุตู
โโฏโ๏ธุถุน ุฑุงุจุท
โโฏโ๏ธุถุน ุตูุฑู
โโฏโ๏ธุญุฐู ุงูุฑุงุจุท
โโฏโ๏ธุญุฐู ุงููุทุงูู
โโฏโ๏ธูุดู ุงูุจูุชุงุช
โโฏโ๏ธุทุฑุฏ ุงูุจูุชุงุช
โโฏโ๏ธุชูุธูู + ุงูุนุฏุฏ
โโฏโ๏ธุชูุธูู ุงูุชุนุฏูู
โโฏโ๏ธููููู + ุงููููู
โโฏโ๏ธุงุณู ุงูุจูุช + ุงูุงูุฑ
โโฏโ๏ธุถุน โข ุญุฐู โคฝ ุชุฑุญูุจ
โโฏโ๏ธุถุน โข ุญุฐู โคฝ ููุงููู
โโฏโ๏ธุงุถู โข ุญุฐู โคฝ ุตูุงุญูู
โโฏโ๏ธุงูุตูุงุญูุงุช โข ุญุฐู ุงูุตูุงุญูุงุช
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุถุน ุณุจุงู + ุงูุนุฏุฏ
โโฏโ๏ธุถุน ุชูุฑุงุฑ + ุงูุนุฏุฏ
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุฑูุน ูููุฒ โข ุชูุฒูู ูููุฒ
โโฏโ๏ธุงููููุฒูู โข ุญุฐู ุงููููุฒูู
โโฏโ๏ธูุดู ุงููููุฏ โข ุฑูุน ุงููููุฏ
โ โ โ โ โโโ โ โ โ โ
โโฏโ๏ธุญุฐู โข ูุณุญ + ุจุงูุฑุฏ
โโฏโ๏ธููุน โข ุงูุบุงุก ููุน
โโฏโ๏ธูุงุฆูู ุงูููุน
โโฏโ๏ธุญุฐู ูุงุฆูู ุงูููุน
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุชูุนูู โข ุชุนุทูู โคฝ ุงูุฑุงุจุท
โโฏโ๏ธุชูุนูู โข ุชุนุทูู โคฝ ุงูุงูุนุงุจ
โโฏโ๏ธุชูุนูู โข ุชุนุทูู โคฝ ุงูุชุฑุญูุจ
โโฏโ๏ธุชูุนูู โข ุชุนุทูู โคฝ ุงูุชุงู ูููู
โโฏโ๏ธุชูุนูู โข ุชุนุทูู โคฝ ูุดู ุงูุงุนุฏุงุฏุงุช
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุทุฑุฏ ุงููุญุฐูููู
โโฏโ๏ธุทุฑุฏ โคฝ ุจุงูุฑุฏ โข ุจุงููุนุฑู โข ุจุงูุงูุฏู
โโฏโ๏ธูุชู โข ุงูุบุงุก ูุชู
โโฏโ๏ธุชููุฏ โข ุงูุบุงุก ุชููุฏ
โโฏโ๏ธุญุธุฑ โข ุงูุบุงุก ุญุธุฑ
โโฏโ๏ธุงูููุชูููู โข ุญุฐู ุงูููุชูููู
โโฏโ๏ธุงููููุฏูู โข ุญุฐู ุงููููุฏูู
โโฏโ๏ธุงููุญุธูุฑูู โข ุญุฐู ุงููุญุธูุฑูู
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุชูููุฏ ุฏูููู + ุนุฏุฏ ุงูุฏูุงุฆู
โโฏโ๏ธุชูููุฏ ุณุงุนู + ุนุฏุฏ ุงูุณุงุนุงุช
โโฏโ๏ธุชูููุฏ ููู + ุนุฏุฏ ุงูุงูุงู
โโฏโ๏ธุงูุบุงุก ุชูููุฏ โคฝ ูุงูุบุงุก ุงูุชูููุฏ ุจุงูููุช
โ โ โ โ โโโโ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, (Help or Text), 1, 'md')
end end
if text == "ุชุนููู ุงูุฑ ู3" and SecondSudo(msg) and ChCheck(msg) or text == "ุชุนููู ุงูุฑ ููฃ" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูููุดุฉ (ู3) ุงูุงู " ,  1, "md")
DevRio:set(storm..'Rio:Help31'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local stormTeam =  DevRio:get(storm..'Rio:Help31'..msg.sender_user_id_)
if stormTeam == 'msg' then
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(storm..'Rio:Help31'..msg.sender_user_id_)
DevRio:set(storm..'Rio:Help3', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ุงููููุดู ุงูุฌุฏูุฏู " ,  1, "md")
return false end
end
if text == "ู3" and ChCheck(msg) or text == "ููฃ" and ChCheck(msg) or text == "ุงูุงูุฑ3" and ChCheck(msg) or text == "ุงูุงูุฑูฃ" and ChCheck(msg) then
if not Admin(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุฐุง ุงูุงูุฑ ูุฎุต ุงูุฑุชุจ ุงูุงุนูู ููุท\nโ๏ธุงุฑุณู โคฝ (ู6) ูุนุฑุถ ุงูุงูุฑ ุงูุงุนุถุงุก', 1, 'md')
else
local Help = DevRio:get(storm..'Rio:Help3')
local Text = [[
โโฏโ๏ธุงูุงูุฑ ุงููุฏุฑุงุก โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธูุญุต ุงูุจูุช
โโฏโ๏ธุถุน ุงุณู + ุงูุงุณู
โโฏโ๏ธุงุถู โข ุญุฐู โคฝ ุฑุฏ
โโฏโ๏ธุฑุฏูุฏ ุงููุฏูุฑ
โโฏโ๏ธุญุฐู ุฑุฏูุฏ ุงููุฏูุฑ
โโฏโ๏ธุงุถู โข ุญุฐู โคฝ ุฑุฏ ูุชุนุฏุฏ
โโโ๏ธุญุฐู ุฑุฏ ูู ูุชุนุฏุฏ
โโฏโ๏ธุงูุฑุฏูุฏ ุงููุชุนุฏุฏู
โโฏโ๏ธุญุฐู ุงูุฑุฏูุฏ ุงููุชุนุฏุฏู
โโฏโ๏ธุญุฐู ููุงุฆู ุงูููุน
โโฏโ๏ธููุน โคฝ ุจุงูุฑุฏ ุนูู ( ููุตู โข ุตูุฑู โข ูุชุญุฑูู )
โโฏโ๏ธุญุฐู ูุงุฆูู ููุน + โคฝ โค
( ุงูุตูุฑ โข ุงููุชุญุฑูุงุช โข ุงูููุตูุงุช )
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุชูุฒูู ุงููู
โโฏโ๏ธุฑูุน ุงุฏูู โข ุชูุฒูู ุงุฏูู
โโฏโ๏ธุงูุงุฏูููู โข ุญุฐู ุงูุงุฏูููู
โ โ โ โ โโโโ โ โ โ
โโโ๏ธุชุซุจูุช
โโฏโ๏ธุงูุบุงุก ุงูุชุซุจูุช
โโโ๏ธุงุนุงุฏู ุงูุชุซุจูุช
โโฏโ๏ธุงูุบุงุก ุชุซุจูุช ุงููู
โ โ โ โ โโโ โ โ โ
โโฏโ๏ธุชุบูุฑ ุฑุฏ + ุงุณู ุงูุฑุชุจู + ุงููุต โคฝ โค
โโฏโ๏ธุงููุทูุฑ โข ููุดุฆ ุงูุงุณุงุณู
โโโ๏ธุงูููุดุฆ โข ุงููุฏูุฑ โข ุงูุงุฏูู
โโฏโ๏ธุงููููุฒ โข ุงูููุธู โข ุงูุนุถู
โโฏโ๏ธุญุฐู ุฑุฏูุฏ ุงูุฑุชุจ
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุชุบููุฑ ุงูุงูุฏู โคฝ ูุชุบููุฑ ุงููููุดู
โโฏโ๏ธุชุนููู ุงูุงูุฏู โคฝ ูุชุนููู ุงููููุดู
โโฏโ๏ธุญุฐู ุงูุงูุฏู โคฝ ูุญุฐู ุงููููุดู
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุชูุนูู โข ุชุนุทูู + ุงูุงูุฑ โคฝ โค
โโฏโ๏ธุงุทุฑุฏูู โข ุงูุงูุฏู ุจุงูุตูุฑู โข ุงูุงุจุฑุงุฌ
โโฏโ๏ธูุนุงูู ุงูุงุณูุงุก โข ุงูุงูุฑ ุงููุณุจ โข ุงูุทู
โโฏโ๏ธุงูุงูุฏู โข ุชุญููู ุงูุตูุบ โข ุงูุงูุฑ ุงูุชุญุดูุด
โโฏโ๏ธุฑุฏูุฏ ุงููุฏูุฑ โข ุฑุฏูุฏ ุงููุทูุฑ โข ุงูุชุญูู
โโฏโ๏ธุถุงููู โข ุญุณุงุจ ุงูุนูุฑ โข ุงูุฒุฎุฑูู
โ โ โ โ โโโโ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, (Help or Text), 1, 'md')
end end
if text == "ุชุนููู ุงูุฑ ู4" and ChCheck(msg) and SecondSudo(msg) or text == "ุชุนููู ุงูุฑ ููค" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูููุดุฉ (ู4) ุงูุงู " ,  1, "md")
DevRio:set(storm..'Rio:Help41'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local stormTeam =  DevRio:get(storm..'Rio:Help41'..msg.sender_user_id_)
if stormTeam == 'msg' then
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(storm..'Rio:Help41'..msg.sender_user_id_)
DevRio:set(storm..'Rio:Help4', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ุงููููุดู ุงูุฌุฏูุฏู" ,  1, "md")
return false end
end
if text == "ููค" and ChCheck(msg) or text == "ู4" and ChCheck(msg) or text == "ุงูุงูุฑ4" and ChCheck(msg) or text == "ุงูุงูุฑูค" and ChCheck(msg) then
if not Admin(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุฐุง ุงูุงูุฑ ูุฎุต ุงูุฑุชุจ ุงูุงุนูู ููุท\nโ๏ธุงุฑุณู โคฝ (ู6) ูุนุฑุถ ุงูุงูุฑ ุงูุงุนุถุงุก', 1, 'md')
else
local Help = DevRio:get(storm..'Rio:Help4')
local Text = [[
โโฏโ๏ธุงูุงูุฑ ุงูููุดุฆูู โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุชูุฒูู ุงููู
โโฏโ๏ธุงูููุฏูุง โข ุงูุณุญ
โโฏโ๏ธุชุนูู ุนุฏุฏ ุงูุญุฐู
โโฏโ๏ธุชุฑุชูุจ ุงูุงูุงูุฑ
โโฏโ๏ธุงุถู โข ุญุฐู โคฝ ุงูุฑ
โโฏโ๏ธุญุฐู ุงูุงูุงูุฑ ุงููุถุงูู
โโฏโ๏ธุงูุงูุงูุฑ ุงููุถุงูู
โโฏโ๏ธุงุถู ููุงุท โคฝ ุจุงูุฑุฏ โข ุจุงูุงูุฏู
โโฏโ๏ธุงุถู ุฑุณุงุฆู โคฝ ุจุงูุฑุฏ โข ุจุงูุงูุฏู
โโฏโ๏ธุฑูุน ููุธู โข ุชูุฒูู ููุธู
โโฏโ๏ธุงูููุธููู โข ุญุฐู ุงูููุธููู
โโฏโ๏ธุฑูุน ูุฏูุฑ โข ุชูุฒูู ูุฏูุฑ
โโฏโ๏ธุงููุฏุฑุงุก โข ุญุฐู ุงููุฏุฑุงุก
โโฏโ๏ธุชูุนูู โข ุชุนุทูู + ุงูุงูุฑ โคฝ โค
โโฏโ๏ธูุฒููู โข ุงูุณุญ
โโฏโ๏ธุงูุญุธุฑ โข ุงููุชู
โ โ โ โ โโโ โ โ โ โ
โโฏโ๏ธุงูุงูุฑ ุงูููุดุฆูู ุงูุงุณุงุณููู โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธูุถุน ููุจ + ุงูููุจ
โโฏโ๏ธุชูุนูู โข ุชุนุทูู โคฝ ุงูุฑูุน
โโฏโ๏ธุฑูุน ููุดุฆ โข ุชูุฒูู ููุดุฆ
โโฏโ๏ธุงูููุดุฆูู โข ุญุฐู ุงูููุดุฆูู
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ูุดุฑู
โโฏโโฏโ๏ธุฑูุน ุจูู ุงูุตูุงุญูุงุช
โโฏโ๏ธุญุฐู ุงูููุงุฆู
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุงูุงูุฑ ุงููุงูููู โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ููุดุฆ ุงุณุงุณู
โโฏโ๏ธุญุฐู ุงูููุดุฆูู ุงูุงุณุงุณููู 
โโฏโ๏ธุงูููุดุฆูู ุงูุงุณุงุณููู 
โโฏโ๏ธุญุฐู ุฌููุน ุงูุฑุชุจ
โ โ โ โ โโโโ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, (Help or Text), 1, 'md')
end end
if text == "ุชุนููู ุงูุฑ ู5" and SecondSudo(msg) and ChCheck(msg) or text == "ุชุนููู ุงูุฑ ููฅ" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูููุดุฉ (ู5) ุงูุงู " ,  1, "md")
DevRio:set(storm..'Rio:Help51'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local stormTeam =  DevRio:get(storm..'Rio:Help51'..msg.sender_user_id_)
if stormTeam == 'msg' then
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(storm..'Rio:Help51'..msg.sender_user_id_)
DevRio:set(storm..'Rio:Help5', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ุงููููุดู ุงูุฌุฏูุฏู " ,  1, "md")
return false end
end
if text == "ููฅ" and ChCheck(msg) or text == "ู5" and ChCheck(msg) or text == "ุงูุงูุฑ5" and ChCheck(msg) or text == "ุงูุงูุฑูฅ" and ChCheck(msg) then
if not SudoBot(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูุฐุง ุงูุงูุฑ ูููุทูุฑูู ููุท', 1, 'md')
else
local Help = DevRio:get(storm..'Rio:Help5')
local Text = [[
โโฏโ๏ธุงูุงูุฑ ุงููุทูุฑูู โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุงูุฌุฑูุจุงุช
โโฏโ๏ธุงููุทูุฑูู
โโฏโ๏ธุงููุดุชุฑููู
โโฏโ๏ธุงูุงุญุตุงุฆูุงุช
โโฏโ๏ธุงููุฌููุนุงุช
โโฏโ๏ธุงุณู ุงูุจูุช + ุบุงุฏุฑ
โโฏโ๏ธุงุณู ุงูุจูุช + ุชุนุทูู
โโฏโ๏ธูุดู + -ุงูุฏู ุงููุฌููุนู
โโฏโ๏ธุฑูุน ูุงูู โข ุชูุฒูู ูุงูู
โโฏโ๏ธุงููุงูููู โข ุญุฐู ุงููุงูููู
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ูุฏูุฑ ุนุงู
โโฏโ๏ธุญุฐู โข ุงููุฏุฑุงุก ุงูุนุงููู 
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ุงุฏูู ุนุงู
โโฏโ๏ธุญุฐู โข ุงูุงุฏูููู ุงูุนุงููู 
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ูููุฒ ุนุงู
โโฏโ๏ธุญุฐู โข ุงููููุฒูู ุนุงู 
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุงูุงูุฑ ุงููุทูุฑ ุงูุงุณุงุณู โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุชุญุฏูุซ
โโฏโ๏ธุงููููุงุช
โโฏโ๏ธุงููุชุฌุฑ
โโฏโ๏ธุงูุณูุฑูุฑ
โโฏโ๏ธุฑูุงุจุท ุงูุฌุฑูุจุงุช
โโฏโ๏ธุชุญุฏูุซ ุงูุณูุฑุณ
โโฏโ๏ธุชูุธูู ุงูุฌุฑูุจุงุช
โโฏโ๏ธุชูุธูู ุงููุดุชุฑููู
โโฏโ๏ธุญุฐู ุฌููุน ุงููููุงุช
โโฏโ๏ธุชุนููู ุงูุงูุฏู ุงูุนุงู
โโฏโ๏ธุชุบูุฑ ุงููุทูุฑ ุงูุงุณุงุณู
โโฏโ๏ธุญุฐู ูุนูููุงุช ุงูุชุฑุญูุจ
โโฏโ๏ธุชุบูุฑ ูุนูููุงุช ุงูุชุฑุญูุจ
โโฏโ๏ธุบุงุฏุฑ + -ุงูุฏู ุงููุฌููุนู
โโฏโ๏ธุชุนููู ุนุฏุฏ ุงูุงุนุถุงุก + ุงูุนุฏุฏ
โโฏโ๏ธุญุธุฑ ุนุงู โข ุงูุบุงุก ุงูุนุงู
โโฏโ๏ธูุชู ุนุงู โข ุงูุบุงุก ุงูุนุงู
โโฏโ๏ธูุงุฆูู ุงูุนุงู โข ุญุฐู ูุงุฆูู ุงูุนุงู
โโฏโ๏ธูุถุน โข ุญุฐู โคฝ ุงุณู ุงูุจูุช
โโฏโ๏ธุงุถู โข ุญุฐู โคฝ ุฑุฏ ุนุงู
โโฏโ๏ธุฑุฏูุฏ ุงููุทูุฑ โข ุญุฐู ุฑุฏูุฏ ุงููุทูุฑ
โโฏโ๏ธุชุนููู โข ุญุฐู โข ุฌูุจ โคฝ ุฑุฏ ุงูุฎุงุต
โโฏโ๏ธุฌูุจ ูุณุฎู ุงูุฌุฑูุจุงุช
โโฏโ๏ธุฑูุน ุงููุณุฎู + ุจุงูุฑุฏ ุนูู ุงูููู
โโฏโ๏ธุชุนููู โข ุญุฐู โคฝ ููุงุฉ ุงูุงุดุชุฑุงู
โโฏโ๏ธุฌูุจ ูููุดู ุงูุงุดุชุฑุงู
โโฏโ๏ธุชุบููุฑ โข ุญุฐู โคฝ ูููุดู ุงูุงุดุชุฑุงู
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ูุทูุฑ
โโฏโ๏ธุงููุทูุฑูู โข ุญุฐู ุงููุทูุฑูู
โโฏโ๏ธุฑูุน โข ุชูุฒูู โคฝ ูุทูุฑ ุซุงููู
โโฏโ๏ธุงูุซุงููููู โข ุญุฐู ุงูุซุงููููู
โโฏโ๏ธุชุนููู โข ุญุฐู โคฝ ูููุดุฉ ุงูุงูุฏู
โโฏโ๏ธุงุฐุงุนู ูููู ุจุงูุชูุฌูู โคฝ ุจุงูุฑุฏ
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุชูุนูู ููู + ุงุณู ุงูููู
โโฏโ๏ธุชุนุทูู ููู + ุงุณู ุงูููู
โโโ๏ธุชูุนูู โข ุชุนุทูู + ุงูุงูุฑ โคฝ โค
โโฏโ๏ธุงูุงุฐุงุนู โข ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู
โโฏโ๏ธุชุฑุญูุจ ุงูุจูุช โข ุงููุบุงุฏุฑู
โโฏโ๏ธุงูุจูุช ุงูุฎุฏูู โข ุงูุชูุงุตู
โ โ โ โ โโโโ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, (Help or Text), 1, 'md')
end end
if text == "ุชุนููู ุงูุฑ ู6" and SecondSudo(msg) and ChCheck(msg) or text == "ุชุนููู ุงูุฑ ููฆ" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูููุดุฉ (ู6) ุงูุงู " ,  1, "md")
DevRio:set(storm..'Rio:Help61'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local stormTeam =  DevRio:get(storm..'Rio:Help61'..msg.sender_user_id_)
if stormTeam == 'msg' then
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(storm..'Rio:Help61'..msg.sender_user_id_)
DevRio:set(storm..'Rio:Help6', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ุงููููุดู ุงูุฌุฏูุฏู" ,  1, "md")
return false end
end
if text == "ููฆ" and ChCheck(msg) or text == "ู6" and ChCheck(msg) or text == "ุงูุงูุฑ6" and ChCheck(msg) or text == "ุงูุงูุฑูฆ" and ChCheck(msg) then
local Help = DevRio:get(storm..'Rio:Help6')
local Text = [[
โโฏโ๏ธุงูุงูุฑ ุงูุงุนุถุงุก โคฝ โค
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธุงูุณูุฑุณ โข ูููุนู โข ุฑุชุจุชู โข ูุนูููุงุชู 
โโฏโ๏ธุฑููู โข ููุจู โข ูุจุฐุชู โข ุตูุงุญูุงุชู โข ุบูููู
โโฏโ๏ธุฑุณุงุฆูู โข ุญุฐู ุฑุณุงุฆูู โข ุงุณูู โข ูุนุฑูู 
โโฏโ๏ธุงูุฏู โขุงูุฏูู โข ุฌูุงุชู โข ุฑุงุณููู โข ุงูุงูุนุงุจ 
โโฏโ๏ธููุงุทู โข ุจูุน ููุงุทู โข ุงูููุงููู โข ุฒุฎุฑูู 
โโฏโ๏ธุฑุงุจุท ุงูุญุฐู โข ูุฒููู โข ุงุทุฑุฏูู โข ุงููุทูุฑ 
โโฏโ๏ธููู ุถุงููู โข ูุดุงูุฏุงุช ุงูููุดูุฑ โข ุงูุฑุงุจุท 
โโฏโ๏ธุงูุฏู ุงููุฌููุนู โข ูุนูููุงุช ุงููุฌููุนู 
โโฏโ๏ธูุณุจู ุงูุญุจ โข ูุณุจู ุงููุฑู โข ูุณุจู ุงูุบุจุงุก 
โโฏโ๏ธูุณุจู ุงูุฑุฌููู โข ูุณุจู ุงูุงููุซู โข ุงูุชูุงุนู
โ โ โ โ โโโโ โ โ โ
โโฏโ๏ธููุจู + ุจุงูุฑุฏ
โโฏโ๏ธููู + ุงููููู
โโฏโ๏ธุฒุฎุฑูู + ุงุณูู
โโฏโ๏ธุจุฑุฌ + ููุน ุงูุจุฑุฌ
โโฏโ๏ธูุนูู ุงุณู + ุงูุงุณู
โโฏโ๏ธุจูุณู โข ุจูุณูุง โคฝ ุจุงูุฑุฏ
โโฏโ๏ธุงุญุณุจ + ุชุงุฑูุฎ ูููุงุฏู
โโฏโ๏ธุฑูุน ูุทู โข ุชูุฒูู ูุทู โข ุงููุทุงูู
โโฏโ๏ธูููู โข ููููุง โคฝ ุจุงูุฑุฏ โข ุจุงููุนุฑู
โโฏโ๏ธุตูุญู โข ุตูุญูุง โคฝ ุจุงูุฑุฏ โข ุจุงููุนุฑู
โโโ๏ธุชูุงุนูู โข ุชูุงุนูู โคฝ ุจุงูุฑุฏ
โโฏโ๏ธุตูุงุญูุงุชู โคฝ ุจุงูุฑุฏ โข ุจุงููุนุฑู โข ุจุงูุงูุฏู
โโฏโ๏ธุงูุฏู โข ูุดู  โคฝ ุจุงูุฑุฏ โข ุจุงููุนุฑู โข ุจุงูุงูุฏู
โโฏโ๏ธุชุญููู + ุจุงูุฑุฏ โคฝ ุตูุฑู โข ููุตู โข ุตูุช โข ุจุตูู
โโฏโ๏ธุงูุทู + ุงูููุงู ุชุฏุนู ุฌููุน ุงููุบุงุช ูุน ุงูุชุฑุฌูู ููุนุฑุจู
โ โ โ โ โโโโ โ โ โ
โ๏ธ[๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค ](https://t.me/So_ST0RM)
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, (Help or Text), 1, 'md')
end
--     Source Storm     --
if SecondSudo(msg) then
if text == "ุชุญุฏูุซ ุงูุณูุฑุณ" and ChCheck(msg) or text == "ุชุญุฏูุซ ุณูุฑุณ" and ChCheck(msg) or text == "โคฝ ุชุญุฏูุซ ุงูุณูุฑุณ โ" and ChCheck(msg) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุฌุงุฑู ุชุญุฏูุซ ุณูุฑุณ ุณุชูุฑู', 1, 'md') 
os.execute('rm -rf storm.lua') 
os.execute('wget https://raw.githubusercontent.com/BODYUXM/STORM/master/storm.lua') 
dofile('storm.lua') 
io.popen("rm -rf ../.telegram-cli/*")
print("\27[31;47m\n          ( ุชู ุชุญุฏูุซ ุงูุณูุฑุณ )          \n\27[0;34;49m\n") 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุงูุชุญุฏูุซ ุงูู ุงูุงุตุฏุงุฑ ุงูุฌุฏูุฏ', 1, 'md') 
end
if text == 'ุชุญุฏูุซ' and ChCheck(msg) or text == 'ุชุญุฏูุซ ุงูุจูุช' and ChCheck(msg) or text == 'โคฝ ุชุญุฏูุซ โ' and ChCheck(msg) then  
dofile('storm.lua') 
io.popen("rm -rf ../.telegram-cli/*")
print("\27[31;47m\n        ( ุชู ุชุญุฏูุซ ูููุงุช ุงูุจูุช )        \n\27[0;34;49m\n") 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุชุญุฏูุซ ูููุงุช ุงูุจูุช", 1, "md")
end
--     Source Storm     --
if text == 'ููู ุงูุงุญุตุงุฆูุงุช' and ChCheck(msg) or text == 'โคฝ ููู ุงูุงุญุตุงุฆูุงุช โ' and ChCheck(msg) then
local Users = DevRio:smembers(storm.."User_Bot")
local Groups = DevRio:smembers(storm..'Chek:Groups')
local Sudos = DevRio:smembers(storm.."Sudo:User")
if DevRio:get(storm..'Name:Bot') then
DevRio:set(storm..'Rio:NameBot',(DevRio:get(storm..'Name:Bot') or 'ุณุชูุฑู'))
end
for i = 1, #Users do
local id = Users[i]
if id:match("^(%d+)") then
DevRio:sadd(storm..'Rio:Users',Users[i]) 
end
end
for i = 1, #Sudos do
DevRio:sadd(storm..'Rio:SudoBot:',Sudos[i]) 
end
for i = 1, #Groups do
DevRio:sadd(storm..'Rio:Groups',Groups[i]) 
if DevRio:get(storm.."Private:Group:Link"..Groups[i]) then
DevRio:set(storm.."Rio:Groups:Links"..Groups[i],DevRio:get(storm.."Private:Group:Link"..Groups[i]))
end
if DevRio:get(storm.."Get:Welcome:Group"..Groups[i]) then
DevRio:set(storm..'Rio:Groups:Welcomes'..Groups[i],DevRio:get(storm.."Get:Welcome:Group"..Groups[i]))
end
local list2 = DevRio:smembers(storm..'Constructor'..Groups[i])
for k,v in pairs(list2) do
DevRio:sadd(storm.."Rio:Constructor:"..Groups[i], v)
end
local list3 = DevRio:smembers(storm..'BasicConstructor'..Groups[i])
for k,v in pairs(list3) do
DevRio:sadd(storm.."Rio:BasicConstructor:"..Groups[i], v)
end
local list4 = DevRio:smembers(storm..'Manager'..Groups[i])
for k,v in pairs(list4) do
DevRio:sadd(storm.."Rio:Managers:"..Groups[i], v)
end
local list5 = DevRio:smembers(storm..'Mod:User'..Groups[i])
for k,v in pairs(list5) do
DevRio:sadd(storm.."Rio:Admins:"..Groups[i], v)
end
local list6 = DevRio:smembers(storm..'Special:User'..Groups[i])
for k,v in pairs(list6) do
DevRio:sadd(storm.."Rio:VipMem:"..Groups[i], v)
end
DevRio:set(storm.."Rio:Lock:Bots"..Groups[i],"del") DevRio:hset(storm.."Rio:Spam:Group:User"..Groups[i] ,"Spam:User","keed") 
LockList ={'Rio:Lock:Links','Rio:Lock:Forwards','Rio:Lock:Videos','Rio:Lock:Gifs','Rio:Lock:EditMsgs','Rio:Lock:Stickers','Rio:Lock:Farsi','Rio:Lock:Spam','Rio:Lock:WebLinks'}
for i,Lock in pairs(LockList) do
DevRio:set(storm..Lock..Groups[i],true)
end
end
send(msg.chat_id_, msg.id_,'โ๏ธุชู ููู โคฝ '..#Groups..' ูุฌููุนู\nโ๏ธุชู ููู โคฝ '..#Users..' ูุดุชุฑู\nโ๏ธูู ุงูุชุญุฏูุซ ุงููุฏูู ุงูู ุงูุชุญุฏูุซ ุงูุฌุฏูุฏ')
end
--     Source Storm     --
if text == 'ุงููููุงุช' and ChCheck(msg) then
Files = '\nโ๏ธุงููููุงุช ุงูููุนูู ูู ุงูุจูุช โคฝ โค \nโ โ โ โ โ โ โ โ โ\n'
i = 0
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
i = i + 1
Files = Files..i..'~ : `'..v..'`\n'
end
end
if i == 0 then
Files = 'โ๏ธูุง ุชูุฌุฏ ูููุงุช ูู ุงูุจูุช'
end
send(msg.chat_id_, msg.id_,Files)
end
if text == "ูุชุฌุฑ ุงููููุงุช" and ChCheck(msg) or text == 'ุงููุชุฌุฑ' and ChCheck(msg) or text == 'โคฝ  ุงููุชุฌุฑ โ' and ChCheck(msg) then
local Get_Files, res = https.request("https://raw.githubusercontent.com/BODYUXM/STORMFiles/master/getfile.json")
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
vardump(res.plugins_)
if Get_info then
local TextS = "\nโ๏ธูุงุฆูุฉ ูููุงุช ูุชุฌุฑ ุณูุฑุณ ุณุชูุฑู\nโ๏ธุงููููุงุช ุงููุชููุฑู ุญุงููุง โคฝ โค\nโ โ โ โ โ โ โ โ โ\n"
local TextE = "โ โ โ โ โ โ โ โ โ\nโ๏ธุนูุงูุฉ โคฝ (โ) ุชุนูู ุงูููู ููุนู\nโ๏ธุนูุงูุฉ โคฝ (โ๏ธ) ุชุนูู ุงูููู ูุนุทู\n"
local NumFile = 0
for name,Info in pairs(res.plugins_) do
local CheckFileisFound = io.open("Files/"..name,"r")
if CheckFileisFound then
io.close(CheckFileisFound)
CheckFile = "(โ)"
else
CheckFile = "(โ๏ธ)"
end
NumFile = NumFile + 1
TextS = TextS.."โ๏ธ"..Info..' โคฝ โค\n'..NumFile.."~ : `"..name..'` โฌ '..CheckFile.."\n"
end
send(msg.chat_id_, msg.id_,TextS..TextE) 
end
else
send(msg.chat_id_, msg.id_,"โ๏ธูุง ููุฌุฏ ุงุชุตุงู ูู ุงููapi") 
end
end
if text == "ูุณุญ ุฌููุน ุงููููุงุช" and ChCheck(msg) or text == "ุญุฐู ุฌููุน ุงููููุงุช" and ChCheck(msg) then
os.execute("rm -fr Files/*")
send(msg.chat_id_,msg.id_,"โ๏ธุชู ุญุฐู ุฌููุน ุงููููุงุช ุงูููุนูู")
end
if text and text:match("^(ุชุนุทูู ููู) (.*)(.lua)$") and ChCheck(msg) then
local FileGet = {string.match(text, "^(ุชุนุทูู ููู) (.*)(.lua)$")}
local FileName = FileGet[2]..'.lua'
local GetJson, Res = https.request("https://raw.githubusercontent.com/BODYUXM/STORMFiles/master/stormFiles/"..FileName)
if Res == 200 then
os.execute("rm -fr Files/"..FileName)
send(msg.chat_id_, msg.id_,"\nโ๏ธุงูููู โคฝ *"..FileName.."*\nโ๏ธุชู ุชุนุทููู ูุญุฐูู ูู ุงูุจูุช ุจูุฌุงุญ") 
dofile('storm.lua')  
else
send(msg.chat_id_, msg.id_,"โ๏ธูุง ููุฌุฏ ููู ุจูุฐุง ุงูุงุณู") 
end
end
if text and text:match("^(ุชูุนูู ููู) (.*)(.lua)$") and ChCheck(msg) then
local FileGet = {string.match(text, "^(ุชูุนูู ููู) (.*)(.lua)$")}
local FileName = FileGet[2]..'.lua'
local GetJson, Res = https.request("https://raw.githubusercontent.com/BODYUXM/STORMFiles/master/stormFiles/"..FileName)
if Res == 200 then
local ChekAuto = io.open("Files/"..FileName,'w+')
ChekAuto:write(GetJson)
ChekAuto:close()
send(msg.chat_id_, msg.id_,"\nโ๏ธุงูููู โคฝ *"..FileName.."*\nโ๏ธุชู ุชูุนููู ูู ุงูุจูุช ุจูุฌุงุญ") 
dofile('storm.lua')  
else
send(msg.chat_id_, msg.id_,"โ๏ธูุง ููุฌุฏ ููู ุจูุฐุง ุงูุงุณู") 
end
return false
end
end 
--     Source Storm     --
if text and (text == 'ุญุฐู ูุนูููุงุช ุงูุชุฑุญูุจ' or text == 'ูุณุญ ูุนูููุงุช ุงูุชุฑุญูุจ') and SecondSudo(msg) and ChCheck(msg) then    
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุญุฐู ูุนูููุงุช ุงูุชุฑุญูุจ', 1, 'md')   
DevRio:del(storm..'Rio:Text:BotWelcome')
DevRio:del(storm..'Rio:Photo:BotWelcome')
return false
end 
if text and (text == 'ุชูุนูู ุชุฑุญูุจ ุงูุจูุช' or text == 'ุชูุนูู ูุนูููุงุช ุงูุชุฑุญูุจ' or text == 'โคฝ ุชูุนูู ุชุฑุญูุจ ุงูุจูุช โ') and SecondSudo(msg) and ChCheck(msg) then    
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุชูุนูู ุงูุชุฑุญูุจ ุนูุฏ ุงุถุงูุฉ ุงูุจูุช ูู ุงููุฌููุนู', 1, 'md')   
DevRio:del(storm..'Rio:Lock:BotWelcome')
return false
end 
if text and (text == 'ุชุนุทูู ุชุฑุญูุจ ุงูุจูุช' or text == 'ุชุนุทูู ูุนูููุงุช ุงูุชุฑุญูุจ' or text == 'โคฝ ุชุนุทูู ุชุฑุญูุจ ุงูุจูุช โ') and SecondSudo(msg) and ChCheck(msg) then    
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุชุนุทูู ุงูุชุฑุญูุจ ุนูุฏ ุงุถุงูุฉ ุงูุจูุช ูู ุงููุฌููุนู', 1, 'md')   
DevRio:set(storm..'Rio:Lock:BotWelcome',true)
return false
end 
if text and (text == 'ุชุบูุฑ ูุนูููุงุช ุงูุชุฑุญูุจ' or text == 'ุชุบููุฑ ูุนูููุงุช ุงูุชุฑุญูุจ' or text == 'โคฝ ุชุบูุฑ ูุนูููุงุช ุงูุชุฑุญูุจ โ') and SecondSudo(msg) and ChCheck(msg) then    
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุงุฑุณู ูู ูุต ุงูุชุฑุญูุจ', 1, 'md') 
DevRio:del(storm..'Rio:Text:BotWelcome')
DevRio:del(storm..'Rio:Photo:BotWelcome')
DevRio:set(storm.."Rio:Set:BotWelcome"..msg.sender_user_id_,"Text") 
return false
end 
if text and DevRio:get(storm.."Rio:Set:BotWelcome"..msg.sender_user_id_) == 'Text' then 
if text and text:match("^ุงูุบุงุก$") then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุงูุงูุฑ", 1, "md") 
DevRio:del(storm.."Rio:Set:BotWelcome"..msg.sender_user_id_)   
return false
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ุงููุต ุงุฑุณู ูู ุตูุฑุฉ ุงูุชุฑุญูุจ\nโ๏ธุงุฑุณู โคฝ ุงูุบุงุก ูุญูุธ ุงููุต ููุท", 1, 'md')   
DevRio:set(storm.."Rio:Text:BotWelcome",text) 
DevRio:set(storm.."Rio:Set:BotWelcome"..msg.sender_user_id_,"Photo") 
return false 
end 
if DevRio:get(storm.."Rio:Set:BotWelcome"..msg.sender_user_id_) == 'Photo' then 
if text and text:match("^ุงูุบุงุก$") then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ุงููุต ูุงูุบุงุก ุญูุธ ุตูุฑุฉ ุงูุชุฑุญูุจ", 1, "md") 
DevRio:del(storm.."Rio:Set:BotWelcome"..msg.sender_user_id_)    
return false
end 
if msg.content_.photo_ and msg.content_.photo_.sizes_[1] then   
DevRio:set(storm.."Rio:Photo:BotWelcome",msg.content_.photo_.sizes_[1].photo_.persistent_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญูุธ ุงููุต ูุตูุฑุฉ ุงูุชุฑุญูุจ", 1, 'md')   
DevRio:del(storm.."Rio:Set:BotWelcome"..msg.sender_user_id_)   
end
return false
end
--     Source Storm     --
if text and text:match("^ุถุน ูููุดู ุงููุทูุฑ$") or text and text:match("^ูุถุน ูููุดู ุงููุทูุฑ$") or text and text:match("^ุชุบููุฑ ูููุดู ุงููุทูุฑ$") or text and text:match("^โคฝ ุชุบููุฑ ูููุดู ุงููุทูุฑ โ$") and ChCheck(msg) then
if not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท ', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุงุฑุณู ูููุดุฉ ุงููุทูุฑ ุงูุงู ", 1, "md")
DevRio:setex(storm.."Rio:DevText"..msg.chat_id_..":" .. msg.sender_user_id_, 300, true)
end end
if text and text:match("^ูุณุญ ูููุดู ุงููุทูุฑ$") or text and text:match("^ุญุฐู ูููุดู ุงููุทูุฑ$") then
if not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท ', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุญุฐู ูููุดุฉ ุงููุทูุฑ", 1, "md")
DevRio:del(storm.."DevText")
end end
--     Source Storm     --
if DevRio:get(storm.."textch:user"..msg.chat_id_.."" .. msg.sender_user_id_) then 
if text and text:match("^ุงูุบุงุก$") then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "โ๏ธุชู ุงูุบุงุก ุงูุงูุฑ", 1, "md") 
DevRio:del(storm.."textch:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
return false  end 
DevRio:del(storm.."textch:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
DevRio:set(storm..'Rio:ChText',texxt)
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธุชู ุชุบููุฑ ูููุดุฉ ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู', 1, 'md')
end
if text and text:match("^โคฝ ุชุบูุฑ ูููุดู ุงูุงุดุชุฑุงู โ$") and Sudo(msg)  or text and text:match("^ุชุบููุฑ ูููุดู ุงูุงุดุชุฑุงู$") and Sudo(msg) then  
DevRio:setex(storm.."textch:user"..msg.chat_id_.."" .. msg.sender_user_id_, 300, true)   
local text = 'โ๏ธุญุณูุง ุงุฑุณู ูููุดุฉ ุงูุงุดุชุฑุงู ุงูุฌุฏูุฏู'  
Dev_Rio(msg.chat_id_, msg.id_, 1,text, 1, 'md') 
end
if text == "ุญุฐู ูููุดู ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู" or text == "โคฝ ุญุฐู ูููุดู ุงูุงุดุชุฑุงู โ" then  
if not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท ', 1, 'md')
else
DevRio:del(storm..'Rio:ChText')
textt = "โ๏ธุชู ุญุฐู ูููุดุฉ ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู"
Dev_Rio(msg.chat_id_, msg.id_, 1,textt, 1, 'md') 
end end
if text == 'ูููุดู ุงูุงุดุชุฑุงู' or text == 'ุฌูุจ ูููุดู ุงูุงุดุชุฑุงู' or text == 'โคฝ ูููุดู ุงูุงุดุชุฑุงู โ' then
if not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท ', 1, 'md')
else
local chtext = DevRio:get(storm.."Rio:ChText")
if chtext then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุดุฉ ุงูุงุดุชุฑุงู โคฝ โค \nโ โ โ โ โ โ โ โ โ\n['..chtext..']', 1, 'md')
else
if DevRio:get(storm.."Rio:ChId") then
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..DevRio:get(storm.."Rio:ChId"))
local GetInfo = JSON.decode(Check)
if GetInfo.result.username then
User = "https://t.me/"..GetInfo.result.username
else
User = GetInfo.result.invite_link
end
Text = "*โ๏ธุนุฐุฑุง ูุงุชุณุชุทูุน ุงุณุชุฎุฏุงู ุงูุจูุช !\nโ๏ธุนููู ุงูุงุดุชุฑุงู ูู ุงูููุงุฉ ุงููุง :*"
keyboard = {} 
keyboard.inline_keyboard = {{{text=GetInfo.result.title,url=User}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูู ูุชู ุชุนููู ููุงุฉ ุงูุงุดุชุฑุงู ุงูุงุฌุจุงุฑู \nโ๏ธุงุฑุณู โคฝ ุชุนููู ููุงุฉ ุงูุงุดุชุฑุงู ููุชุนููู ', 1, 'md')
end end end end
--     Source Storm     --
if text == 'ุงูููุงุฉ' and ChCheck(msg) or text == 'ููุงุฉ ุงูุณูุฑุณ' and ChCheck(msg) or text == 'ููุงู ุงูุณูุฑุณ' and ChCheck(msg) or text == 'ููุงุช ุงูุณูุฑุณ' and ChCheck(msg) or text == 'โคฝ ููุงุฉ ุงูุณูุฑุณ โ' and ChCheck(msg) then 
Text = [[
โ๏ธ[ููุงุฉ ุงูุณูุฑุณ](https://t.me/So_ST0RM)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'โ ููุงุฉ ุงูุณูุฑุณ',url="t.me/So_ST0RM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/So_ST0RM&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
--     Source Storm     --
if text == "ูุจุฑูุฌ ุงูุณูุฑุณ" and ChCheck(msg) or text == "ูุทูุฑ ุงูุณูุฑุณ" and ChCheck(msg) or text == "ุจูุฏู" and ChCheck(msg) or text == "ุงููุจุฑูุฌ" and ChCheck(msg) then 
Text = [[
โ๏ธ[ูุจุฑูุฌ ุงูุณูุฑุณ](https://t.me/Xx_BoDa_UXB)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'โ ูุจุฑูุฌ ุงูุณูุฑุณ',url="t.me/Xx_BoDa_UXB"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Xx_BoDa_UXB&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end

if text == "ูุจุฑูุฌ ุงุจู ุงููุฌุฏ" and ChCheck(msg) or text == "ูุทูุฑ ุงุจู ุงููุฌุฏ" and ChCheck(msg) or text == "ุณูุฑุงู" and ChCheck(msg) or text == "ูุชูุฑ" and ChCheck(msg) then 
Text = [[
โ๏ธ[ูุจุฑูุฌ ุงูุณูุฑุณ](https://t.me/A_B_O_2)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'โ ูุจุฑูุฌ ุงูุณูุฑุณ',url="t.me/@A_B_O_2"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/A_B_O_2&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end

if text == "ูุทูุฑ ุงุญูุฏ" and ChCheck(msg) or text == "ูุจุฑูุฌ ุงุญูุฏ" and ChCheck(msg) or text == "ุงุญูุฏ" and ChCheck(msg) then 
Text = [[
โ๏ธ[ูุจุฑูุฌ ุงูุณูุฑุณ](https://t.me/A7maaaaaaaaaaaaaaa)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'โ ูุจุฑูุฌ ุงูุณูุฑุณ',url="t.me/@A7maaaaaaaaaaaaaaa"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/A7maaaaaaaaaaaaaaa&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
--     Source Storm     --
if text == 'ูุนูููุงุช ุงูุณูุฑูุฑ' or text == 'ุงูุณูุฑูุฑ' or text == 'โคฝ ุงูุณูุฑูุฑ โ' then 
if not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'โ๏ธูููุทูุฑ ุงูุงุณุงุณู ููุท ', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, io.popen([[
LinuxVersion=`lsb_release -ds`
MemoryUsage=`free -m | awk 'NR==2{printf "%s/%sMB {%.2f%%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
Percentage=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
UpTime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes"}'`
echo 'โ๏ธูุธุงู ุงูุชุดุบูู โคฝ โค\n`'"$LinuxVersion"'`' 
echo 'โ โ โ โ โ โ โ โ โ\nโ๏ธุงูุฐุงูุฑู ุงูุนุดูุงุฆูู โคฝ โค\n`'"$MemoryUsage"'`'
echo 'โ โ โ โ โ โ โ โ โ\nโ๏ธูุญุฏุฉ ุงูุชุฎุฒูู โคฝ โค\n`'"$HardDisk"'`'
echo 'โ โ โ โ โ โ โ โ โ\nโ๏ธุงููุนุงูุฌ โคฝ โค\n`'"`grep -c processor /proc/cpuinfo`""Core ~ {$Percentage%} "'`'
echo 'โ โ โ โ โ โ โ โ โ\nโ๏ธุงูุฏุฎูู โคฝ โค\n`'`whoami`'`'
echo 'โ โ โ โ โ โ โ โ โ\nโ๏ธูุฏุฉ ุชุดุบูู ุงูุณูุฑูุฑ โคฝ โค\n`'"$UpTime"'`'
]]):read('*a'), 1, 'md')
end
end
--     Source Storm     --
stormFiles(msg)
--     Source Storm     --
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
DevRio:incr(storm..'Rio:EditMsg'..result.chat_id_..result.sender_user_id_)
local text = result.content_.text_ or result.content_.caption_
local Text = result.content_.text_
if DevRio:get(storm..'Rio:Lock:EditMsgs'..msg.chat_id_) and not Text and not SecondSudo(result) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_})
Media = 'ุงูููุฏูุง'
if result.content_.ID == "MessagePhoto" then Media = 'ุงูุตูุฑู'
elseif result.content_.ID == "MessageSticker" then Media = 'ุงูููุตู'
elseif result.content_.ID == "MessageVoice" then Media = 'ุงูุจุตูู'
elseif result.content_.ID == "MessageAudio" then Media = 'ุงูุตูุช'
elseif result.content_.ID == "MessageVideo" then Media = 'ุงูููุฏูู'
elseif result.content_.ID == "MessageAnimation" then Media = 'ุงููุชุญุฑูู'
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,dp) 
local rioname = 'โ๏ธุงูุนุถู โคฝ ['..dp.first_name_..'](tg://user?id='..dp.id_..')'
local rioid = 'โ๏ธุงูุฏูู โคฝ `'..dp.id_..'`'
local riotext = 'โ๏ธูุงู ุจุงูุชุนุฏูู ุนูู '..Media
local riotxt = 'โ โ โ โ โ โ โ โ โ\nโ๏ธุชุนุงูู ูุงูุดุฑููู ุงูู ูุฎุฑุจ'
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,rio) 
local admins = rio.members_  
text = '\nโ โ โ โ โ โ โ โ โ\n'
for i=0 , #admins do 
if not rio.members_[i].bot_info_ then
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,data) 
if data.first_name_ ~= false then
text = text.."~ [@"..data.username_.."]\n"
end
if #admins == i then 
SendText(msg.chat_id_, rioname..'\n'..rioid..'\n'..riotext..text..riotxt,0,'md') 
end
end,nil)
end
end
end,nil)
end,nil)
end
if not VipMem(result) then
Filters(result, text)
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") or text:match("#") or text:match("@") or text:match("[Hh][Tt][Tt][Pp][Ss]://") or text:match("[Hh][Tt][Tt][Pp]://") or text:match(".[Cc][Oo][Mm]") or text:match(".[Oo][Rr][Gg]") or text:match("[Ww][Ww][Ww].") or text:match(".[Xx][Yy][Zz]") then
if DevRio:get(storm..'Rio:Lock:EditMsgs'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_})
end end end 
end,nil)
--     Source Storm     --
elseif (data.ID == "UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local GetMsgPin = DevRio:get(storm..'Rio:PinnedMsgs'..msg.chat_id_)
if GetMsgPin ~= nil then
if text == GetMsgPin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,dp) if dp.ID == 'Ok' then;DevRio:del(storm..'Rio:PinnedMsgs'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if GetMsgPin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,dp) DevRio:del(storm..'Rio:PinnedMsgs'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == GetMsgPin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,dp) DevRio:del(storm..'Rio:PinnedMsgs'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == GetMsgPin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,dp) DevRio:del(storm..'Rio:PinnedMsgs'..msg.chat_id_) end,nil)   
end end end
--     Source Storm     --
elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
print('\27[30;32mุฌุงุฑู ุชูุธูู ุงููุฌููุนุงุช ุงูููููู ูุฑุฌู ุงูุงูุชุธุงุฑ\n\27[1;37m')
local PvList = DevRio:smembers(storm..'Rio:Users')  
for k,v in pairs(PvList) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end 
local GpList = DevRio:smembers(storm..'Rio:Groups') 
for k,v in pairs(GpList) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
tdcli_function({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=storm,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
DevRio:srem(storm..'Rio:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
DevRio:srem(storm..'Rio:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
DevRio:srem(storm..'Rio:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
DevRio:srem(storm..'Rio:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
DevRio:sadd(storm..'Rio:Groups',v)  
end end,nil) end
end
--     Source Storm     --
end 
------------------------------------------------
-- This Source Was Developed By BODY
--   This Is The ๐ง๐๐๐  ๐ฆ๐ง๐ข๐ฅ๐  โค  @Xx_BoDa_UXB .   --
--                - storm -                 --
--        -- https://t.me/So_ST0RM --         --
------------------------------------------------   
