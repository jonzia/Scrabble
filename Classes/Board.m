classdef Board
    
    % Class Properties (public)
    properties (SetAccess = public, GetAccess = public)
        numPlayers  % Number of non-computer players
        tiles       % Remaining number of each tile in bank (A-Z + blank)
        characters  % Playable characters (A-Z)
    end
    
    % Class Methods (public)
    methods (Access = public)
        
        % Class Constructor
        function obj = Board(numPlayers)
            
            % Set number of non-computer players
            obj.numPlayers = numPlayers;
            
            % Initialize cell array of tiles
            % A = 9, B = 2, C = 2, D = 4, E = 12, F = 2, G = 3, H = 2, I =
            % 9, J = 1, K = 1, L = 4, M = 2, N = 6, O = 8, P = 2, Q = 1, R
            % = 6, S = 4, T = 6, U = 4, V = 2, W = 2, X = 1, Y = 2, Z = 1,
            % BLANK = 2
            obj.tiles = zeros(27, 1);
            obj.tiles([10, 11, 17, 24, 26]) = 1;
            obj.tiles([2, 3, 6, 8, 13, 16, 22, 23, 25, 27]) = 2;
            obj.tiles(7) = 3;
            obj.tiles([4, 12, 19, 21]) = 4;
            obj.tiles([14, 18, 20]) = 6;
            obj.tiles(15) = 8;
            obj.tiles([1, 9]) = 9;
            obj.tiles(5) = 12;
            
            % Initialize character list
            obj.characters = 'a':'z';
            
        end
        
    end
    
end