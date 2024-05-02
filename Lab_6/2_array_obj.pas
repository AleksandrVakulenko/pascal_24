Program Example;
{$APPTYPE CONSOLE}

const
    size : integer = 131072000;
    
type

    arr500mb = array [0..131072000] of integer; //500 MBytes
    
    Array_obj = object
    private
        data : ^arr500mb;
    public
        constructor create(init_v : integer);
		destructor del();
        procedure set_data(arg : integer);
		function get_data() : integer;
    end;


constructor Array_obj.create(init_v : integer);
    var
        i : integer;
    begin
        new(data);
        for i := 0 to size do
            data[i] := init_v;
		writeln('constructor(int): init data');
    end;


destructor Array_obj.del();
	begin
        dispose(data);
		writeln('distructor: dispose data');
	end;


procedure Array_obj.set_data(arg : integer);
    var
        i : integer;
	begin
        for i := 0 to size do
            data[i] := arg;
	end;


function Array_obj.get_data() : integer;
    var
        i : integer;
	begin
		for i := 0 to 5 do
            writeln(data[i], ' ');
        writeln;
	end;

    

procedure foo();
    var
        temp : Array_obj;
    begin
        temp.create(144);
        writeln(temp.get_data);
    end;

	
var
    Array_obj1, Array_obj2 : Array_obj;
    ptr_c : ^Array_obj;
	
Begin
    
    //foo;
    
    writeln;
    
    Array_obj1.create(8);
    
	//Array_obj1.set_data(9);
	
	//writeln('origin: ', Array_obj1.get_data);
    //Array_obj2 := Array_obj1;
    //writeln('copy: ', Array_obj2.get_data);
	
	//Array_obj1.del;
    
    //writeln;

	//New(ptr_c, create(8));
	//writeln(ptr_c^.get_data);
	//dispose(ptr_c, del);
End.






