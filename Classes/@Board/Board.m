classdef Board
    
    % Class Properties (public)
    properties (SetAccess = public, GetAccess = public)
        numPlayers  % Int       Number of non-computer players
        tiles       % Table     Table with organized tile information (characters, quantity, value, etc.)
        scores      % [Int]     Vector with score for each player
        board       % {Square}  Board composed of cell array of squares
        grid        % [Dbl]     Grid containing data for visualizing board
        turnNo      % Int       Turn number
        turnPlayer  % Int       Active player
        A           % [Int]     Current adjacency matrix of the board
    end
    
    % Class Methods (public)
    methods (Access = public)
        
        % Class Constructor
        function obj = Board(numPlayers)
            
            % Set number of non-computer players (if error, default to 2)
            obj.numPlayers = utils.assign("Board()", 1, numPlayers, 'double', 2, [2,4]);
            
            % Initialize table of tile information
            character = enumeration('Letter');	% List of characters
            character(end) = [];                % Remove null value
            bank = zeros(27,1);                 % Tile quantities in bank
            obj.tiles = table(character, bank);
            
            % Populate initial tile quantities
            for i = 1:size(obj.tiles, 1)
                obj.tiles.bank(i) = obj.tiles.character(i).info(Data.quantity);
            end
            
            % For each player, append a column tracking current tiles
            for i = 1:obj.numPlayers
                temp = zeros(27, 1);    % Initialize empty list
                obj.tiles.("player" + string(i)) = temp;    % Add to table
            end
            
            % Dispense tiles to players from bank
            for i = 1:obj.numPlayers; obj = obj.dispense(i); end
            
            % Initialize scores
            obj.scores = zeros(obj.numPlayers, 1);
            
            % Construct board from squares
            % The board is represented as a table indexed by row and
            % column, and listing the row's multiplier and letter presently
            % on the tile (if any). Begin with the first row.
            obj.board = table(); counter = 0;
            for i = 1:15
                for j = 1:15
                    counter = counter + 1;
                    column = i; row = j; index = counter; multiplier = Mult.none; 
                    letter = Letter.null; temp = table(row, column, index, ...
                        multiplier, letter); obj.board = [obj.board; temp];
                end
            end
            
            % -------------------------------------------------------------
            % Fill in multipliers
            % -------------------------------------------------------------
            
            % Triple word scores
            obj.board.multiplier(obj.board.row == 1 & obj.board.column == 1) = Mult.tripleWord;
            obj.board.multiplier(obj.board.row == 1 & obj.board.column == 8) = Mult.tripleWord;
            obj.board.multiplier(obj.board.row == 1 & obj.board.column == 15) = Mult.tripleWord;
            obj.board.multiplier(obj.board.row == 8 & obj.board.column == 1) = Mult.tripleWord;
            obj.board.multiplier(obj.board.row == 8 & obj.board.column == 15) = Mult.tripleWord;
            obj.board.multiplier(obj.board.row == 15 & obj.board.column == 1) = Mult.tripleWord;
            obj.board.multiplier(obj.board.row == 15 & obj.board.column == 8) = Mult.tripleWord;
            obj.board.multiplier(obj.board.row == 15 & obj.board.column == 15) = Mult.tripleWord;
            
            % Double word scores
            obj.board.multiplier(obj.board.row == 2 & obj.board.column == 2) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 2 & obj.board.column == 14) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 3 & obj.board.column == 3) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 3 & obj.board.column == 13) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 4 & obj.board.column == 4) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 4 & obj.board.column == 12) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 5 & obj.board.column == 5) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 5 & obj.board.column == 11) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 11 & obj.board.column == 5) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 11 & obj.board.column == 11) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 12 & obj.board.column == 4) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 12 & obj.board.column == 12) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 13 & obj.board.column == 3) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 13 & obj.board.column == 13) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 14 & obj.board.column == 2) = Mult.doubleWord;
            obj.board.multiplier(obj.board.row == 14 & obj.board.column == 14) = Mult.doubleWord;
            
            % Triple letter scores
            obj.board.multiplier(obj.board.row == 2 & obj.board.column == 6) = Mult.tripleLetter;
            obj.board.multiplier(obj.board.row == 2 & obj.board.column == 10) = Mult.tripleLetter;
            obj.board.multiplier(obj.board.row == 6 & obj.board.column == 2) = Mult.tripleLetter;
            obj.board.multiplier(obj.board.row == 6 & obj.board.column == 6) = Mult.tripleLetter;
            obj.board.multiplier(obj.board.row == 6 & obj.board.column == 10) = Mult.tripleLetter;
            obj.board.multiplier(obj.board.row == 6 & obj.board.column == 14) = Mult.tripleLetter;
            obj.board.multiplier(obj.board.row == 10 & obj.board.column == 2) = Mult.tripleLetter;
            obj.board.multiplier(obj.board.row == 10 & obj.board.column == 6) = Mult.tripleLetter;
            obj.board.multiplier(obj.board.row == 10 & obj.board.column == 10) = Mult.tripleLetter;
            obj.board.multiplier(obj.board.row == 10 & obj.board.column == 14) = Mult.tripleLetter;
            obj.board.multiplier(obj.board.row == 14 & obj.board.column == 6) = Mult.tripleLetter;
            obj.board.multiplier(obj.board.row == 14 & obj.board.column == 10) = Mult.tripleLetter;
            
            % Double letter scores
            obj.board.multiplier(obj.board.row == 1 & obj.board.column == 4) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 1 & obj.board.column == 12) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 3 & obj.board.column == 7) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 3 & obj.board.column == 9) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 4 & obj.board.column == 1) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 4 & obj.board.column == 8) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 4 & obj.board.column == 15) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 7 & obj.board.column == 3) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 7 & obj.board.column == 7) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 7 & obj.board.column == 9) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 7 & obj.board.column == 13) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 8 & obj.board.column == 4) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 8 & obj.board.column == 12) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 9 & obj.board.column == 3) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 9 & obj.board.column == 7) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 9 & obj.board.column == 9) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 9 & obj.board.column == 13) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 12 & obj.board.column == 1) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 12 & obj.board.column == 8) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 12 & obj.board.column == 15) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 13 & obj.board.column == 7) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 13 & obj.board.column == 9) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 15 & obj.board.column == 4) = Mult.doubleLetter;
            obj.board.multiplier(obj.board.row == 15 & obj.board.column == 12) = Mult.doubleLetter;

            % Initialize turn counter and active player
            obj.turnNo = 1; obj.turnPlayer = 1;

            % Initialize adjacency matrix of the board
            obj.A = eye(15^2);

        end
        
        % Dispense tiles to players, as needed
        obj = dispense(obj, player)
        
        % Visualize grid
        visualize(obj)
        
        % Place a tile on the board
        [obj, isValid] = placeTile(obj, player, character, row, column)

        % Returns a table of all paths, whether they are valid (or,
        % disjointed), the player who last modified them, and whether they
        % contain any grammatical error
        obj = allPaths(obj)
        
    end
    
end