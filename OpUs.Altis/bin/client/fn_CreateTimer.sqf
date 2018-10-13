

//timer = CountDown;

while {CountDown > -1} do {

//Hint str(CountDown);
    _hours = (CountDown  - (CountDown mod 3600))/3600; 
    _minutes = ((CountDown - CountDown mod 60) / 60) - (_hours * 60);
    _seconds = CountDown - ((_hours * 3600) + (_minutes * 60)); 

    switch (true) do {           
        Case(CountDown < 60): {Hint Format ["Time Left: %1Sec",_seconds]};
	    Case((CountDown < 3600) && (CountDown >= 60)): {Hint Format ["Time Left:%1Min %2Sec",_minutes,_seconds]};
	    Case(CountDown >= 3600): {Hint Format ["Time Left: %1Hr %2Min %3Sec",_hours,_minutes,_seconds]};
    };
 sleep 1;
};	