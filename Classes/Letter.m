classdef Letter
    enumeration
        a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, blank, null
    end
    methods
        % Return information about the letter
        % Data.quantity     Int     Starting quantity of this letter
        % Data.value        Int     Value of this letter
        % Data.isvowel      Bool    Whether the letter is a vowel
        function output = info(obj, data)
            switch obj
                case Letter.a
                    % Quantity 9, value 1, is vowel
                    output = formatData(9, 1, true, data);
                case Letter.b
                    % Quantity 2, value 3, not vowel
                    output = formatData(2, 3, false, data);
                case Letter.c
                    % Quantity 2, value 3, not vowel
                    output = formatData(2, 3, false, data);
                case Letter.d
                    % Quantity 4, value 2, not vowel
                    output = formatData(4, 2, false, data);
                case Letter.e
                    % Quantity 12, value 1, is vowel
                    output = formatData(12, 1, true, data);
                case Letter.f
                    % Quantity 2, value 4, not vowel
                    output = formatData(2, 4, false, data);
                case Letter.g
                    % Quantity 3, value 2, not vowel
                    output = formatData(3, 2, false, data);
                case Letter.h
                    % Quantity 2, value 4, not vowel
                    output = formatData(2, 4, false, data);
                case Letter.i
                    % Quantity 9, value 1, is vowel
                    output = formatData(9, 1, true, data);
                case Letter.j
                    % Quantity 1, value 8, not vowel
                    output = formatData(1, 8, false, data);
                case Letter.k
                    % Quantity 1, value 5, not vowel
                    output = formatData(1, 5, false, data);
                case Letter.l
                    % Quantity 4, value 1, not vowel
                    output = formatData(4, 1, false, data);
                case Letter.m
                    % Quantity 2, value 3, not vowel
                    output = formatData(2, 3, false, data);
                case Letter.n
                    % Quantity 2, value 3, not vowel
                    output = formatData(6, 1, false, data);
                case Letter.o
                    % Quantity 8, value 1, is vowel
                    output = formatData(8, 1, true, data);
                case Letter.p
                    % Quantity 2, value 3, not vowel
                    output = formatData(2, 3, false, data);
                case Letter.q
                    % Quantity 1, value 10, not vowel
                    output = formatData(1, 10, false, data);
                case Letter.r
                    % Quantity 6, value 1, not vowel
                    output = formatData(6, 1, false, data);
                case Letter.s
                    % Quantity 4, value 1, not vowel
                    output = formatData(4, 1, false, data);
                case Letter.t
                    % Quantity 6, value 1, not vowel
                    output = formatData(6, 1, false, data);
                case Letter.u
                    % Quantity 4, value 1, is vowel
                    output = formatData(4, 1, true, data);
                case Letter.v
                    % Quantity 2, value 4, not vowel
                    output = formatData(2, 4, false, data);
                case Letter.w
                    % Quantity 2, value 4, not vowel
                    output = formatData(2, 4, false, data);
                case Letter.x
                    % Quantity 1, value 8, not vowel
                    output = formatData(1, 8, false, data);
                case Letter.y
                    % Quantity 2, value 4, not vowel
                    output = formatData(2, 4, false, data);
                case Letter.z
                    % Quantity 1, value 10, not vowel
                    output = formatData(1, 10, false, data);
                case Letter.blank
                    % BLANK TILE
                    % Quantity 2, value 0, not vowel
                    output = formatData(2, 0, false, data);
                otherwise
                    % NULL VALUE
                    % Quantity 225, value 0, not vowel
                    output = formatData(225, 0, false, data);
            end
            
            % -------------------------------------------------------------
            % Accessory function for returning letter information
            function output = formatData(quantity, value, isVowel, data)
                switch data
                    case Data.quantity
                        output = quantity;
                    case Data.value
                        output = value;
                    otherwise
                        output = isVowel;
                end
            end
            % -------------------------------------------------------------
            
        end
        
    end
end