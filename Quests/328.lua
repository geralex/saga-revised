-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:17 PM

local QuestID = 328;
local ReqClv = 6;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 83;
local RewCxp = 224;
local RewJxp = 91;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 16086;
local RewItemCount1 = 2;
local RewItemCount2 = 1;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	-- Initialize all quest steps
	-- Initialize all starting navigation points
	return 0;
end

function QUEST_FINISH(cid)
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	-- TODO: Add code to check all progress
	return -1;
end
