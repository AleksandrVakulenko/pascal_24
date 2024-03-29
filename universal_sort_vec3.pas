program sort_for_vec3_type;
{$APPTYPE CONSOLE}

uses
    SysUtils;

// -----------------------------------------------------------------------------
// --------------------universal sort code--------------------------------------
// comparator type
type
    comp_foo = function(a, b : pointer) : boolean;

// adds i(int) to pointer
function p_add(p : pointer; i : integer) : pointer;
    begin
        p_add := pointer(integer(p) + i);
    end;

// calculates address of i-th element (with size [el_sz])
function get_el(origin : pointer; i, el_sz : integer) : pointer;
    begin
        get_el := p_add(origin, el_sz*i);
    end;

// swaps single pair of bytes, refered by pointers a, b
procedure swap_bytes(a, b : pointer);
type
    char_ptr = ^char;
var
    tmp : char;
begin
    tmp := char_ptr(a)^;
    char_ptr(a)^ := char_ptr(b)^;
    char_ptr(b)^ := tmp;
end;

// swaps array [size] of bytes pairs, refered by pointers a, b
procedure swap_bytes_array(a, b : pointer; size : integer);
var
    i : integer;
begin
    for i := 0 to size-1 do
        swap_bytes(p_add(a, i), p_add(b, i));
end;

// slow (n^2) SORT an array of elements
// ptr - pointer to first element
// size : number of elements
// el_sz : element size in bytes
// comp_foo : comparator function
procedure sort(ptr : pointer; size : integer; el_sz : integer; comp : comp_foo);
var
    k, j : integer;
    elem_k, elem_j, elem_max : pointer;
begin
    for k := 0 to size-2 do begin
        elem_k := get_el(ptr, k, el_sz);
        elem_max := elem_k;
        for j := k+1 to size-1 do begin
            elem_j := get_el(ptr, j, el_sz);
            if comp(elem_j, elem_max) then begin
                elem_max := elem_j;
            end;
        end;
        swap_bytes_array(elem_k, elem_max, el_sz);
    end;
end;
// -----------------------------------------------------------------------------

// start of main code
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

// vec3 comparator function !
function comp_vec3(a, b : pointer) : boolean;
type
    vec3_ptr = ^vec3;
begin
    // 1) typecast to vec3 pointer : vec3_ptr(a)
    // 2) dereference : vec3_ptr(a)^
    // 3) get norm of vec : vec3_norm(vec3_ptr(a)^)
    // 4) compare ^ >
    comp_vec3 := vec3_norm(vec3_ptr(a)^) > vec3_norm(vec3_ptr(b)^);
end;


var
    i, N : integer;
	vec_arr : array of vec3;
begin
    randomize;

    N := 10;
    setlength(vec_arr, N);
    for i := low(vec_arr) to high(vec_arr) do
        vec_arr[i] := create_random_vec3;

    print_vec3_array(vec_arr);
    sort(pointer(vec_arr), N, sizeof(vec_arr[0]), comp_vec3);
    print_vec3_array(vec_arr);

    readln;
end.