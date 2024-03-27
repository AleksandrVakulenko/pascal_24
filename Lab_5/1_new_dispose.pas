program new_try;
{$APPTYPE CONSOLE}

var
	i_ptr : ^integer;
begin
	New(i_ptr);
	writeln(format('Address: %p', [i_ptr]));
	Dispose(i_ptr[i]);
end.
