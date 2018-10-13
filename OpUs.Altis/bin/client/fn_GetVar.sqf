_Unit = param[0,objNull,[objNull]];
_Var  = param[1,"",[""]];

_Nat = _Unit getVariable "Nation";
_Arsenal = ((_Unit getVariable _Var) select {_Nat in _x}) param[0,[]] param[1,[]];

_Arsenal;