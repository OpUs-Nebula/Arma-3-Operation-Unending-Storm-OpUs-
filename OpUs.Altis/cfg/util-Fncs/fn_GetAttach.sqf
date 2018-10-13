_Acc = param[0,"",[""]];
_Ret = "";

switch (true) do
{
    case ((_Acc select [0,3]) == "acc"): {_Ret = 2;};
	case ((_Acc select [0,5]) == "bipod"): {_Ret = 5;};
	case ((_Acc select [0,5]) == "Optic"): {_Ret = 3;};
	case ((_Acc select [0,6]) == "muzzle"): {_Ret = 1;};
};

_Ret