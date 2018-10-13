_Sample = param[0];

_Ret = "";

if (_Data isEqualType 0) then
{
    _Ret = "BIGINT(20)";
}
else
{
    _Ret = "MEDIUMTEXT";
};
_Ret