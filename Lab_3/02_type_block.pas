program foo_test;
{$APPTYPE CONSOLE}

type
	pair = array[0..1] of integer;


function swap(arg:pair) : pair;
	var 
		temp : pair;
	begin
		temp[0] := arg[1];
		temp[1] := arg[0];
		swap := temp;
	end;


var
	p : pair = (3, 6);
begin
	writeln(p[0], ' ', p[1]);
	p := swap(p);
	writeln(p[0], ' ', p[1]);
	
	readln;
end.












