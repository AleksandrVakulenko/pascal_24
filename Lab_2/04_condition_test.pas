program condition_test;
{$APPTYPE CONSOLE}

// These functions return True/False 
// and print messages while executing.
function cond_1(arg:integer) : Boolean;
begin
	writeln('Cond_1');
	cond_1 := arg < 10;
end;

function cond_2(arg:integer) : Boolean;
begin
	writeln('Cond_2');
	cond_2 := arg > 0;
end;


var
	i : integer;
	Arr : array of real;

begin
	i := 11;
	writeln(cond_1(i));
	writeln(cond_2(i));
	writeln;
	
	writeln(cond_1(i) and cond_2(i));
	writeln;
	
	writeln(cond_2(i) or cond_1(i));
	writeln;
		
	setlength(Arr, 10);
	writeln(Length(Arr));
	i := 7;
	
	if (i < Length(Arr)) and (Arr[i] = 0.67) then 
		writeln('OK')
	else
		writeln('Not OK');
	
	readln;
end.