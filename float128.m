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
    methods
        function obj = float128(valp)
            obj.Value = valp;
        end
        function delete(obj)
            calllib('f128', 'destroy', obj.Value);
        end
        
        function r = plus(obj1, obj2)
            r = float128(calllib('f128', 'plus', obj1.Value, obj2.Value));
        end
        function r = minus(obj1, obj2)
            r = float128(calllib('f128', 'minus', obj1.Value, obj2.Value));
        end
        function r = times(obj1, obj2)
            r = float128(calllib('f128', 'times', obj1.Value, obj2.Value));
        end
        function r = uminus(obj)
            r = float128(calllib('f128', 'uminus', obj.Value));
        end
        function r = rdivide(obj1, obj2)
            r = float128(calllib('f128', 'rdivide', obj1.Value, obj2.Value));
        end
        function r = power(obj1, obj2)
            r = float128(calllib('f128', 'power', obj1.Value, obj2.Value));
        end
        
        function r = lt(obj1, obj2)
            r = boolean(calllib('f128', 'lt', obj1.Value, obj2.Value));
        end
        function r = gt(obj1, obj2)
            r = boolean(calllib('f128', 'gt', obj1.Value, obj2.Value));
        end
        function r = le(obj1, obj2)
            r = boolean(calllib('f128', 'le', obj1.Value, obj2.Value));
        end
        function r = ge(obj1, obj2)
            r = boolean(calllib('f128', 'ge', obj1.Value, obj2.Value));
        end
        function r = ne(obj1, obj2)
            r = boolean(calllib('f128', 'ne', obj1.Value, obj2.Value));
        end
        function r = eq(obj1, obj2)
            r = boolean(calllib('f128', 'eq', obj1.Value, obj2.Value));
        end
        
        function r = sin(obj1)
            r = float128(calllib('f128', 'fsin', obj1.Value));
        end
        function r = sqrt(obj)
            r = float128(calllib('f128', 'fsqrt', obj.Value));
        end
        
        function d = double(obj)
            d = calllib('f128', 'get', obj.Value);
        end
        function f = float(obj)
            f = calllib('f128', 'gfloat', obj.Value);
        end
        function s = single(obj)
            s = calllib('f128', 'gfloat', obj.Value);
        end
        function d = get(obj)
            d = calllib('f128', 'get', obj.Value);
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