function squares = adjacent(idx)
    % ---------------------------------------------------------------------
    % Get indices of squares adjacent to square specified by index.
    %
    % Input arguments:
    % idx   Int     Index [1, 225] of square
    % ---------------------------------------------------------------------

    % Set placeholder for return value
    squares = [];

    % Get the row and column from the index
    [row, column] = ind2sub([15, 15], idx);

    % Start with vertical neighbor, move clockwise
    if row > 1; new_idx = sub2ind([15, 15], row - 1, column); ...
            squares = [squares new_idx]; end
    if row < 15; new_idx = sub2ind([15, 15], row + 1, column); ...
            squares = [squares new_idx]; end
    if column > 1; new_idx = sub2ind([15, 15], row, column - 1); ...
            squares = [squares new_idx]; end
    if column < 15; new_idx = sub2ind([15, 15], row, column + 1); ...
            squares = [squares new_idx]; end

end