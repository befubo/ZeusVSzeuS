waitUntil { globalVars getVariable "blufor_res_factor" > 0 };

while {true} do {
_additionalRes = 0.05 * globalVars getVariable "blufor_res_factor";
zeus_1 addCuratorPoints _additionalRes;

_sleep = 240 / globalVars getVariable "blufor_res_factor";

sleep _sleep;
};