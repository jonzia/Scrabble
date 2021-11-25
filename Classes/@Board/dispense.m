function obj = dispense(obj, player)

% -------------------------------------------------------------------------
% This function dispenses object to the indicated player from the bank. If
% there are not sufficient tiles available, all remaining tiles are
% provided to the player.
%
% Input Arguments
% player    Int     Player to which to dispense tiles
% -------------------------------------------------------------------------

% Add up bank's tiles
bank_tiles = sum(obj.tiles.bank);

% If the bank does not have any tiles, return 0
if bank_tiles == 0; return; end

% Get player name
playerName = "player" + string(player);

% Add up player's tiles
player_tiles = sum(obj.tiles.(playerName));

% Determine number of tiles to dispense to player
numDispense = min(bank_tiles, 7 - player_tiles);

% Enumerate the characters
characters = obj.tiles.character;

% Dispense tiles randomly
% For each tile to dispense...
for i = 1:numDispense
    
    % Return indices of nonzero values from tile quantities
    idx = find(obj.tiles.bank);
    
    % Select a random character
    j = randi(length(idx), 1); character = characters(idx(j));
    
    % Add tile to character, remove from bank
    obj.tiles.bank(obj.tiles.character == character) = obj.tiles.bank(obj.tiles.character == character) - 1;
    obj.tiles.(playerName)(obj.tiles.character == character) = obj.tiles.(playerName)(obj.tiles.character == character) + 1;
    
end

end