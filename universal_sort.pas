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
    // 1) typecast to integer pointer
    // 2) dereference
    // 3) compare
    comp_int := int_ptr(a)^ > int_ptr(b)^;
end;


var
    my_arr : array of integer;
    i, N : integer;
begin

    N := 10;
    setlength(my_arr, N);

    for i := low(my_arr) to high(my_arr) do
        my_arr[i] := random(100);

    print_array(my_arr);

    sort(pointer(my_arr), N, sizeof(my_arr[0]), comp_int);

    print_array(my_arr);

    readln;
end.