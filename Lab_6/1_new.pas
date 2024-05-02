Program Example;
{$APPTYPE CONSOLE}

const
	size = 500*1024*1024; // 500 MBytes

type
    arr500mb = array [0..524288000] of byte;

var
    ptr : ^arr500mb;
    i, j : integer;

Begin

    New(ptr);


    //for i := 0 to 524288000 do begin
    //ptr[i] := i;
    //end;

    writeln('created');
    readln;

    dispose(ptr);
    writeln('deleted');

    readln;
End.






