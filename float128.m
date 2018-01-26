classdef float128
    %FLOAT128 128 bit floating point numbers
    %   A class for 128 bit floating point numbers (aka quad floats)
    %   Uses GCC's libquadmath. Nearly every function is simply a call
    %   to a C function via calllib
    %
    %   TODO:
    %       - Add more functions (see
    %       https://gcc.gnu.org/onlinedocs/libquadmath/Math-Library-Routines.html)
    %       - Check for memory leaks in the C part
    %       - Unit test (including minimal correctness checks)
    %       - Performance tests
    
    properties
        Value
    end
    
    methods(Static)
        function init()
            if not(libisloaded('f128'))
                [notFound, warnings] = loadlibrary('f128.so', 'f128.h');
                assert(isempty(notFound), 'could not load f128 lib')
            end
        end
        function reload()
            if libisloaded('f128')
                unloadlibrary('f128')
            end
            if not(libisloaded('f128'))
                [notFound, warnings] = loadlibrary('f128.so', 'f128.h');
                assert(isempty(notFound), 'could not load f128 lib')
            end
        end
        function obj = make(val)
            p = calllib('f128', 'make', val);
            obj = float128(p);
        end
        function obj = fromstr(val)
            p = calllib('f128', 'fromstr', val);
            obj = float128(p);
        end
        function obj = e()
            p = calllib('f128', 'make_e');
            obj = float128(p);
        end
        function obj = pi()
            p = calllib('f128', 'make_pi');
            obj = float128(p);
        end
    end
    methods(Access=private)
        function ret = do_element_operation(obj1, obj2, method)
            [rows, cols] = size(obj1);
            for r = 1:rows
                for c = 1:cols
                    ret(r,c) = float128(calllib('f128', method, obj1(r,c).Value, obj2(r,c).Value));
                end
            end
        end
        function ret = do_bool_element_operation(obj1, obj2, method)
            [rows, cols] = size(obj1);
            for r = 1:rows
                for c = 1:cols
                    ret(r,c) = boolean(calllib('f128', method, obj1(r,c).Value, obj2(r,c).Value));
                end
            end
        end
        function ret = do_single_element_operation(obj, method)
            [rows, cols] = size(obj);
            for r = 1:rows
                for c = 1:cols
                    ret(r,c) = float128(calllib('f128', method, obj(r,c).Value));
                end
            end
        end
        function ret = do_noconvert_element_operation(obj, method)
            [rows, cols] = size(obj);
            for r = 1:rows
                for c = 1:cols
                    ret(r,c) = calllib('f128', method, obj(r,c).Value);
                end
            end
        end
    end
    methods
        function obj = float128(valp)
            obj.Value = valp;
        end
        function delete(obj)
            calllib('f128', 'destroy', obj.Value);
        end
        
        function r = plus(obj1, obj2)
            r = do_element_operation(obj1, obj2, 'plus');
        end
        function r = minus(obj1, obj2)
            r = do_element_operation(obj1, obj2, 'minus');
        end
        function r = times(obj1, obj2)
            r = do_element_operation(obj1, obj2, 'times');
        end
        function r = uminus(obj)
            minus_one = float128.make(-1);
            [rows, cols] = size(obj);
            for r = 1:rows
                for c = 1:cols
                    obj2(r,c) = minus_one;
                end
            end
            r = do_element_operation(obj, obj2, 'times');
        end
        function r = rdivide(obj1, obj2)
            r = do_element_operation(obj1, obj2, 'rdivide');
        end
        function r = power(obj1, obj2)
            r = do_element_operation(obj1, obj2, 'power');
        end
        function r = lt(obj1, obj2)
            r = do_bool_element_operation(obj1, obj2, 'lt');
        end
        function r = gt(obj1, obj2)
            r = do_bool_element_operation(obj1, obj2, 'gt');
        end
        function r = le(obj1, obj2)
            r = do_bool_element_operation(obj1, obj2, 'le');
        end
        function r = ge(obj1, obj2)
            r = do_bool_element_operation(obj1, obj2, 'ge');
        end
        function r = ne(obj1, obj2)
            r = do_bool_element_operation(obj1, obj2, 'ne');
        end
        function r = eq(obj1, obj2)
            r = do_bool_element_operation(obj1, obj2, 'eq');
        end
        
        function r = sin(obj1)
            r = do_single_element_operation(obj1, 'fsin');
        end
        function r = sqrt(obj)
            r = do_single_element_operation(obj, 'fsqrt');
        end
        
        function d = double(obj)
            d = do_noconvert_element_operation(obj, 'get');
        end
        function f = float(obj)
            f = do_noconvert_element_operation(obj, 'gloat');
        end
        function s = single(obj)
            s = do_noconvert_element_operation(obj, 'gloat');
        end
        function d = get(obj)
            d = do_noconvert_element_operation(obj, 'get');
        end
        
        function disp(obj)
            [rows, cols] = size(obj);
            for r = 1:rows
                for c = 1:cols
                    fprintf("    %s", calllib('f128', 'disp', obj(r,c).Value));
                end
                fprintf("\n");
            end
        end
    end
    
end