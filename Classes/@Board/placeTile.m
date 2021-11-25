function [obj, isValid] = placeTile(obj, player, character, row, column)

% -------------------------------------------------------------------------
% This function places a tile on the board from a particular player. Note
% that a tile can only be placed if the player possesses one or more of the
% specified letters.
%
% Input arguments
% player        Int     Player who is placing the tile
% character     Letter  Letter that is being placed
% row           Int     Row on which letter is to be placed
% column        Int     Column on which letter is to be placed
% -------------------------------------------------------------------------

% Set default return value
isValid = true;

% Player must be in range [1, obj.numPlayers] (if error, pass input)
player = utils.assign("Board.placeTile()", 1, player, 'double', player, [1,obj.numPlayers]);

% Tile must be of type Letter (if error, pass input)
character = utils.assign("Board.placeTile()", 2, character, 'Letter', character);

% Construct the player name
playerName = "player" + string(player);

% If the player possesses the tile...
if obj.tiles.(playerName)(obj.tiles.character == character) > 0
    
    % Place the tile on the board, and remove from inventory
    obj.board.letter(obj.board.row == row & obj.board.column == column) = character;
    obj.tiles.(playerName)(obj.tiles.character == character) = ...
        obj.tiles.(playerName)(obj.tiles.character == character) - 1;
    
else
    
    % If the player cannot make the move, display error message and return
    % invalid move. Board state unchanged.
    isValid = false; disp("Error in Board.placeTile(): Invalid move.");
    
end

end