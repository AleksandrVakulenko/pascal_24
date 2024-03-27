program new_try;
{$APPTYPE CONSOLE}

const
    N = 256;
type
	Array_of_int = array[0..99] of integer;
	I_ptr = ^Array_of_int;

var
	ptr : I_ptr;
	i: integer;
begin
	New(ptr);

	for i := 0 to 99 do begin
		ptr^[i] := i*i;
	end;
		
	Dispose(ptr);
	readln;
end.
