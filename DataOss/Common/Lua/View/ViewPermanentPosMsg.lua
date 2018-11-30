-- Copyright(c) Cragon. All rights reserved.
-- 屏幕中间悬停一段时间的提示框

---------------------------------------
ViewPermanentPosMsg = class(ViewBase)

---------------------------------------
function ViewPermanentPosMsg:ctor()
    self.CasinosContext = CS.Casinos.CasinosContext.Instance
    self.TimerUpdate = nil
end

---------------------------------------
function ViewPermanentPosMsg:OnCreate()
    local text = self.ComUi:GetChild("MsgText")
    if (text ~= nil) then
        self.GTextMsg = text.asTextField
    end

    self.AutoDestroyTm = 3
    self.Tm = 0
    self.ComUi.touchable = false

    self.TimerUpdate = self.CasinosContext.TimerShaft:RegisterTimer(200, self, self._timerUpdate)
end

---------------------------------------
function ViewPermanentPosMsg:OnDestroy()
    if (self.TimerUpdate ~= nil) then
        self.TimerUpdate:Close()
        self.TimerUpdate = nil
    end
end

---------------------------------------
function ViewPermanentPosMsg:OnHandleEv(ev)
end

---------------------------------------
function ViewPermanentPosMsg:_timerUpdate(tm)
    self.Tm = self.Tm + tm
    if (self.Tm >= self.AutoDestroyTm) then
        self.ViewMgr:DestroyView(self)
    end
end

---------------------------------------
function ViewPermanentPosMsg:showInfo(info)
    self.GTextMsg.text = info
end

---------------------------------------
ViewPermanentPosMsgFactory = class(ViewFactory)

---------------------------------------
function ViewPermanentPosMsgFactory:CreateView()
    local view = ViewPermanentPosMsg:new()
    return view
end