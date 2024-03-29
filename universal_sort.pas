program sort_test;
{$APPTYPE CONSOLE}

uses
    SysUtils;

// -----------------------------------------------------------------------------
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
    for i := 0 to size do
        swap_bytes(p_add(a, i), p_add(b, i));
end;

// slow (n^2) SORT an array of elements
// ptr - pointer to first element
// size : number of elements
// el_sz : element size in bytes
// comp_foo : comparator function
procedure sort(ptr : pointer; size : integer; el_sz : integer; comp : comp_foo);
var
    i, j : integer;
    elem_1, elem_2, max_el : pointer;
begin
    for i := 0 to size-2 do begin
        elem_1 := get_el(ptr, i, el_sz);
        max_el := elem_1;
        for j := i+1 to size-1 do begin
            elem_2 := get_el(ptr, j, el_sz);
            if comp(elem_2, max_el) then begin
                max_el := elem_2;
            end;
        end;
        swap_bytes_array(elem_1, max_el, el_sz);
    end;
end;

// -----------------------------------------------------------------------------


procedure print_array(arr : array of integer);
var
    i : integer;
begin
    for i := low(arr) to high(arr) do
        writeln(arr[i]);
    writeln;
end;

function comp_int(a, b : pointer) : boolean;
type
    int_ptr = ^integer;
begin
    //writeln(int_ptr(a)^, ' ', int_ptr(b)^);
    comp_int := int_ptr(a)^ > int_ptr(b)^;
end;


var
    my_arr : array of integer;
    i, N : integer;
begin

    N := 15;
    setlength(my_arr, N);

    for i := 0 to high(my_arr) do
        my_arr[i] := random(100);

    print_array(my_arr);

    sort(pointer(my_arr), N, sizeof(my_arr[0]), comp_int);

    print_array(my_arr);

    readln;
end.
