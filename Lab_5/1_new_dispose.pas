program prt_demo;
{$APPTYPE CONSOLE}

uses
    SysUtils;

var
	i_ptr : ^integer;
begin
    writeln(format('Address: %p Value: %u', [i_ptr, i_ptr^]));
    
    i_ptr^ := 87;
    writeln(format('Address: %p Value: %u', [i_ptr, i_ptr^]));

	New(i_ptr);
    writeln(format('Address: %p Value: %u', [i_ptr, i_ptr^]));

	Dispose(i_ptr);
    writeln(format('Address: %p Value: %u', [i_ptr, i_ptr^]));

    i_ptr^ := 88;
    writeln(format('Address: %p Value: %u', [i_ptr, i_ptr^]));

    i_ptr := nil;
    writeln(format('Address: %p Value: ---', [i_ptr]));

    readln;
end.
