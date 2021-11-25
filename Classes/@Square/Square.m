classdef Square
    
    % Class Properties (public)
    properties (SetAccess = public, GetAccess = public)
        row                 % Int       Row of square
        column              % Int       Column of square
        multiplier          % [Mult]    Square multiplier type
        letter              % Letter    Letter occupying square
    end
    
    % Class Methods (public)
    methods (Access = public)
        
        % Class Constructor
        function obj = Square(row, column, multiplier)
            
            % Set row and column for square (if error, assign input)
            obj.row = utils.assign("Square()", 1, row, 'double', row, [1,15]);
            obj.column = utils.assign("Square()", 2, column, 'double', column, [1,15]);
            
            % Set multiplier for square (if error, assign none)
            obj.multiplier = utils.assign("Square()", 2, multiplier, 'Mult', Mult.none);
            
        end
        
        % Add letter to tile
        function obj = addLetter(obj, letter)
            
            % Ensure that there is no letter currently in tile
            if ~isempty(obj.letter)
                disp("Error in Square.addLetter(): Square is not empty. Did not assign new letter to " + obj.name + ".");
            else
                % If there is no letter, assign new letter (if error,
                % assign old letter)
                obj.letter = utils.assign("Square.addLetter()", 1, letter, 'Letter', obj.letter);
            end
            
        end
        
    end
    
end