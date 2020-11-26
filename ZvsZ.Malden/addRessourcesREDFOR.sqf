waitUntil { redfor_res_factor > 0 };

while {true} do {
_additionalRes = 0.1 * redfor_res_factor;
zeus_2 addCuratorPoints _additionalRes;

_sleep = 240 / redfor_res_factor;

sleep _sleep;
};