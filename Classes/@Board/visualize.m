function visualize(obj)

% -------------------------------------------------------------------------
% Function plots board.
% -------------------------------------------------------------------------

% Create placeholder for grid
board = zeros(15); counter = 0;

% Iteratively populate grid
for i = 1:15
    for j = 1:15
        counter = counter + 1;
        % Assign 0.25 for double letter scores
        if obj.board.multiplier(counter) == Mult.doubleLetter
            board(i,j) = 0.25;
        % Assign 0.5 for triple letter scores
        elseif obj.board.multiplier(counter) == Mult.tripleLetter
            board(i,j) = 0.5;
        % Assign 0.75 for double word scores
        elseif obj.board.multiplier(counter) == Mult.doubleWord
            board(i,j) = 0.75;
        % Assign 1.0 for triple word scores
        elseif obj.board.multiplier(counter) == Mult.tripleWord
            board(i,j) = 1;
        end
    end
end

% Plot imagesc and format gridlines
figure; imagesc(board); colormap(summer); ax = gca; grid on;
ax.XTick = 0.5:1:15.5; ax.XTickLabel = [];
ax.YTick = ax.XTick; ax.YTickLabel = ax.XTickLabel;

% Add letters to plot
counter = 0;
for i = 1:15
    for j = 1:15
        counter = counter + 1;
        % If the letter is not null, plot the letter
        if obj.board.letter(counter) ~= Letter.null
            text(i-0.2, j, upper(obj.board.letter(counter).string()));
        end
    end
end

% Return grid
obj.grid = board;

end