program sort_for_vec3_type;
{$APPTYPE CONSOLE}
uses
  usort_lib in 'usort_lib.pas';


// ------------------------------VEC3---------------------------------------
type
	vec3 = record
		x, y, z : real;
	end;

function create_random_vec3() : vec3;
begin
    create_random_vec3.x := random*10;
    create_random_vec3.y := random*10;
    create_random_vec3.z := random*10;
end;

function vec3_norm(a : vec3) : real;
begin
    vec3_norm := sqrt(a.x*a.x + a.y*a.y + a.z*a.z);
end;

procedure print_vec3(a : vec3);
begin
    writeln('(', a.x:4:2, ', ', a.y:4:2, ', ', a.z:4:2, ') ',
			'|', vec3_norm(a):4:2, '|');
end;

procedure print_vec3_array(arr : array of vec3);
var
    i : integer;
begin
    for i := low(arr) to high(arr) do
        print_vec3(arr[i]);
    writeln;
end;

// VEC3 comparator function!
function comp_vec3(a, b : pointer) : boolean;
type
    vec3_ptr = ^vec3;
begin
    // 1) typecast to vec3 pointer : vec3_ptr(a)
    // 2) dereference : vec3_ptr(a)^
    // 3) get norm of vec : vec3_norm(vec3_ptr(a)^)
    // 4) compare : >
    comp_vec3 := vec3_norm(vec3_ptr(a)^) > vec3_norm(vec3_ptr(b)^);
end;

// ------------------------------INT---------------------------------------
procedure print_int_array(arr : array of integer);
var
    i : integer;
begin
    for i := low(arr) to high(arr) do
        writeln(arr[i]);
    writeln;
end;

// INTEGER comparator function!
function comp_int(a, b : pointer) : boolean;
type
    int_ptr = ^integer;
begin
    // 1) typecast to integer pointer
    // 2) dereference
    // 3) compare
    comp_int := int_ptr(a)^ > int_ptr(b)^;
end;


// -----------------------------MAIN---------------------------------------
var
    i, N : integer;
	  vec_arr : array of vec3;
    int_arr : array of integer;
begin
    randomize;

    // init vec3 and int arrays
    N := 10;
    setlength(vec_arr, N);
    for i := low(vec_arr) to high(vec_arr) do begin
        vec_arr[i] := create_random_vec3;
    end;
    
    setlength(int_arr, N);
    for i := low(int_arr) to high(int_arr) do begin
        int_arr[i] := random(100);
    end;

    // sort and print vec3 array
    print_vec3_array(vec_arr);
    sort(pointer(vec_arr), length(vec_arr), sizeof(vec3), comp_vec3);
    print_vec3_array(vec_arr);

    // sort and print int array
    print_int_array(int_arr);
    sort(pointer(int_arr), length(int_arr), sizeof(integer), comp_int);
    print_int_array(int_arr);

    writeln('READY!');
    readln;
end.
